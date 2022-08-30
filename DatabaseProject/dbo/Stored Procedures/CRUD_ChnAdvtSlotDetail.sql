
CREATE PROCEDURE [dbo].[CRUD_ChnAdvtSlotDetail]
(
	@Type int=1, -- 1=Get AdtvList 2=Get Slot list 3=Delete Advt in ChnSlotDetail
	@ChnID Dbo.ChnID=NULL,
	@SlotID Int=NULL,
	@ChnContentChildIDs Varchar(Max)=NULL
)
As
Set NoCount ON;
Begin

	Declare @ReturnID NVarchar(Max)

	If @Type=1
	Begin
	Select Isnull(ChnContentChild.ID,0) As[ID],ContentMst.ID As[ContentID],
				ROW_NUMBER() Over(Order by ContentMst.ID Desc) As[SrNo],
				Dbo.GetFileName(Path) As[File],Path As[Particular]				
				From ContentMst Left Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID And ChnContentChild.TrnStatus=1 And ChnContentChild.ChnID=@ChnID
				Where ContentMst.TrnStatus=1 And ContentMst.Type=2 And Dbo.ExistFile(ContentMst.Path)='True'
				And Isnull(ChnContentChild.ID,0)<>0
				Order by ContentMst.ID Desc
		--Select ROW_NUMBER() Over(Order by Path) as [SrNo],ID,Dbo.GetFileName(Path) As[File],Path As[Particular]
		--from ContentMst with (Nolock) 
		--Where TrnStatus=1 and Type=2
		--Order by Path
	End
	If @Type=2
	Begin
		Select ROW_NUMBER() Over(Order by Slot) as [SrNo],ID,Slot as [SlotTime]
		from ChnSlotMst with (Nolock) 
		Where ChnID=@ChnID and TrnStatus=1 And B_SlotType=4
		Order by Slot
	End
	IF @Type=3
	Begin
		Set @ReturnID = (Select STRING_AGG(ID,',') as ID from ChnSlotDetail Where SlotID=@SlotID And ChnContentID In(Select value from string_split(@ChnContentChildIDs,',')) and TrnStatus=1)

		Update ChnSlotDetail Set TrnStatus=2 Where SlotID=@SlotID And ChnContentID In(Select value from string_split(@ChnContentChildIDs,',')) And TrnStatus=1							

		Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnAdvtSlotDetail',@ReturnID ,'True',NULL)
	End
	
End
