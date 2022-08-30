--Develop 22 09 2021, Not Any record Should be NULL IF Record Is available In MAster Entry Then This Will Not Insert Main Table But Insert To Child Table.
--Only
CREATE PROCEDURE [dbo].[Bulk_ChnContentChild]

	@ChnID Dbo.ChnID,
	@Type_ContentMst Dbo.Type_ContentMst Readonly,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
	
	
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @Sequence Int=(Select Isnull(Max(Sequence),0) From ChnContentChild With(NoLock) Where ChnID=@ChnID)
	Declare @TempReturn Table(ID Int)
	Declare @ReturnID NVarchar(Max)

	--Insert Record To ContentMst Main Table IF Type And Path Not Found.
	Insert Into ContentMst(Type,Path,TrnUserID,TrnStatus,TrnDate)
	Select Type,Path,@TrnUserID,@TrnStatus,Getdate() From @Type_ContentMst  As[Type_ContentMst]
	Where Not Exists(Select 1 From ContentMst With(NoLock) Where Type=Type_ContentMst.Type And Path=Type_ContentMst.Path And TrnStatus=1)

	--Insert Program And Filler
	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence)
	Output inserted.ID into @TempReturn
	Select @ChnID,ContentMst.ID,@TrnUserID,@TrnStatus,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Type_ContentMst.Path)
	From ContentMst With(NoLock) Inner Join @Type_ContentMst As[Type_ContentMst] On ContentMst.Path = Type_ContentMst.Path And ContentMst.Type = Type_ContentMst.Type
	Where Type_ContentMst.Type<>2 And ContentMst.TrnStatus=1 
	--And Not Exists(Select 1 From ChnContentChild Where ChnID=@ChnID And ContentID=ContentMst.ID And TrnStatus=1)




	Insert Into ChnContentChild(ChnID,ContentID,TrnUserID,TrnStatus,TrnDate,Sequence,
	StartDate,EndDate,AllDay,Mon,Tue,Wed,Thu,Fri,Sat,Sun)
	Output inserted.ID into @TempReturn
	Select @ChnID,ContentMst.ID,@TrnUserID,2,GetDate(),@Sequence + ROW_NUMBER() Over (Order By Type_ContentMst.Path),
	GETDATE(),DATEADD(MONTH,1,GETDATE()) -1,'True','True','True','True','True','True','True','True'
	From ContentMst With(NoLock) Inner Join @Type_ContentMst As[Type_ContentMst] On ContentMst.Path = Type_ContentMst.Path And ContentMst.Type = Type_ContentMst.Type
	Where Type_ContentMst.Type=2 And ContentMst.TrnStatus=1
	--And Not Exists(Select 1 From ChnContentChild Where ChnID=@ChnID And ContentID=ContentMst.ID And TrnStatus=1)


	Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnContentChild',@ReturnID ,'True',NULL)
	  

	
END
