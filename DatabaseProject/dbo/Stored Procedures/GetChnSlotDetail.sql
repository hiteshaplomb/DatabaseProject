--Develop 28 12 2021
--Changes 12 01 22 SlotDetailID and Other SlotID List
CREATE PROCEDURE [dbo].[GetChnSlotDetail]
(
	@ChnID Dbo.ChnID,
	@B_SlotType Dbo.PID,
	@SlotIDList Varchar(Max)=NULL,
	@SlotDetailIDList Varchar(Max)=NULL
)
As
	Set NoCount ON;
Begin
	Create Table #TempMst(ID Int Primary Key,Name Varchar(Max),Slot Time)

	--This Used Because string_split related issue.
	If Isnull(@SlotIDList,'') = ''
		Insert Into #TempMst(ID,Name,Slot)
		Select ID,Name,Slot
		From ChnSlotMst Where ChnID=@ChnID And TrnStatus=1 And B_SlotType=@B_SlotType
		Order by Slot
	Else
		Insert Into #TempMst(ID,Name,Slot)
		Select ID,Name,Slot
		From ChnSlotMst 
		Where ChnID=@ChnID And TrnStatus=1 And B_SlotType=@B_SlotType
		And ID In (Select value from string_split(@SlotIDList,','))
		Order by Slot


	Select ID,Name,Slot,ROW_NUMBER() Over (Order by Slot) As[SrNo] From #TempMst

	If Isnull(@SlotDetailIDList,'')=''
		Select ChnSlotDetail.ID,ChnSlotDetail.SlotID,ROW_NUMBER() Over(Partition by ChnSlotDetail.SlotID Order by ChnSlotDetail.Sequence) As[SrNo],
		ContentMst.Path,dbo.GetFileName(ContentMst.Path) As[FileName],ChnContentChild.ContentID,
		ChnContentChild.Mon,ChnContentChild.Tue,ChnContentChild.Wed,ChnContentChild.Thu,ChnContentChild.Fri,ChnContentChild.Sat,ChnContentChild.Sun,
		ChnContentChild.StartDate,ChnContentChild.EndDate
		From ChnSlotDetail Inner Join #TempMst As[TempMst] On ChnSlotDetail.SlotID = TempMst.ID
		Inner Join ChnContentChild On ChnSlotDetail.ChnContentID = ChnContentChild.ID
		Inner Join ContentMst On ChnContentChild.ContentID = ContentMst.ID
		Where ChnSlotDetail.TrnStatus=1 And ChnContentChild.TrnStatus=1
	Else
		Select ChnSlotDetail.ID,ChnSlotDetail.SlotID,ROW_NUMBER() Over(Partition by ChnSlotDetail.SlotID Order by ChnSlotDetail.Sequence) As[SrNo],
		ContentMst.Path,dbo.GetFileName(ContentMst.Path) As[FileName],ChnContentChild.ContentID,
		ChnContentChild.Mon,ChnContentChild.Tue,ChnContentChild.Wed,ChnContentChild.Thu,ChnContentChild.Fri,ChnContentChild.Sat,ChnContentChild.Sun,
		ChnContentChild.StartDate,ChnContentChild.EndDate
		From ChnSlotDetail Inner Join #TempMst As[TempMst] On ChnSlotDetail.SlotID = TempMst.ID
		Inner Join ChnContentChild On ChnSlotDetail.ChnContentID = ChnContentChild.ID
		Inner Join ContentMst On ChnContentChild.ContentID = ContentMst.ID
		Where ChnSlotDetail.ID In(Select Value From string_split(@SlotDetailIDList,','))
		And ChnSlotDetail.TrnStatus=1 And ChnContentChild.TrnStatus=1
	
	Drop Table #TempMst
End