select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, 330, MstScd.PlanStart) as StartTime,
    dateadd(Minute, 330, MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	'true' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages,
	TrnTmp.AllowBatch,
	mstrd.status
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	LEFT JOIN  PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstBookUserMapping MstBM with (nolock) ON MstBM.UserID=MstUd.userid
	LEFT JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstBM.BookID and MstFd.PSId =9 LEFT JOIN  PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstBM.BookId and MstBd.PSId =9
	JOIN PS_MstProjectRoleMapping MstPRM with(nolock) on MstPRM.ProjectUserMapId=MstBM.ID
	JOIN PS_MstActivityUserAllocation MStAu with(nolock) on MStAu.RoleId = MstPRM.RoleId
	LEFT JOIN  PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MStAu.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MStAu.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =9
	LEFT JOIN PS_MstRecordDetails_9 MstRd with (nolock) ON MstRd.FileId = 0 and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=10725


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [FileId]
      ,[FileName]
      ,[BookId]
      ,[PSId]
      ,[FileTypeId]
      ,[CategoryId]
      ,[Title]
      ,[BatchId]
      ,[FileNameOriginal]
      ,[PageCountMS]
      ,[PageCountCastoff]
      ,[PageCountPrint]
      ,[kromatixID]
      ,[kromatixGuid]
      ,[FileIdSpace]
      ,[SequenceId]
      ,[ParentId]
      ,[SequenceDOI]
      ,[CreatedDate]
      ,[TransmittalDate]
      ,[SessionID]
      ,[BillingType]
      ,[FileStatus]
      ,[Lock]
  FROM [dbo].[PS_MstFileDetails]


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TemplateId]
      ,[TemplateName]
      ,[TemplateDesc]
      ,[PSId]
      ,[Lock]
  FROM [dbo].[PS_MstTemplateDetails]
  select * from [dbo].[PS_MstTemplateDetails] where PSId=9


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [userid]
      ,[empcode]
      ,[salutation]
      ,[fullname]
      ,[name]
      ,[LastName]
      ,[email]
      ,[email2]
      ,[created]
      ,[gender]
      ,[ShortCode]
      ,[userstatustypeid]
      ,[ruserid_r]
      ,[lock]
      ,[locationid]
      ,[orgid]
      ,[primaryroleid]
      ,[phone]
      ,[UserTypeID]
      ,[ExpertLevel]
      ,[EmailSync]
      ,[JobAssignType]
      ,[TimeZone]
      ,[IsActive]
      ,[Tag]
  FROM [dbo].[PS_MstUserDetails]
  SELECT * FROM [dbo].[PS_MstUserDetails] WHERE userid=10725

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [userstatustypeid]
      ,[userstatustypedesc]
  FROM [dbo].[PS_MstUserStatusTypeDetails]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[FileID]
      ,[UserID]
      ,[IsCorresponding]
      ,[IsOptional]
      ,[Sequence]
      ,[CreatedOn]
      ,[SessionID]
  FROM [dbo].[PS_MstFileUserMapping]
  select * from [dbo].[PS_MstFileUserMapping] where UserID =10725

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[BookID]
      ,[UserID]
      ,[CreatedOn]
      ,[SessionID]
  FROM [dbo].[PS_MstBookUserMapping]

  select * from [dbo].[PS_MstBookUserMapping] where UserID=10725

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [FileId]
      ,[FileName]
      ,[BookId]
      ,[PSId]
      ,[FileTypeId]
      ,[CategoryId]
      ,[Title]
      ,[BatchId]
      ,[FileNameOriginal]
      ,[PageCountMS]
      ,[PageCountCastoff]
      ,[PageCountPrint]
      ,[kromatixID]
      ,[kromatixGuid]
      ,[FileIdSpace]
      ,[SequenceId]
      ,[ParentId]
      ,[SequenceDOI]
      ,[CreatedDate]
      ,[TransmittalDate]
      ,[SessionID]
      ,[BillingType]
      ,[FileStatus]
      ,[Lock]
  FROM [dbo].[PS_MstFileDetails]
  select * from [dbo].[PS_MstFileDetails] where FileId=404 AND PSid=9

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [BookID]
      ,[BookName]
      ,[BookCode]
      ,[BookCodeShort]
      ,[Title]
      ,[TitleAbbrev]
      ,[PSId]
      ,[TemplateId]
      ,[ProjectTypeID]
      ,[ProcessTypeID]
      ,[ProjectIdSpace]
      ,[ProjectStatus]
      ,[BookUpdated]
      ,[IsLiveBook]
      ,[ComplexityID]
      ,[BillingType]
      ,[DOIFormat]
      ,[DOISequence]
      ,[SessionID]
      ,[CreatedDate]
      ,[Lock]
  FROM [dbo].[PS_MstBookDetails]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[ProjectUserMapId]
      ,[RoleId]
      ,[CreatedOn]
      ,[CreatedBy]
  FROM [dbo].[PS_MstProjectRoleMapping]
  select *from [dbo].[PS_MstProjectRoleMapping] where ProjectUserMapId=10725

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[TempId]
      ,[RoleId]
  FROM [dbo].[PS_MstActivityUserAllocation]
  select * from [dbo].[PS_MstActivityUserAllocation] where RoleId=7

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[ScheduleId]
      ,[TempId]
      ,[BatchId]
      ,[FileId]
      ,[PlanStart]
      ,[PlanEnd]
      ,[ActualStart]
      ,[ActualEnd]
      ,[Status]
      ,[Progress]
      ,[Predecessor]
      ,[Predecessors]
      ,[ParentId]
      ,[isHeader]
      ,[Remarks]
  FROM [dbo].[PS_TrnScheduleDetails]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[StageId]
      ,[ActivityId]
      ,[TemplateId]
      ,[ActivityName]
      ,[ActivityNameShort]
      ,[FolderName]
      ,[MenuOrder]
      ,[AllowBatch]
      ,[IsStartUpActivity]
      ,[actuitypeid]
      ,[IsOffLine]
      ,[IsEnabled]
      ,[IsSave]
      ,[IsSaveBG]
      ,[IsReject]
      ,[IsReference]
      ,[IsCancel]
      ,[IsPending]
      ,[IsChecklist]
      ,[IsOutBox]
      ,[IsOutSourcing]
      ,[IsProjectBrief]
      ,[IsSpecialInstruction]
      ,[IsPageRangeRequired]
      ,[IsOpenPageRangeRequired]
      ,[IsEngineActivity]
      ,[BGServiceID]
      ,[NormsId]
      ,[ProcessId]
      ,[IsToMoveEngineNextActivity]
      ,[IsToMoveEnginePreviousActivity]
      ,[IsSequenceFileCheck]
      ,[IsGraphicsActivityId]
      ,[IsFigureTextNeeded]
      ,[IsOnSaveRemarksNeeded]
      ,[IsSkipActivityNeeded]
      ,[IsStageFirstActivity]
      ,[IsStageLastActivity]
      ,[IsStageLastActivityCheckYTS]
      ,[IsVisible]
      ,[IsWeb]
      ,[IsWindows]
      ,[OSType]
      ,[Lock]
      ,[IsVendor]
      ,[Tag]
      ,[TAT]
      ,[FileStatusViewMode]
  FROM [dbo].[PS_TrnTemplateDetails]
  SELECT * FROM [dbo].[PS_TrnTemplateDetails] WHERE ActivityId=526 AND StageId=68
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ActivityId]
      ,[ActivityCode]
      ,[ActivityCodeShort]
      ,[FolderName]
      ,[MenuOrder]
      ,[PSId]
      ,[Tag]
      ,[Lock]
  FROM [dbo].[PS_MstActivityDetails]
  select * from [dbo].[PS_MstActivityDetails] where ActivityCodeShort='AMA'

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [StageId]
      ,[StageDesc]
      ,[StageFolderName]
      ,[MenuOrder]
      ,[PSId]
      ,[IsTransferable]
      ,[IsBrowse]
      ,[IsAllowIssueMakeup]
      ,[IsCore]
      ,[IsRevisionAllowed]
      ,[RevisionMaxCount]
      ,[Tag]
      ,[Lock]
  FROM [dbo].[PS_MstStageDetails]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[BookId]
      ,[BatchID]
      ,[FileId]
      ,[TempId]
      ,[StageId]
      ,[ActivityId]
      ,[LevelId]
      ,[Status]
      ,[LockedBy]
      ,[RejectTemplateId]
      ,[IsEnabled]
      ,[ActivityStatus]
      ,[Productivity]
      ,[CreatedOn]
      ,[UpdateOn]
      ,[ResetLevelId]
      ,[StageLevel]
      ,[Remarks]
      ,[Lock]
  FROM [dbo].[PS_MstRecordDetails_9]

  select *from [dbo].[PS_MstRecordDetails_9] where bookid=373 and ActivityId=526 and StageId=68

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id]
      ,[ProcessTypeID]
      ,[PropertyId]
      ,[FileId]
      ,[Value]
      ,[Lock]
  FROM [dbo].[PS_TrnFilePropertyDetails]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[UserID]
      ,[ReportsTo]
      ,[CreatedOn]
  FROM [dbo].[PS_MstUserReportsToMapping]
  SELECT * FROM [dbo].[PS_MstUserReportsToMapping] where UserID=10725

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [userid]
      ,[empcode]
      ,[salutation]
      ,[fullname]
      ,[name]
      ,[LastName]
      ,[email]
      ,[email2]
      ,[created]
      ,[gender]
      ,[ShortCode]
      ,[userstatustypeid]
      ,[ruserid_r]
      ,[lock]
      ,[locationid]
      ,[orgid]
      ,[primaryroleid]
      ,[phone]
      ,[UserTypeID]
      ,[ExpertLevel]
      ,[EmailSync]
      ,[JobAssignType]
      ,[TimeZone]
      ,[IsActive]
      ,[Tag]
  FROM [dbo].[PS_MstUserDetails]
