--Develop 05 02 2022, Insert Record In OverlayMaster Table. 
CREATE PROCEDURE [dbo].[Bulk_OverlayMst]
	@Type_OverlayMst Dbo.Type_OverlayMst Readonly,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
	
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	
	--Insert Record To ContentMst Main Table IF Type And Path Not Found.
	Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate)
	Select 'N/A',Type,Path,@TrnStatus,@TrnUserID,Getdate() From @Type_OverlayMst As[Type_OverlayMst]
	Where Not Exists(Select 1 From OverlayMst With(NoLock) Where Type=Type_OverlayMst.Type And OverlayMst.Value=Type_OverlayMst.Path And TrnStatus=1)
		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_OverlayMst',0,'True',NULL)
END
