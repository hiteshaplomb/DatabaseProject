--Develop 02 10 2021, Not Any record Should be NULL IF Record Is available In MAster Entry Then This Will Not Insert Main Table But Insert To Child Table.
create Procedure [dbo].[Bulk_ChnOverlayAssign]
	@ChnID Dbo.ChnID,
	@Type tinyInt, --1=Static 2=Sequence 3-Ticker
	@Type_ChnOverlayChild Type_ChnOverlayChild Readonly, --IT is Fill As Per type Wise.
	@TrnUserID Dbo.TrnUserID=NULL
As
SET NOCOUNT ON;
Begin
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @Sequence Int =(Select Isnull(Max(Sequence),0) From ChnOverlayChild With(NoLock) Where ChnID=@ChnID)
	
	--First Insert Record OverlayMst Which Is Not Availble.
	Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate)
	Select 'N/A',Type,Path,1,@TrnUserID,Getdate() 
	From @Type_ChnOverlayChild As[Type_ChnOverlayChild]
	Where Isnull(ID,0)=0 And Isnull(OverlayID,0)=0 
	And Not Exists(Select 1 From OverlayMst Where TrnStatus=1 And Value=Type_ChnOverlayChild.Path)
	

	--First Insert Record Which Is not avaialble On Overlaychild Table.
	Insert Into ChnOverlayChild(ChnID,OverlayID,TrnUserID,TrnStatus,TrnDate,Sequence,Type,
	StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun)
	Select @ChnID,OverlayMst.ID,@TrnUserID,Type_ChnOverlayChild.TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Getdate()),@Type,
	Isnull(Type_ChnOverlayChild.StartDate,Getdate()),Isnull(Type_ChnOverlayChild.EndDate,DATEADD(MONTH,1,GETDATE()) -1),
	Isnull(Type_ChnOverlayChild.AllDay,'True'),Isnull(Type_ChnOverlayChild.Mon,'True'),Isnull(Type_ChnOverlayChild.Tue,'True'),
	Isnull(Type_ChnOverlayChild.Wed,'True'),Isnull(Type_ChnOverlayChild.Thu,'True'),Isnull(Type_ChnOverlayChild.Fri,'True'),
	Isnull(Type_ChnOverlayChild.Sat,'True'),Isnull(Type_ChnOverlayChild.Sun,'True')
	From OverlayMst With(NoLock) Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On OverlayMst.ID=Type_ChnOverlayChild.OverlayID
	Where Isnull(Type_ChnOverlayChild.ID,0)=0

	--Insert Record When Browse And Drag Drop In CG Tab. That Time There Is Not Entry In OverlayMaster And OverlayChild.
	Insert Into ChnOverlayChild(ChnID,OverlayID,TrnUserID,TrnStatus,TrnDate,Sequence,Type,
	StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun)
	Select @ChnID,OverlayMst.ID,@TrnUserID,Type_ChnOverlayChild.TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Getdate()),@Type,
	Isnull(Type_ChnOverlayChild.StartDate,Getdate()),Isnull(Type_ChnOverlayChild.EndDate,DATEADD(MONTH,1,GETDATE()) -1),
	Isnull(Type_ChnOverlayChild.AllDay,'True'),Isnull(Type_ChnOverlayChild.Mon,'True'),Isnull(Type_ChnOverlayChild.Tue,'True'),
	Isnull(Type_ChnOverlayChild.Wed,'True'),Isnull(Type_ChnOverlayChild.Thu,'True'),Isnull(Type_ChnOverlayChild.Fri,'True'),
	Isnull(Type_ChnOverlayChild.Sat,'True'),Isnull(Type_ChnOverlayChild.Sun,'True')
	From OverlayMst With(NoLock) Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On OverlayMst.Value=Type_ChnOverlayChild.Path And OverlayMst.Type = Type_ChnOverlayChild.Type
	Where Isnull(Type_ChnOverlayChild.ID,0)=0 And ISNULL(Type_ChnOverlayChild.OverlayID,0)=0 And OverlayMst.TrnStatus=1


	
	--Record Update As Per Record Is Already On ChnOverLayChild Table.
	Update COC Set
	TrnStatus=Type_ChnOverlayChild.TrnStatus,StartDate=Type_ChnOverlayChild.StartDate,EndDate=Type_ChnOverlayChild.EndDate,
	AllDay=Type_ChnOverlayChild.AllDay,Mon=Type_ChnOverlayChild.Mon,Tue=Type_ChnOverlayChild.Tue,
	Wed=Type_ChnOverlayChild.Wed,Thu=Type_ChnOverlayChild.Thu,Fri=Type_ChnOverlayChild.Fri,
	Sat=Type_ChnOverlayChild.Sat,Sun=Type_ChnOverlayChild.Sun
	From ChnOverlayChild As[COC] Inner Join @Type_ChnOverlayChild As[Type_ChnOverlayChild] On COC.ID = Type_ChnOverlayChild.ID

	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnOverlayAssign',0,'True',NULL)

End