/****** Object:  StoredProcedure [dbo].[PS_GetUserJobDetailsPersonal]    Script Date: 06-02-2024 19:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Balaji>
-- Create Date: <15-11-2022>
-- Description: <Get the personal jobs allocated>
-- =============================================
-- exec PS_GetUserJobDetailsPersonal 7, 5, '2022-10-10','2022-11-28 23:59:59'
-- exec PS_GetUserJobDetailsPersonal 9, 10725
ALTER PROCEDURE [dbo].[PS_GetUserJobDetailsPersonal]
(
    -- Add the parameters for the stored procedure here
    @PSID int = 0, @UserID int = 0, @StartDate varchar(20)='', @EndDate varchar(20)='', @FileID int = 0, @OffsetMinutes int = 0
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
	
	declare @local_ServiceTypeId int
	Declare @sQry varchar(Max) = ''
	Declare @dateQry varchar(Max) = ''
	Declare @fileQry varchar(Max) = ''

	if @StartDate<>'' and @EndDate<>''
		set @dateQry = ' and PlanStart>= ''' + CONVERT(varchar, @StartDate) + ''' and PlanEnd<=''' + CONVERT(varchar, @EndDate)+''''

	if @FileID > 0
		set @fileQry = ' and MstFilmap.FileID=' + CONVERT(varchar, @FileID)

	if @OffsetMinutes = 0
	Begin
		set @OffsetMinutes = 330
	end
	
	Select @local_ServiceTypeId = ServiceType from PS_MstDetails where Id = @PSID

	
	IF @local_ServiceTypeId = 1
	BEGIN
	set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	LEFT JOIN  PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstBookUserMapping MstBM with (nolock) ON MstBM.UserID=MstUd.userid
	LEFT JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstBM.BookID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	' LEFT JOIN  PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstBM.BookId and MstBd.PSId ='+ CONVERT(varchar, @PSID) +'
	JOIN PS_MstProjectRoleMapping MstPRM with(nolock) on MstPRM.ProjectUserMapId=MstBM.ID
	JOIN PS_MstActivityUserAllocation MStAu with(nolock) on MStAu.RoleId = MstPRM.RoleId
	LEFT JOIN  PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MStAu.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MStAu.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry
	END
	
	IF @local_ServiceTypeId = 2
	BEGIN

set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	JOIN PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstFilmap.FileID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	'JOIN PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstFd.BookId
	JOIN PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MstFilAct.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MstScd.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry

	END
	exec(@sQry)
	print(@sQry)
END

/****** Object:  StoredProcedure [dbo].[PS_GetUserJobDetailsPersonal]    Script Date: 06-02-2024 19:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Balaji>
-- Create Date: <15-11-2022>
-- Description: <Get the personal jobs allocated>
-- =============================================
-- exec PS_GetUserJobDetailsPersonal 7, 5, '2022-10-10','2022-11-28 23:59:59'
-- exec PS_GetUserJobDetailsPersonal 9, 10725
ALTER PROCEDURE [dbo].[PS_GetUserJobDetailsPersonal]
(
    -- Add the parameters for the stored procedure here
    @PSID int = 0, @UserID int = 0, @StartDate varchar(20)='', @EndDate varchar(20)='', @FileID int = 0, @OffsetMinutes int = 0
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
	
	declare @local_ServiceTypeId int
	Declare @sQry varchar(Max) = ''
	Declare @dateQry varchar(Max) = ''
	Declare @fileQry varchar(Max) = ''

	if @StartDate<>'' and @EndDate<>''
		set @dateQry = ' and PlanStart>= ''' + CONVERT(varchar, @StartDate) + ''' and PlanEnd<=''' + CONVERT(varchar, @EndDate)+''''

	if @FileID > 0
		set @fileQry = ' and MstFilmap.FileID=' + CONVERT(varchar, @FileID)

	if @OffsetMinutes = 0
	Begin
		set @OffsetMinutes = 330
	end
	
	Select @local_ServiceTypeId = ServiceType from PS_MstDetails where Id = @PSID

	
	IF @local_ServiceTypeId = 1
	BEGIN
	set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	LEFT JOIN  PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstBookUserMapping MstBM with (nolock) ON MstBM.UserID=MstUd.userid
	LEFT JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstBM.BookID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	' LEFT JOIN  PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstBM.BookId and MstBd.PSId ='+ CONVERT(varchar, @PSID) +'
	JOIN PS_MstProjectRoleMapping MstPRM with(nolock) on MstPRM.ProjectUserMapId=MstBM.ID
	JOIN PS_MstActivityUserAllocation MStAu with(nolock) on MStAu.RoleId = MstPRM.RoleId
	LEFT JOIN  PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MStAu.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MStAu.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry
	END
	
	IF @local_ServiceTypeId = 2
	BEGIN

set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	JOIN PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstFilmap.FileID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	'JOIN PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstFd.BookId
	JOIN PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MstFilAct.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MstScd.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry

	END
	exec(@sQry)
	print(@sQry)
END

/****** Object:  StoredProcedure [dbo].[PS_GetUserJobDetailsPersonal]    Script Date: 06-02-2024 19:34:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Balaji>
-- Create Date: <15-11-2022>
-- Description: <Get the personal jobs allocated>
-- =============================================
-- exec PS_GetUserJobDetailsPersonal 7, 5, '2022-10-10','2022-11-28 23:59:59'
-- exec PS_GetUserJobDetailsPersonal 9, 10725
ALTER PROCEDURE [dbo].[PS_GetUserJobDetailsPersonal]
(
    -- Add the parameters for the stored procedure here
    @PSID int = 0, @UserID int = 0, @StartDate varchar(20)='', @EndDate varchar(20)='', @FileID int = 0, @OffsetMinutes int = 0
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
	
	declare @local_ServiceTypeId int
	Declare @sQry varchar(Max) = ''
	Declare @dateQry varchar(Max) = ''
	Declare @fileQry varchar(Max) = ''

	if @StartDate<>'' and @EndDate<>''
		set @dateQry = ' and PlanStart>= ''' + CONVERT(varchar, @StartDate) + ''' and PlanEnd<=''' + CONVERT(varchar, @EndDate)+''''

	if @FileID > 0
		set @fileQry = ' and MstFilmap.FileID=' + CONVERT(varchar, @FileID)

	if @OffsetMinutes = 0
	Begin
		set @OffsetMinutes = 330
	end
	
	Select @local_ServiceTypeId = ServiceType from PS_MstDetails where Id = @PSID

	
	IF @local_ServiceTypeId = 1
	BEGIN
	set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	LEFT JOIN  PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstBookUserMapping MstBM with (nolock) ON MstBM.UserID=MstUd.userid
	LEFT JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstBM.BookID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	' LEFT JOIN  PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstBM.BookId and MstBd.PSId ='+ CONVERT(varchar, @PSID) +'
	JOIN PS_MstProjectRoleMapping MstPRM with(nolock) on MstPRM.ProjectUserMapId=MstBM.ID
	JOIN PS_MstActivityUserAllocation MStAu with(nolock) on MStAu.RoleId = MstPRM.RoleId
	LEFT JOIN  PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MStAu.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MStAu.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry
	END
	
	IF @local_ServiceTypeId = 2
	BEGIN

set @sQry='select distinct
	MstUd.userid AS UserId,
    MstUd.fullname AS UserName,
    MstUd.empcode AS UserCode,
    MstUd.email AS UserEMail,
    MstUd.userstatustypeid AS UserStatusId,
    MstUsd.userstatustypedesc AS UserStatus,
	MstBd.BookId,MstBd.BookName as ProjectName,
	MstBd.Title,
    MstBd.BookCodeShort AS BookTitle,
	dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanStart) as StartTime,
    dateadd(Minute, '+ ltrim(rtrim(str(@OffsetMinutes))) +', MstScd.PlanEnd) as EndTime,
	TrnTmp.ActivityId,
    MstAd.ActivityCode,
	MstAd.ActivityCodeShort,
    MstFd.FileId,
    MstFd.FileName,
	MstFd.BatchId,
    TrnTmp.StageId,
    MstSd.StageDesc AS StageName,
	TrnTmp.Id as TempId,
	''true'' AS IsScheduled,
	ISNULL (MstRd.Status, 0) AS StatusId,
	ISNULL(MstFileP1.Value, '''') as FileTitle,
	ISNULL(MstFileP.Value, 0) as PageCountMS,	
	ISNULL(MstFileP2.Value, 0) as PDFPages
	from PS_MstUserDetails MstUd
	JOIN PS_MstUserReportsToMapping MstRt with (nolock) ON MstRt.UserID = MstUd.userid
	JOIN PS_MstUserStatusTypeDetails MstUsd with (nolock) ON MstUsd.userstatustypeid = MstUd.userstatustypeid
	JOIN PS_MstFileUserMapping MstFilmap with (nolock) ON MstFilmap.UserID=MstUd.userid
	JOIN PS_MstFileDetails MstFd with (nolock) ON MstFd.FileId=MstFilmap.FileID and MstFd.PSId ='+ CONVERT(varchar, @PSID) +
	'JOIN PS_MstFileActivityMapping MstFilAct with (nolock) ON MstFilAct.FileMapID=MstFilmap.ID
	JOIN PS_MstBookDetails MstBd with (nolock) ON MstBd.BookID=MstFd.BookId
	JOIN PS_TrnScheduleDetails MstScd with (nolock) ON MstScd.FileId = MstFd.FileId and MstScd.TempId=MstFilAct.TempID and MstScd.Status in (0,1)
	JOIN PS_TrnTemplateDetails TrnTmp with (nolock) ON TrnTmp.Id = MstScd.TempId
	JOIN PS_MstActivityDetails MstAd with (nolock) ON MstAd.ActivityId = TrnTmp.ActivityId
    JOIN PS_MstStageDetails MstSd with (nolock) ON MstSd.StageId = TrnTmp.StageId and MstSd.PSId =' + CONVERT(varchar, @PSID) + '
	LEFT JOIN PS_MstRecordDetails_' + CONVERT(varchar, @PSID) + ' MstRd with (nolock) ON MstRd.FileId = MstScd.FileId and MstRd.ActivityId = TrnTmp.ActivityId and MstRd.StageId = TrnTmp.StageId and MstRd.Status <> 4
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP on MstFileP.FileId = MstFd.FileId and MstFileP.PropertyId = 48
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP1 on MstFileP1.FileId = MstFd.FileId and MstFileP1.PropertyId = 63
	LEFT JOIN PS_TrnFilePropertyDetails MstFileP2 on MstFileP2.FileId = MstFd.FileId and MstFileP2.PropertyId = 50
	Where MstRt.UserID=' + CONVERT(varchar, @UserID) + @dateQry + @fileQry

	END
	exec(@sQry)
	print(@sQry)
END

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[BookId]
      ,[BatchID]
      ,[FileId]
      ,[TempId]
      ,[StageId]
      ,[ActivityId]
      ,[LevelId]
      ,[Status]
      ,[LockedBy]
      ,[RejectTemplateId]
      ,[IsEnabled]
      ,[ActivityStatus]
      ,[Productivity]
      ,[CreatedOn]
      ,[UpdateOn]
      ,[ResetLevelId]
      ,[StageLevel]
      ,[Remarks]
      ,[Lock]
  FROM [dbo].[PS_MstRecordDetails_9]
  select * from [dbo].[PS_MstRecordDetails_9] where BookId=373 and ActivityId = 
  526  and status=4

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[BookId]
      ,[BatchID]
      ,[FileId]
      ,[TempId]
      ,[StageId]
      ,[ActivityId]
      ,[LevelId]
      ,[Status]
      ,[LockedBy]
      ,[RejectTemplateId]
      ,[IsEnabled]
      ,[ActivityStatus]
      ,[Productivity]
      ,[CreatedOn]
      ,[UpdateOn]
      ,[ResetLevelId]
      ,[StageLevel]
      ,[Remarks]
      ,[Lock]
  FROM [dbo].[PS_MstRecordDetails_9]
  select * from [dbo].[PS_MstRecordDetails_9] where BookId=373 and ActivityId = 
  526  and status=4
