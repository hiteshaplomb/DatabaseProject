--Develop 25 12 2021,Create Bulk Insert Slot And also Check 
CREATE Procedure [dbo].[Bulk_ChnSlotMst]
	@B_SlotType Dbo.PID,
	@ChnID Dbo.ChnID,
	@StartSlot Datetime, --Pass TodayDate + HH:mm (25 Dec 2021 15:00)
	@LastSlot Datetime, --Pass TodatDate + HH:mm (25 Dec 2021 23:00)
	@Interval Int, --Pass Minute Every That Time It will create new slot.
	@TrnUserID Dbo.TrnUserID=NULL
	
As
SET NOCOUNT ON;
Begin
	Declare @TempReturn Table(ID BigInt)
	Declare @ReturnIDs NVarchar(Max)
	While @StartSlot <= @LastSlot
	  Begin
	  	   --Set @StartSlot = DATEADD(MINUTE,@Interval,@StartSlot)
	  	   
	  	   If Cast(@StartSlot As date) = Cast(@LastSlot As Date) 
	  	   And Not Exists(Select 1 From ChnSlotMst With(NoLock) Where ChnID=@ChnID And B_SlotType=@B_SlotType And Slot=Format(@StartSlot,'HH:mm:ss') And TrnStatus=1)
	  	     Insert Into ChnSlotMst(B_SlotType,ChnID,Slot,TrnStatus,TrnUserID,TrnDate)
			 Output inserted.ID Into @TempReturn
	  	   	 Values(@B_SlotType,@ChnID,Cast(@StartSlot As Time),1,@TrnUserID,GetDate())

			 Set @StartSlot = DATEADD(MINUTE,@Interval,@StartSlot)
	  End

	Set @ReturnIDs = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnSlotMst',@ReturnIDs,'True',NULL)
End
