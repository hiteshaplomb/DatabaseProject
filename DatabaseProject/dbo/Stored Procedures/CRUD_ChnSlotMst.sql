CREATE PROCEDURE [dbo].[CRUD_ChnSlotMst]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update | 3=Delete | 4=GetRecord
	@IDs Varchar(Max)=NULL out,
	@B_SlotType Dbo.PID,
	@ChnID Dbo.ChnID,
	@Name Varchar(200)=NULL,
	@Slot Datetime, --Pass TodayDate + HH:mm (25 Dec 2021 15:00)	
	@TrnStatus Dbo.TrnStatus=NULL,
	@TrnUserID Dbo.TrnUserID = NULL
As
SET NOCOUNT ON;
BEGIN

	If @TrnMode=1 -- Insert Record
	  Begin
			Insert Into ChnSlotMst(B_SlotType,ChnID,Slot,Name,TrnStatus,TrnUserID,TrnDate)
	  	   	 Values(@B_SlotType,@ChnID,Cast(@Slot As Time),@Name,1,@TrnUserID,GetDate())
		   
			Set @IDs=SCOPE_IDENTITY()
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnSlotMst',@IDs,'True',NULL)
	  End
	Else If @TrnMode=2 -- Update Record		
		Begin
			Update ChnSlotMst Set Slot=Cast(@Slot As Time),Name=@Name,TrnStatus=Isnull(@TrnStatus,1)
			Where ID In(Select Value From string_split(@IDs,','))

			Update ChnSlotDetail Set TrnStatus=Isnull(@TrnStatus,1)
			Where SlotID In(Select Value From string_split(@IDs,','))
				

			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnSlotMst',@IDs,'True',NULL)
		End		
	
END
