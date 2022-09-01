-- Stored Procedure

--Exec CRUD_ChnOverlayPlayLog @TrnMode=1,@RefID=1
-- =============================================
CREATE PROCEDURE [dbo].[CRUD_ChnOverlayPlayLog]	
	@TrnMode Dbo.TrnMode, --1=Insert | 4=GetRecord 
	@OverlayID Dbo.PID = NULL,
	@FilePath varchar (max) = NULL,
	@Duration time(7) = NULL,
	@Playtime datetime = NULL,
	@OverlayType tinyint = NULL,--1=Stable 2=Sequel
	@Type tinyint = NULL,--1=Program 2=Advertisement 3=Filler
	@RefID dbo.PID = NULL,
	@TrnUserID dbo.TrnUserID = NULL,	
	@StartDate datetime = NULL,
	@EndDate datetime = NULL,	
	@ChannelID Dbo.ChnID = NULL
AS
SET NOCOUNT ON;
	BEGIN
		If @TrnMode=1 -- Insert Record
			BEGIN
				INSERT INTO ChnOverlayPlayLog(OverlayID,FilePath,Duration,Playtime,OverlayType,Type,RefID,TrnUserID,TrnDate)
				Values(@OverlayID,@FilePath,@Duration,@Playtime,@OverlayType,@Type,@RefID,@TrnUserID,GETDATE())
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
if @ChannelID <> 0 
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
if @ChannelID <> 0 
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
			@QChannelID=@ChannelID
	  End
END



