-- Stored Procedure

--Exec CRUD_ChnOverlayPlayLog @TrnMode=1,@RefID=1
-- =============================================
CREATE PROCEDURE [dbo].[CRUD_ChnOverlayPlayLog]	
	@TrnMode Dbo.TrnMode, --1=Insert | 4=GetRecord 
	@ChnID Dbo.ChnID = NULL,
	@OverlayID Dbo.PID = NULL,
	@OverlayChildID Dbo.PID =NULL,
	@FilePath varchar (max) = NULL,
	@Duration time(7) = NULL,
	@Playtime datetime = NULL,
	@Sequence int = NULL,
	@OverlayType tinyint = NULL,--1-Image 2-SequenceImage 3-Text 4-Ticker 5-TemplateFilePath 6-Flash 7-TextTemplate 8-PIP
	@Type tinyint = NULL,--1=Stable 2=Sequel
	@RefID dbo.PID = NULL,
	@StartDate datetime = NULL,
	@EndDate datetime = NULL,
	@AllDay bit = NULL,
	@Mon bit = NULL,
	@Tue bit = NULL,
	@Wed bit = NULL,
	@Thu bit = NULL,
	@Fri bit = NULL,
	@Sat bit = NULL,
	@Sun bit = NULL,
	@XMLData varchar(max) = NULL,
	@IsDispProgram bit = NULL,
	@IsDispFiller bit = NULL,
	@IsDispAdvt bit = NULL,	
	@TrnUserID dbo.TrnUserID = NULL,
	@TrnStatus dbo.TrnStatus = NULL,
	@TrnDate dbo.TrnDate = NULL
AS
SET NOCOUNT ON;
	BEGIN
		If @TrnMode=1 -- Insert Record
			BEGIN
				INSERT INTO ChnOverlayPlayLog(ChnID,OverlayID,OverlayChildID,FilePath,Duration,Playtime,Sequence,OverlayType,Type,RefID,StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun,XMLData,IsDispProgram,IsDispFiller,IsDispAdvt,TrnUserID,TrnStatus,TrnDate)
				Values(@ChnID,@OverlayID,@OverlayChildID,@FilePath,@Duration,@Playtime,@Sequence,@OverlayType,@Type,@RefID,@StartDate,@EndDate,@AllDay,@Mon,@Tue,@Wed,@Thu,@Fri,@Sat,@Sun,@XMLData,@IsDispProgram,@IsDispFiller,@IsDispAdvt,@TrnUserID,@TrnStatus,GETDATE())
			Print '1'
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnOverlayPlayLog',0,'True',NULL)				
			Print '2'
			END
				Else If @TrnMode=4 --Get Record
	  Begin			
		Print '3'
		declare @SQL nvarchar(max)
		set @SQL='SELECT ChannelMst.Name AS [ChannelName],
					CONVERT(varchar(20), Playtime,113) as [Playtime],
					Case When ChnOverlayPlayLog.Type=1 then ''Sequence'' When ChnOverlayPlayLog.Type=2 Then ''Static'' End as [Type] ,
					CONVERT(varchar(11), Duration,114) as [Duration],ChnOverlayPlayLog.FilePath
					FROM ChnOverlayPlayLog
					LEFT JOIN ChnOverlayChild on ChnOverlayPlayLog.RefID=ChnOverlayChild.ID
					LEFT JOIN ChannelMst on ChnOverlayChild.ChnID=ChannelMst.ID AND ChannelMst.TrnStatus=1
					Where ChnOverlayPlayLog.Type in (1,3)
					And ChnOverlayPlayLog.TrnDate Between @QStartDate And @QEndDate'
					
if @Type <> 0 
			set @SQL=@SQL + ' and ChnOverlayPlayLog.Type=@QType'
if @ChnID <> 0 
			set @SQL=@SQL + ' and ChannelMst.ID=@QChannelID'

			set @SQL=@SQL + ' UNION ALL '

		set @SQL=@SQL + ' SELECT ChannelMst.Name AS [ChannelName],
					CONVERT(varchar(20), Playtime,113) as [Playtime],
					Case When ChnOverlayPlayLog.Type=1 then ''Sequence'' When ChnOverlayPlayLog.Type=2 Then ''Static'' End as [Type] ,
					CONVERT(varchar(11), Duration,114) as [Duration],ChnOverlayPlayLog.FilePath
					FROM ChnOverlayPlayLog
					LEFT JOIN ChnOverlayChild on ChnOverlayPlayLog.RefID=ChnOverlayChild.ID
					LEFT JOIN ChannelMst on ChnOverlayChild.ChnID=ChannelMst.ID AND ChannelMst.TrnStatus=1
					Where ChnOverlayPlayLog.Type in (2)
					And ChnOverlayPlayLog.TrnDate Between @QStartDate And @QEndDate'
if @Type <> 0 
			set @SQL=@SQL + ' and ChnOverlayPlayLog.Type=@QType'
if @ChnID <> 0 
			set @SQL=@SQL + ' and ChannelMst.ID=@QChannelID'
			
set @SQL=@SQL + ' Order by Playtime'

SET NOCOUNT ON;   
EXECUTE sp_executesql @SQL,
		 N' @QStartDate Datetime,
			@QEndDate Datetime,
			@QType Dbo.PID,
			@QChannelID Dbo.PID',
			@QStartDate=@StartDate, 
			@QEndDate=@EndDate,
			@QType=@Type,
			@QChannelID=@ChnID
	  End
END



