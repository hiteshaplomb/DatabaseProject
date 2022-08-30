--Develop 13 01 2022 For Disable ChnSlotDetail Table.
CREATE PROCEDURE [dbo].[CRUD_ChnSlotDetail]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update(Currently Used Only) | 3=Delete 4=GetRecord 5-Used For Auto Entry Time, 
	@ID Varchar(Max),
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL -- Pass 2 For DeActive
	
As
SET NOCOUNT ON;
BEGIN
----------------------------------------------------------------------------------------------------
	If @TrnMode=2 --Update Record Delete Funcationality We Have Not Develop On Status We Save.
	  Begin
		   Update ChnSlotDetail Set TrnStatus=@TrnStatus,TrnUserID=@TrnUserID
		   Where ID In(Select value From string_split(@ID,','))
	  End
		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnSlotDetail',0,'True',NULL)
END
