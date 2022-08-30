
CREATE PROCEDURE [dbo].[Bulk_ChnAdvtSlotDetail]
(
	@TrnUserID Dbo.TrnUserID=NULL,
	@Type_ChnAdvtSlotDetail Dbo.Type_ChnAdvtSlotDetail Readonly
)
As
Set NoCount ON;
Begin

	--First Update Record Which Exist In ChnSlotDetail.
	--Update ChnSlotDetail Set TrnStatus=Case When Type_ChnAdvtSlotDetail.Status='True' Then 1 Else 2 End
	--From ChnSlotDetail Inner Join @Type_ChnAdvtSlotDetail  As[Type_ChnAdvtSlotDetail] On ChnSlotDetail.SlotID = Type_ChnAdvtSlotDetail.SlotID And ChnSlotDetail.ChnContentID = Type_ChnAdvtSlotDetail.ChnContentID
	
	Update ChnSlotDetail Set TrnStatus=Case When Type_ChnAdvtSlotDetail.Status='True' Then 1 Else 2 End
	From ChnSlotDetail Inner Join @Type_ChnAdvtSlotDetail  As[Type_ChnAdvtSlotDetail] On ChnSlotDetail.SlotID = Type_ChnAdvtSlotDetail.SlotID And ChnSlotDetail.ChnContentID = Type_ChnAdvtSlotDetail.ChnContentID


	Insert Into ChnSlotDetail(SlotID,Sequence,ChnContentID,TrnUserID,TrnStatus)
	Select  Type_ChnAdvtSlotDetail.SlotID,
	Isnull(Temp.Sequence,0) + ROW_NUMBER() Over (Partition By Type_ChnAdvtSlotDetail.SlotID Order by ChnContentChild.Sequence) As[Sequence],
	Type_ChnAdvtSlotDetail.ChnContentChildID,@TrnUserID,1
	From @Type_ChnAdvtSlotDetail As[Type_ChnAdvtSlotDetail] Inner Join ChnContentChild On Type_ChnAdvtSlotDetail.ChnContentChildID = ChnContentChild.ID
	Left Join
	(
		Select SlotID,ISnull(Max(Sequence),0) As[Sequence] From ChnSlotDetail Group By SlotID
	) As[Temp] On Type_ChnAdvtSlotDetail.SlotID = Temp.SlotID
	Where Isnull(Type_ChnAdvtSlotDetail.ChnContentID,0) = 0 And Type_ChnAdvtSlotDetail.Status='True'
	And Not Exists(Select 1 From ChnSlotDetail Where TrnStatus=1 And SlotID=Type_ChnAdvtSlotDetail.SlotID And  ChnContentID=Type_ChnAdvtSlotDetail.ChnContentChildID)
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnAdvtSlotDetail',0,'True',NULL)
End
