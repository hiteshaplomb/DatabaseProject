--Develop 28 02 2022, It is Used For Advt Related Task.
CREATE Procedure [dbo].[Bulk_ChnContentAssignForAdvt]
	@ChnID Dbo.ChnID,
	@Type_ChnContentChild Dbo.Type_ChnContentChild Readonly,
	@TrnUserID Dbo.TrnUserID=NULL
	
As
SET NOCOUNT ON;
BEGIN
	Declare @Sequence Int=(Select Isnull(Max(Sequence),0) From ChnContentChild With(NoLock) Where ChnID=@ChnID)
	Declare @TempReturn Table(ID Int)
	Declare @ReturnID NVarchar(Max)

	--Where First Time There Is Not ChnContentChild Record That Time.
	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence,
	StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun)
	Output inserted.ID into @TempReturn
	Select @ChnID,Type_ChnContentChild.ContentID,@TrnUserID,Type_ChnContentChild.TrnStatus,GetDate(),
	@Sequence + ROW_NUMBER() Over (Order By ContentMst.Path),
	Cast(Type_ChnContentChild.StartDate As date),Cast(Type_ChnContentChild.EndDate As Date),Type_ChnContentChild.AllDay,
	Type_ChnContentChild.Mon,Type_ChnContentChild.Tue,Type_ChnContentChild.Wed,Type_ChnContentChild.Thu,
	Type_ChnContentChild.Fri,Type_ChnContentChild.Sat,Type_ChnContentChild.Sun
	From @Type_ChnContentChild As[Type_ChnContentChild] 
	Inner Join ContentMst With(NoLock) On Type_ChnContentChild.ContentID = ContentMst.ID
	Where Isnull(Type_ChnContentChild.ID,0)=0
	
	--Record is already In ChnContentChild That tIme Only Update.
	Update CCC Set TrnStatus=Type_ChnContentChild.TrnStatus,StartDate=Cast(Type_ChnContentChild.StartDate As Date),
	EndDate=Cast(Type_ChnContentChild.EndDate As Date),
	AllDay=Type_ChnContentChild.AllDay,Mon=Type_ChnContentChild.Mon,Tue=Type_ChnContentChild.Tue,
	Wed=Type_ChnContentChild.Wed,Thu=Type_ChnContentChild.Thu,Fri=Type_ChnContentChild.Fri,
	Sat=Type_ChnContentChild.Sat,Sun=Type_ChnContentChild.Sun
	From ChnContentChild As[CCC] Inner Join @Type_ChnContentChild As[Type_ChnContentChild] On CCC.ID = Type_ChnContentChild.ID
	
	Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnContentChildForAdvt',@ReturnID,'True',NULL)
	
End
