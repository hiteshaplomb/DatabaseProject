--Develop 01 04 2022 For Bulk Assign Content To Slot Related Task
CREATE PROCEDURE [dbo].[GetContentWiseSlot]
(
	@ChnID Dbo.ChnID,
	@Type TinyInt, --1-Program 2-Advt 3-Filler
	@B_SlotType Dbo.PID
)
As
Set NoCount ON;
Begin

	Create Table #Temp(SlotID Int,ContentID Int,ID Int,ChnContentID Int)

	Select ContentMst.ID,Dbo.GetFileName(ContentMst.Path) As[FileName],ROW_NUMBER() Over (Order by ContentMst.ID Desc) As[SrNo]
	From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID 
	And ChnContentChild.TrnStatus=1 And ChnContentChild.ChnID=@ChnID
	Where ContentMst.TrnStatus=1 And ContentMst.Type=@Type And Dbo.ExistFile(ContentMst.Path)='True'
	Order By ChnContentChild.Sequence
	
	Insert Into #Temp(SlotID,ContentID,ID,ChnContentID)
	Select ChnSlotMst.ID As[SlotID],ChnContentChild.ContentID,ChnSlotDetail.ID,
	ChnSlotDetail.ChnContentID
	From ChnSlotMst Inner Join ChnSlotDetail On ChnSlotMst.ID = ChnSlotDetail.SlotID 
	Inner Join ChnContentChild On ChnSlotDetail.ChnContentID = ChnContentChild.ID
	Where ChnSlotDetail.TrnStatus=1 And ChnSlotMst.B_SlotType=@B_SlotType 
	And ChnSlotMst.ChnID=@ChnID	And ChnSlotMst.TrnStatus=1

	
	Select TempContent.ID,TempContent.Slot,TempContent.ContentID,Isnull(Temp.ChnContentID,0) As[ChnContentID],
	ROW_NUMBER() Over (Partition By TempContent.ContentID Order by TempContent.Slot) As[SrNo],
	Cast(Case When Temp.ID Is NULL Then 'False' Else 'True' End As Bit) As[Status],
	TempContent.ChnContentChildID
	From
	(
		Select ChnSlotMst.ID,ContentMst.ID As[ContentID],ChnSlotMst.Slot,ContentMst.Path,
		ChnContentChild.ID As[ChnContentChildID]
		From ChnSlotMst Cross Join ContentMst
		Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
		Where ChnSlotMst.B_SlotType=@B_SlotType And ChnSlotMst.TrnStatus=1 And ChnSlotMst.ChnID=@ChnID 
		And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1
		And ContentMst.Type=2 And ContentMst.TrnStatus=1
		And Dbo.ExistFile(ContentMst.Path)='True'
	) As[TempContent]
	Left Join #Temp As[Temp] On TempContent.ID = Temp.SlotID And TempContent.ContentID = Temp.ContentID

	
	Drop Table #Temp
End
