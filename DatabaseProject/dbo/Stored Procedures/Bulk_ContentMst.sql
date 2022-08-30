--Develop 28 09 2021, Insert Record In ContentMaster Table. 
CREATE PROCEDURE [dbo].[Bulk_ContentMst]
	@Type_ContentMst Dbo.Type_ContentMst Readonly,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
	
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	
	--Insert Record To ContentMst Main Table IF Type And Path Not Found.
	Insert Into ContentMst(Type,Path,TrnUserID,TrnStatus,TrnDate)
	Select Type,Path,@TrnUserID,@TrnStatus,Getdate() From @Type_ContentMst  As[Type_ContentMst]
	Where Not Exists(Select 1 From ContentMst With(NoLock) Where Type=Type_ContentMst.Type And Path=Type_ContentMst.Path And TrnStatus=1)
		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ContentMst',SCOPE_IDENTITY(),'True',NULL)
END
