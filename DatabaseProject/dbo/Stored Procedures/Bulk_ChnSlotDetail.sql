--Develop 22 09 2021, Not Any record Should be NULL IF Record Is available In MAster Entry Then This Will Not Insert Main Table But Insert To Child Table.
--This Procedure Drag And Other Purpose.
--When @Type_ContentMst Pass That Time @ChnContentChildIDs Not Used because Both have difference screen.
--@Type_ContentMst = Drage From UserControl Advt/Slot/Child Grid
--@ChnContentChildIDs -- Select Record Open From Advt/Slot/Child Grid/Add New Button
CREATE PROCEDURE [dbo].[Bulk_ChnSlotDetail]
	@ChnID Dbo.ChnID,
	@Type_ContentMst Dbo.Type_ContentMst Readonly,
	@SlotID Int,
	@ChnContentChildIDs Varchar(Max)=NULL, --When Pass That Time @Type_ContentMst Is Not Consider (Both Screen Is Difference).
	@TrnUserID Dbo.TrnUserID,
	@TrnStatus Dbo.TrnStatus
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @Sequence Int=(Select Isnull(Max(Sequence),0) From ChnSlotDetail With(NoLock) Where SlotID=@SlotID)
	Declare @TempReturn Table(ID Int)
	Declare @ReturnID NVarchar(Max)
	Declare @Type_ChnContentChild Dbo.Type_ChnContentChild
	Declare @Type_BulkChnAdvtSlotDetail Dbo.Type_BulkChnAdvtSlotDetail
	

	--Inser Record In ContentMaster
	If Exists(Select 1 From @Type_ContentMst)
	  Begin
			Insert Into ContentMst(Type,Path,TrnUserID,TrnStatus,TrnDate)
			Select Type,Path,@TrnUserID,@TrnStatus,Getdate() From @Type_ContentMst  As[Type_ContentMst]
			Where Not Exists(Select 1 From ContentMst With(NoLock) Where Type=Type_ContentMst.Type And Path=Type_ContentMst.Path And TrnStatus=1)

			Insert Into @Type_ChnContentChild(ID,ContentID,StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun,TrnStatus)
			Select 0,ContentMst.ID,Getdate(),DATEADD(MONTH,1,GETDATE()) -1,'True','True','True','True','True','True','True','True',1
			From ContentMst 
			Inner Join @Type_ContentMst As[Type_ContentMst] On ContentMst.Type=Type_ContentMst.Type And ContentMst.Path=Type_ContentMst.Path
			Where ContentMst.TrnStatus=1
			

			--Record Assign To ChnContentChild Table.
			Insert Into @Type_BulkChnAdvtSlotDetail(ObjName,RefID,IsSuccess,Msg)
			Exec Bulk_ChnContentAssignForAdvt @ChnID,@Type_ChnContentChild,@TrnUserID
			--Exec CRUD_ChnContentChildForAdvt @ChnID,@Type_ChnContentChild,@TrnUserID
		
			Insert Into ChnSlotDetail(SlotID,Sequence,ChnContentID,TrnUserID,TrnStatus)
			Output inserted.ID into @TempReturn
			Select @SlotID,ROW_NUMBER() Over (Order by ChnContentChild.ID) + @Sequence As[Sequence],
			ChnContentChild.ID,@TrnUserID,@TrnStatus
			From ChnContentChild 
			Inner Join ContentMst On ChnContentChild.ContentID=ContentMst.ID
			Inner Join @Type_ContentMst As[Type_ContentMst] On ContentMst.Type=Type_ContentMst.Type And ContentMst.Path=Type_ContentMst.Path 
			Where ContentMst.TrnStatus=1 
			And ChnContentChild.ID In (Select value from string_split((Select RefID From @Type_BulkChnAdvtSlotDetail),','))
	
			Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnSlotDetail',@ReturnID,'True',NULL)
	  End
	Else
	  Begin
			--Insert Record To ContentMst Main Table IF Type And Path Not Found.
			Insert Into ChnSlotDetail(SlotID,Sequence,ChnContentID,TrnUserID,TrnStatus)
			Output inserted.ID into @TempReturn
			Select @SlotID,ROW_NUMBER() Over (Order by ChnContentChild.ID) + @Sequence As[Sequence],
			ID,@TrnUserID,@TrnStatus
			From ChnContentChild Where ID In(Select value from string_split(@ChnContentChildIDs,','))
	
			Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnSlotDetail',@ReturnID ,'True',NULL)
	  End
END
