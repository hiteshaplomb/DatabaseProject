--Develop 22 Nov 2021, Special Develop For Logo Related This Is Only Patch Because Client Need To Setup.
CREATE PROCEDURE [dbo].[CRUD_OverlayMst_1]
	@ChnID Dbo.ChnID,
	@Name Varchar(250)=NULL,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL,
	@XMLData Varchar(Max)=NULL
As
SET NOCOUNT ON;
Begin
	Update Top(1) OverlayMst Set XMLData=@XMLData,Name=@Name
	From OverlayMst Inner Join ChannelMst On OverlayMst.ID = ChannelMst.LogoID
	Where ChannelMst.ID=@ChnID

	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_OverlayMst_1',0,'True',NULL)
End