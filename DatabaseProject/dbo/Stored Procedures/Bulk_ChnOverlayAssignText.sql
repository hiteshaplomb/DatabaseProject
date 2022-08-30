
--Develop 02 10 2021, Not Any record Should be NULL IF Record Is available In MAster Entry Then This Will Not Insert Main Table But Insert To Child Table.
CREATE Procedure [dbo].[Bulk_ChnOverlayAssignText]
	@ChnID Dbo.ChnID,
	@Type tinyInt, --1=Static 2=Sequence 3-Ticker 7-TextTemplate
	@Type_ChnOverlayChild Type_ChnOverlayChild_3 Readonly, --IT is Fill As Per type Wise.
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
	TrnStatus=Type_ChnOverlayChild.TrnStatus,ShowTime=Type_ChnOverlayChild.ShowTime, EndTime=Type_ChnOverlayChild.EndTime,HideTime=Type_ChnOverlayChild.HideTime,IsDispProgram=Type_ChnOverlayChild.IsDispProgram,IsDispAdvt =Type_ChnOverlayChild.IsDispAdvt,IsDispFiller=Type_ChnOverlayChild.IsDispFiller
	From ChnOverlayChild As[COC] Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On COC.ID = Type_ChnOverlayChild.ID

	--OverlayObject Related Table.
	Insert Into OverlayObject(OverlayID,Name,GroupType)
	Select OverlayID,Name,GroupType
	From @Type_OverlayObject As[Type_OverlayObject] 
	Where Not Exists(Select 1 From OverlayObject Where OverlayID=Type_OverlayObject.OverlayID And Name=Type_OverlayObject.Name)

	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnOverlayAssignText',0,'True',NULL)

	
End


