--Develop 13 05 2022, There is 2 Procedure New Procedure Main Concept is that it is used for ticker only and days and startdate and endate related code removed.
--Drag And Brose From ChannelUserControl Related Task Not Writen here because there is more child table and not handle physical so assign is only work.
CREATE Procedure [dbo].[Bulk_ChnOverlayAssign_2]
	@ChnID Dbo.ChnID,
	@Type tinyInt,  --1=Static 2=Sequence 3-Ticker 7-TextTemplate
	@Type_ChnOverlayChild Type_ChnOverlayChild_2 Readonly, --IT is Fill As Per type Wise.
	@Type_OverlayObject Type_OverlayObject Readonly,
	@TrnUserID Dbo.TrnUserID=NULL
As
SET NOCOUNT ON;
Begin
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @Sequence Int =(Select Isnull(Max(Sequence),0) From ChnOverlayChild With(NoLock) Where ChnID=@ChnID)

	--First Insert Record Which Is not avaialble On Overlaychild Table.
	Insert Into ChnOverlayChild(ChnID,OverlayID,TrnUserID,TrnStatus,TrnDate,Sequence,Type)
	Select @ChnID,OverlayMst.ID,@TrnUserID,Type_ChnOverlayChild.TrnStatus,GetDate(),
	@Sequence + ROW_NUMBER() Over (Order By Getdate()),@Type
	From OverlayMst With(NoLock) Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On OverlayMst.ID=Type_ChnOverlayChild.OverlayID
	Where Isnull(Type_ChnOverlayChild.ID,0)=0

	----Insert Record When Browse And Drag Drop In CG Tab. That Time There Is Not Entry In OverlayMaster And OverlayChild.
	--Insert Into ChnOverlayChild(ChnID,OverlayID,TrnUserID,TrnStatus,TrnDate,Sequence,Type)
	--Select @ChnID,OverlayMst.ID,@TrnUserID,Type_ChnOverlayChild.TrnStatus,GetDate(),
	--@Sequence + ROW_NUMBER() Over (Order By Getdate()),@Type
	--From OverlayMst With(NoLock) Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On OverlayMst.Value=Type_ChnOverlayChild.Path And OverlayMst.Type = Type_ChnOverlayChild.Type
	--Where Isnull(Type_ChnOverlayChild.ID,0)=0 And ISNULL(Type_ChnOverlayChild.OverlayID,0)=0 And OverlayMst.TrnStatus=1

	--Record Update As Per Record Is Already On ChnOverLayChild Table.
	Update COC Set
	TrnStatus=Type_ChnOverlayChild.TrnStatus
	From ChnOverlayChild As[COC] Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On COC.ID = Type_ChnOverlayChild.ID

	--OverlayObject Related Table.
	Insert Into OverlayObject(OverlayID,Name,GroupType)
	Select OverlayID,Name,GroupType
	From @Type_OverlayObject As[Type_OverlayObject] 
	Where Not Exists(Select 1 From OverlayObject Where OverlayID=Type_OverlayObject.OverlayID And Name=Type_OverlayObject.Name)

	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnOverlayAssign_2',0,'True',NULL)

End
