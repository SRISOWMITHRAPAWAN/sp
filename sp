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


