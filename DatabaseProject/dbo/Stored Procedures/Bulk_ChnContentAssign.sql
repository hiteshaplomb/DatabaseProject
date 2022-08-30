--Develop 02 10 2021, Not Any record Should be NULL IF Record Is available In MAster Entry Then This Will Not Insert Main Table But Insert To Child Table.
Create PROCEDURE [dbo].[Bulk_ChnContentAssign]
	@ChnID Dbo.ChnID,
	@ProgramIDs Varchar(Max),
	@AdvtIDs Varchar(Max),
	@SongIDs Varchar(Max),
	@TrnUserID Dbo.TrnUserID=NULL,
	@TrnStatus Dbo.TrnStatus=NULL
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @Sequence Int
	
	Set @Sequence =(Select Isnull(Max(Sequence),0) From ChnContentChild With(NoLock) Where ChnID=@ChnID)
	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence)
	Select @ChnID,ContentMst.ID,@TrnUserID,@TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Path)
	From ContentMst With(NoLock)
	Where ID In(Select Value From string_split(@ProgramIDs,','))
	And ID Not In(Select ContentID From ChnContentChild Where ChnID=@ChnID And Type=1 And TrnStatus=1)

	Set @Sequence =(Select Isnull(Max(Sequence),0) From ChnContentChild With(NoLock) Where ChnID=@ChnID)
	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence)
	Select @ChnID,ContentMst.ID,@TrnUserID,@TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Path)
	From ContentMst With(NoLock)
	Where ID In(Select Value From string_split(@AdvtIDs,','))
	And ID Not In(Select ContentID From ChnContentChild Where ChnID=@ChnID And Type=2 And TrnStatus=1)

	Set @Sequence =(Select Isnull(Max(Sequence),0) From ChnContentChild With(NoLock) Where ChnID=@ChnID)
	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence)
	Select @ChnID,ContentMst.ID,@TrnUserID,@TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Path)
	From ContentMst With(NoLock)
	Where ID In(Select Value From string_split(@SongIDs,','))
	And ID Not In(Select ContentID From ChnContentChild Where ChnID=@ChnID And Type=3 And TrnStatus=1)


	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnContentAssign',0,'True',NULL)
END
