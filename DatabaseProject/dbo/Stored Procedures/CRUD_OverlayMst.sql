--Develop 10 11 2021, Overlay Master
CREATE PROCEDURE [dbo].[CRUD_OverlayMst]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update | 3=Delete 4=GetRecord 5-Used For Auto Entry Time
	@ID Varchar(Max)=NULL out,
	@Name Varchar(250)=NULL,
	@Type TinyInt=NULL, --1-Image 2-SequenceImage 3-Text 4-Ticker 5-Swf File
	@Value Varchar(Max)=NULL,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL,
	@XMLData Varchar(Max)=NULL
As
SET NOCOUNT ON;
Begin
	Declare @ReturnMsg Varchar(max)
	If @TrnMode=1
	  Begin
		  Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate,XMLData)
		  Values(@Name,@Type,@Value,1,@TrnUserID,GetDate(),@XMLData)
		  		  
		  Set @ID=SCOPE_IDENTITY()
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_OverlayMst',@ID,'True',NULL)
	  End
	Else If @TrnMode=2
	  Begin
		  Update OverlayMst Set Name=@Name,Type=@Type,Value=@Value,TrnUserID=@TrnUserID,TrnStatus=@TrnStatus,TrnDate=GetDate(),XMLData=@XMLData
		  Where ID=@ID
		  
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_OverlayMst',@ID,'True',NULL)
	  End
	Else If @TrnMode=3 --Delete Record
	  Begin
			If Exists(Select 1 From OverlayMst Where ID In(Select Value From string_split(@ID,','))
				And ID In(Select OverlayID From ChnOverlayChild Where TrnStatus=1))
				Set @ReturnMsg = 'Some content which are assign and status is active are not deleted.'
			
			Delete From OverlayMst Where ID In(Select Value From string_split(@ID,','))
			And ID Not In(Select OverlayID From ChnOverlayChild)
			
			Update OverlayMst Set TrnStatus=2 Where ID In(Select Value From string_split(@ID,','))
			And Not Exists(Select 1 From ChnOverlayChild Where OverlayID=OverlayMst.ID And TrnStatus=1)

			
			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_OverlayMst',@ID,'True',Case When @ReturnMsg Is Not NULL Then @ReturnMsg Else  NULL End)
	  End
	Else If @TrnMode=4 --Get Record
	  Begin
			Select ID,Name,Type,Value,TrnStatus,TrnUserID,TrnDate,XMLData
			From OverlayMst  Where ID=@ID
	  End
End