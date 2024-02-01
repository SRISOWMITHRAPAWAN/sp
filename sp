ALTER PROCEDURE [dbo].[PS_GetUserLoad]
(
    -- Add the parameters for the stored procedure here
    @PSID int,
	@UserID int,
	@RoleID int = 0,
	@SecRoleID varchar(max) = '',
	@BookID int = 0,
	@FilterOptions varchar(max) = '',
	@ReportsTo int = 0
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON
	declare @local_ServiceTypeId int
	 declare @sQry varchar(max) =''
	 Declare @ProjBillAddQ varchar(max) =''
Declare @con1 varchar(max) =''
Declare @con2 varchar(max) =''
Declare @con3 varchar(max) =''
Declare @con4 varchar(max) =''
Declare @con5 varchar(max) =''
Declare @BatchStatAddQ varchar(max) =''
Declare @LocStatAddQ varchar(max) =''
Declare @RoleDet varchar(max) =''
Declare @BookDet varchar(max) =''
Declare @BookDet1 varchar(max) =''
Declare @SecRoleDet varchar(max) = ''
Declare @ReportsDet varchar(max) = ''
Declare @ReportsUserDet varchar(max) = ''
Declare @ActRole varchar(max) = ''
   declare @BillIds varchar(100) = ''
Declare @ReportsToUser varchar(max) = ' MstBM.UserID'
   declare @UserBookMap varchar(max) = ''
   Declare @RoleMap varchar(max) = ' '
   declare 
@ProjectIds as varchar(max) = '',
@BatchIds as varchar(max) = '',
@FileIds as varchar(max) = '',
@BillingTypeIds as varchar(max) ='',
@BatchStatusIds as varchar(max) ='',
@LocationIds as varchar(max) ='',
@ProjectBillingTypeIds as varchar(max) = ''

   IF @FilterOptions != ''
   BEGIN
	select @ProjectIds=ProjectIds, @BatchIds=BatchIds, @FileIds=FileIds, @BillingTypeIds=BillingTypeIds,@BatchStatusIds=BatchStatusIds,@LocationIds=LocationIds, @ProjectBillingTypeIds=ProjectBillingTypeIds  FROM  dbo.fnGetFilersV2 (@FilterOptions)
	END


   IF @FilterOptions != ''
   BEGIN
  select @BillIds = STUFF(( SELECT ',' +  rtrim(ltrim(str(ID)))  FROM  dbo.fnGetFilers('FileInfo', @FilterOptions) where TYP='BillingTypeIds' FOR XML PATH('') ), 1, 1, '')
  END

     IF @ProjectIds != ''
   BEGIN
	SET @con3 = ' and MstFil.BookId in ('+convert(varchar,@ProjectIds)+')'
   END

        IF @BatchIds != ''
   BEGIN
	SET @con4 = ' and MstFil.BatchId in ('+convert(varchar,@BatchIds)+')'
   END

        IF @FileIds != ''
   BEGIN
	SET @con5 = ' and MstFil.FileId in ('+convert(varchar,@FileIds)+')'
   END

		if @BillingTypeIds !=''
BEGIN
	set @con1 = ' and MstFil.BillingType in ('+convert(varchar,@BillingTypeIds)+') '
END

        IF @LocationIds != ''
   BEGIN
	SET @LocStatAddQ = ' and MstFilLoc.LocationID in ('+convert(varchar,@LocationIds)+')'
   END
   
        IF @BatchStatusIds != ''
   BEGIN
	SET @BatchStatAddQ = ' and MstBT.BatchStatus in ('+convert(varchar,@BatchStatusIds)+')'
   END
   IF @RoleID != 0
   BEGIN
   SET @RoleDet = ' join PS_MstProjectRoleMapping MstPR with(nolock) on MstPR.ProjectUserMapId=MstBM.ID and MstPR.RoleID in  ( '+convert(varchar,@RoleID)+' ) '
   END

   IF @ProjectBillingTypeIds != ''
   BEGIN
	SET @ProjBillAddQ = ' and MstBD.BillingType in ('+convert(varchar,@ProjectBillingTypeIds)+')'
   END
   
   IF @BookID != 0
   BEGIN
	   SET @BookDet = ' and MstBM.BookID in ('+convert(varchar,@BookID)+') '
	   SET @BookDet1 = ' and MstBUM.BookID in ('+convert(varchar,@BookID)+') '
	   SET @ActRole = ' and ActingRoleDesc!='''' '
	   SET @UserBookMap = ' and MstPSU.userid=MstBM.UserID '
   END
   
   
   IF @ReportsTo != 0
   BEGIN
	SET @ReportsDet = ' join PS_MstUserReportsToMapping MstUM with(nolock) on  MstUM.ReportsTo='+ convert(varchar,@UserID)+' '
	SET @ReportsToUser = ' MstUM.UserId '
	SET @ReportsUserDet = ' and MstPSU.UserId = MstUM.UserId  '
   END
   IF @SecRoleID !=''
   BEGIN
   SET @SecRoleDet = ' and  MstRd1.id in ('+(CONVERT(varchar,@SecRoleID))+') '
   SET @RoleMap = ' and (MstU.primaryroleid in ('+(CONVERT(varchar,@SecRoleID))+')  or (select count(roleid) from PS_trnRolewiseEmpdetails where userid=Mstu.userid and RoleId in ( '+(CONVERT(varchar,@SecRoleID))+') ) > 0) '
   END
   Print(@SecRoleDet)
	Select @local_ServiceTypeId = ServiceType from PS_MstDetails where Id = @PSID

	Print(@local_ServiceTypeId)

	IF @local_ServiceTypeId = 1
	BEGIN
		set @sQry = 'select * from 
( select fullname, userid,ExpertLevel, Expert, locationid, locationdesc, Role,primaryroleid,Email, (
select count(Mstb.Bookid) as bid
		  from PS_MstBookDetails Mstb
		  join PS_MstBookUserMapping MstUmap on Mstb.BookID=MstUmap.BookID and  MstUmap.userid=s.userid 
		  where Mstb.PSId='+ convert(varchar,@PSID)+' --and Mstb.BookID=s.BookID 
)

as Books, sum(NoOfPages) as NoOfPages,
					   ltrim(isnull((STUFF((SELECT '', ''+ rtrim(ltrim(str(TrnRd.RoleId))) [text()]
			   from PS_trnRolewiseEmpdetails TrnRd with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = TrnRd.RoleId '+ @SecRoleDet + '
			   where userid=s.userid and (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid)
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as SecondaryRoleID,
ltrim(isnull((STUFF((SELECT '', '' + MstRd1.Role [text()]
			   from PS_trnRolewiseEmpdetails TrnRd with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = TrnRd.RoleId '+ @SecRoleDet + '
			   where userid=s.userid and (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid)
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as SecondaryRoleDesc,
ltrim(isnull((STUFF((SELECT '', '' + MstRd1.Role [text()]
			   from PS_MstProjectRoleMapping MstPR with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = MstPR.RoleId 
			   Join PS_MstBookUserMapping MstBUM with(nolock) on MstBUM.ID=MstPR.ProjectUserMapId '+ @BookDet1 +'
			   where MstBUM.UserID=s.userid and (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid) 
			   group by MstRd1.Role
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as ActingRoleDesc
		from
		(
		select MstU.fullname,MstU.userid,  MstU.ExpertLevel,MstExL.Description as Expert, MstU.locationid,MstL.locationdesc, MstRD.Role,MstU.primaryroleid, MstU.Email,0 as NoOfPages  from
		PS_MstBookDetails  MstBD with(nolock)
		
		join PS_MstBookUserMapping MstBM  on MstBM.BookID = MstBD.BookID  
		'+ @ReportsDet+'
		'+ @RoleDet +'
		JOIN PS_MstPSRightsDetails MstPSU with(nolock) on  MstPSU.PSId='+ convert(varchar,@PSID)+' '+ @UserBookMap + @ReportsUserDet +'
		LEFT JOIN PS_MstBookUserMapping MstBM1 with(nolock) on MstBM1.UserID=MstPSU.userid
		--join PS_MstBookDetails MstBD with(nolock) on  MstBD.PSId='+ convert(varchar,@PSID)+' and MstBD.BookID = MstBM1.BookID
		join PS_MstUserDetails MstU with(nolock) on MstU.userid=MstPSU.UserId 
		join PS_MstRoleDetails MstRD with(nolock) on MstRD.ID=MstU.primaryroleid
		join PS_MstUserExpertLevel MstExL with(nolock) on MstExL.ID=MstU.ExpertLevel
		left join PS_MstLocation MstL with(nolock) on MstL.locationid = Mstu.locationid
		where MstBM.UserID = '+ @ReportsToUser+' '+ @BookDet + @ProjBillAddQ+ '
		and MstBD.PSId='+ convert(varchar,@PSID)+ @RoleMap + '
		Group by MstU.fullname,MstU.userid, MstU.ExpertLevel,MstU.locationid,MstRD.Role,MstU.primaryroleid,MstU.Email,MstExL.Description,MstL.locationdesc, MstBD.BookID
		) as s group by fullname,userid, ExpertLevel, Expert, locationid, locationdesc, Role,primaryroleid,Email ) as s2 where SecondaryRoleID != '''' '+ @ActRole +' '
	END
	IF @local_ServiceTypeId = 2
	BEGIN
		set @sQry = 'select * from 
( select fullname,userid, ExpertLevel, Expert, locationid, locationdesc, Role,primaryroleid,Email, count(1) as Books, sum(NoOfPages) as NoOfPages,
					   ltrim(isnull((STUFF((SELECT '', ''+ rtrim(ltrim(str(TrnRd.RoleId))) [text()]
			   from PS_trnRolewiseEmpdetails TrnRd with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = TrnRd.RoleId '+ @SecRoleDet + '
			   where userid=s.userid and  (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid)
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as SecondaryRoleID,
ltrim(isnull((STUFF((SELECT ''~ '' + MstRd1.Role [text()]
			   from PS_trnRolewiseEmpdetails TrnRd with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = TrnRd.RoleId '+ @SecRoleDet + '
			   where userid=s.userid and (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid)
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as SecondaryRoleDesc,
ltrim(isnull((STUFF((SELECT '', '' + MstRd1.Role [text()]
			   from PS_MstProjectRoleMapping MstPR with(nolock)
			   LEFT JOIN PS_MstRoleDetails MstRd1 with(nolock) ON MstRd1.ID = MstPR.RoleId 
			   Join PS_MstBookUserMapping MstBUM with(nolock) on MstBUM.ID=MstPR.ProjectUserMapId
			   where MstBUM.UserID=s.userid and (MstRd1.ID != s.primaryroleid or MstRd1.ID = s.primaryroleid)
			   FOR XML PATH(''''), TYPE)
			   .value(''.'',''NVARCHAR(MAX)''),1,1,'''')), '''')) as ActingRoleDesc
		from
		(
		select MstU.fullname,MstU.userid,  MstU.ExpertLevel,MstExL.Description as Expert, MstU.locationid,MstL.locationdesc, MstRD.Role,MstU.primaryroleid,MstU.Email, (select Isnull(Sum(CAST(value as int)),0) from PS_TrnFilePropertyDetails where FileId in (select MstFil.FileId from PS_MstFileDetails MstFil
		left join PS_MstFileLocationMapping MstFilLoc with(nolock) on MstFilLoc.FileID = MstFil.FileId
		left join PS_MstLocation MstLoc with(nolock) on MstLoc.LocationId = MstFilLoc.LocationID
		where MstFil.BookId=MstBD.BookId '+ @con1 + @con3+ @con4 + @con5 + @LocStatAddQ +') and FileId not in (select fileid from PS_MstRecordDetails_'+ convert(varchar,@PSID)+'  where Status in (4) and ActivityId in (select top 1 ActivityId from PS_MstActivityDetails where PSId='+ convert(varchar,@PSID)+'  and Tag like ''%;articlepublished;%''))  and PropertyId=50) NoOfPages  from
		PS_MstBookUserMapping MstBM
		'+ @ReportsDet+'
		'+ @RoleDet +'
		JOIN PS_MstPSRightsDetails MstPSU with(nolock) on  MstPSU.PSId='+ convert(varchar,@PSID)+' and MstPSU.IsDefault=''Y'' '+ @UserBookMap + @ReportsUserDet +'
		join PS_MstBookDetails MstBD with(nolock) on  MstBD.PSId='+ convert(varchar,@PSID)+' and MstBD.BookID = MstBM.BookID
		join PS_MstUserDetails MstU with(nolock) on MstU.userid=MstPSU.UserId '+ @RoleDet +'
		join PS_MstRoleDetails MstRD with(nolock) on MstRD.ID=MstU.primaryroleid
		join PS_MstBookDetails MstBD1 with(nolock) on  MstBD1.PSId='+ convert(varchar,@PSID)+' and MstBD1.BookID = MstBM.BookID
		join PS_MstUserExpertLevel MstExL with(nolock) on MstExL.ID=MstU.ExpertLevel
		left join PS_MstLocation MstL with(nolock) on MstL.locationid = Mstu.locationid
		where MstBM.UserID = '+ @ReportsToUser+' '+ @BookDet+ @ProjBillAddQ +'
		Group by MstU.fullname,MstU.userid, MstU.ExpertLevel,MstU.locationid,MstRD.Role,MstU.primaryroleid,MstU.Email,MstExL.Description,MstL.locationdesc, MstBD.BookID
		) as s group by fullname, userid,ExpertLevel, Expert, locationid, locationdesc, Role,primaryroleid,Email ) as s2 where SecondaryRoleID != '''' '+ @ActRole +' '
	END
	Exec(@sQry)
	Print(@sQry)
END
