--Develop 02 11 2021
CREATE PROCEDURE [dbo].[CRUD_ChnContentOtherInfo]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update | 3=Delete 4=GetRecord 5-Used For Auto Entry Time
	@ID BigInt =NULL out,
	@ChnID Dbo.ChnID=NULL,
	@ContentID Dbo.PID=NULL,
	@VideoFormat Varchar(500)=NULL,
	@AudioFormat Varchar(500)=NULL,
	@Language Varchar(500)=NULL,
	@CCType TinyInt=NULL, --1=Inbuilt 2=External File
	@CCSource Varchar(500)=NULL,
	@TrnUserID Dbo.TrnUserID = NULL
As
SET NOCOUNT ON;
BEGIN
	Declare @ErrorMsg Varchar(Max)=''

	If @TrnMode=1 --Insert Record.
	  Begin
		  Insert Into ChnContentOtherInfo(ChnID,ContentID,VideoFormat,AudioFormat,Language,CCType,CCSource,TrnUserID,TrnDate)
		  Values(@ChnID,@ContentID,@VideoFormat,@AudioFormat,@Language,@CCType,@CCSource,@TrnUserID,GetDate())
		  		  
		  Set @ID=SCOPE_IDENTITY()
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnContentOtherInfo',@ID,'True',NULL)
	  End
	Else If @TrnMode=2
	  Begin
		  Update ChnContentOtherInfo Set ChnID=@ChnID,ContentID=@ContentID,VideoFormat=@VideoFormat,AudioFormat=@AudioFormat,
		  Language=@Language,CCType=@CCType,CCSource=@CCSource,TrnUserID=@TrnUserID,TrnDate=GetDate()
		  Where ID=@ID
		  
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnContentOtherInfo',@ID,'True',NULL)
	  End
	Else If @TrnMode=3 --Delete Record
	  Begin
			Delete From ChnContentOtherInfo Where ID=@ID
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChnContentOtherInfo',@ID,'True',NULL)
	  End
	Else If @TrnMode=4 --Get Record
	  Begin
			Select ChnContentOtherInfo.ID,ChnContentOtherInfo.ChnID,ChnContentOtherInfo.ContentID,ChnContentOtherInfo.VideoFormat,
			ChnContentOtherInfo.AudioFormat,ChnContentOtherInfo.Language,ChnContentOtherInfo.CCType,
			ChnContentOtherInfo.CCSource,ChnContentOtherInfo.TrnUserID,ChnContentOtherInfo.TrnDate,ContentMst.Path
			From ChnContentOtherInfo Inner Join ContentMst On ChnContentOtherInfo.ContentID = ContentMst.ID
			Where ChnContentOtherInfo.ContentID=@ContentID And ChnContentOtherInfo.ChnID=@ChnID
	  End
	
END
