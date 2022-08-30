--exec CRUD_ChnContentPlayLog @StartDate='2022-06-01',@EndDate='2022-06-30',@Type=0,@ChannelID=0,@TrnMode=4
CREATE PROCEDURE [dbo].[CRUD_ChnContentPlayLog]

	@TrnMode Dbo.TrnMode, --1=Insert | 4=GetRecord 
	@ContentID Dbo.PID=NULL,
	@RefID Dbo.PID=NULL,
	@Type TinyInt = NULL,
	@FilePath Varchar(2000)=NULL,
	@Duration Time(7)=NULL,
	@Playtime DateTime=NULL,
	@TrnUserID Dbo.TrnUserID = NULL,
	@StartDate DateTime=NULL,
	@EndDate DateTime=NULL,
	@ChannelID Dbo.PID=NULL
	
As
SET NOCOUNT ON;
BEGIN

	If @TrnMode=1 -- Insert Record
	  Begin			
		  Insert Into ChnContentPlayLog(ContentID,RefID,Type,FilePath,Duration,Playtime,TrnUserID,TrnDate)
		  Values(@ContentID,@RefID,@Type,@FilePath,@Duration,@Playtime,@TrnUserID,GETDATE())
		  		  
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnContentPlayLog',0,'True',NULL)
	  End
	  
	Else If @TrnMode=4 --Get Record
	  Begin
			--Select ChannelMst.Name as [ChannelName], CONVERT(varchar(20), Playtime,113) as [Playtime],
			--Case When ChnContentPlayLog.Type=1 then 'Program' When ChnContentPlayLog.Type=2 Then 'Advt.' when ChnContentPlayLog.Type=3 Then 'Filler' End as [Type] ,CONVERT(varchar(11), Duration,114) as [Duration],FilePath
			--From ChnContentPlayLog
			--Left Join ChnContentChild on ChnContentPlayLog.RefID=ChnContentChild.ID
			--Left Join ChannelMst on ChnContentChild.ChnID=ChannelMst.ID And ChannelMst.TrnStatus=1	
			--Where ChnContentPlayLog.Type in (1,3)
			--And ChnContentPlayLog.TrnDate Between @StartDate And @EndDate

			--UNION ALL

			--Select ChannelMst.Name as [ChannelName],CONVERT(varchar(20), Playtime,113) as [Playtime],
			--Case When ChnContentPlayLog.Type=1 then 'Program' When ChnContentPlayLog.Type=2 Then 'Advt.' when ChnContentPlayLog.Type=3 Then 'Filler' End as [Type] ,CONVERT(varchar(11), Duration,114) as [Duration],FilePath
			--From ChnContentPlayLog
			--Left Join ChnSlotDetail On ChnContentPlayLog.RefID = ChnSlotDetail.ID
			--Left Join ChnSlotMst on ChnSlotDetail.SlotID=ChnSlotMst.ID
			--Left Join ChannelMst On ChnSlotMst.ChnID = ChannelMst.ID and ChannelMst.TrnStatus=1			
			--Where ChnContentPlayLog.Type in (2)
			--And ChnContentPlayLog.TrnDate Between @StartDate And @EndDate
			--Order by Playtime

		declare @SQL nvarchar(max)
		set @SQL='Select ChannelMst.Name as [ChannelName], 
				CONVERT(varchar(20), Playtime,113) as [Playtime],
				Case When ChnContentPlayLog.Type=1 then ''Program'' When ChnContentPlayLog.Type=2 Then ''Advt.'' when ChnContentPlayLog.Type=3 Then ''Filler'' End as [Type] ,
				CONVERT(varchar(11), Duration,114) as [Duration],
				FilePath
				From ChnContentPlayLog
				Left Join ChnContentChild on ChnContentPlayLog.RefID=ChnContentChild.ID
				Inner Join ChannelMst on ChnContentChild.ChnID=ChannelMst.ID And ChannelMst.TrnStatus=1	
				Where ChnContentPlayLog.Type in (1,3)
				And ChnContentPlayLog.TrnDate Between @QStartDate And @QEndDate'
if @Type <> 0 
			set @SQL=@SQL + ' and ChnContentPlayLog.Type=@QType'
if @ChannelID <> 0 
			set @SQL=@SQL + ' and ChannelMst.ID=@QChannelID'

			set @SQL=@SQL + ' UNION ALL '

		set @SQL=@SQL + ' Select ChannelMst.Name as [ChannelName],CONVERT(varchar(20), Playtime,113) as [Playtime],
					Case When ChnContentPlayLog.Type=1 then ''Program'' When ChnContentPlayLog.Type=2 Then ''Advt.'' when ChnContentPlayLog.Type=3 Then ''Filler'' End as [Type] ,CONVERT(varchar(11), Duration,114) as [Duration],FilePath
					From ChnContentPlayLog
					Left Join ChnSlotDetail On ChnContentPlayLog.RefID = ChnSlotDetail.ID
					Left Join ChnSlotMst on ChnSlotDetail.SlotID=ChnSlotMst.ID
					Inner Join ChannelMst On ChnSlotMst.ChnID = ChannelMst.ID And ChannelMst.TrnStatus=1 
					Where ChnContentPlayLog.Type in (2)
					And ChnContentPlayLog.TrnDate Between @QStartDate And @QEndDate'
if @Type <> 0 
			set @SQL=@SQL + ' and ChnContentPlayLog.Type=@QType'
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
