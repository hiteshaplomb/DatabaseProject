
--Develop 09 09 2021
CREATE PROCEDURE [dbo].[CRUD_ChannelMst]

	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update | 3=Delete 4=GetRecord 5-Used For Auto Entry Time
	@ID BigInt out,
	@Name Varchar(250)=NULL,
	@Mode TinyInt = NULL, --1=TimeBase 2=SequenceBase
	@Type TinyInt = NULL, --1-General 2-Song 3-News 4-Sport
	@LogoType TinyInt=NULL, --1 Image 2-Sequence, Where 2 Then Pass @LogoPath As Folder Path
	@LogoPath Varchar(2000)=NULL,
	@SkinPath Varchar(2000)=NULL,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL,
	@IsDefault bit=0
	
As
SET NOCOUNT ON;
BEGIN
	Declare @LogoID Dbo.OverlayID
	Declare @SkinID Dbo.OverlayID
	Declare @ErrorMsg Varchar(Max)=''

-------Validation Message Start----------------------------------------------------------------------------------------
	If @TrnMode=1
	  Begin
	  	  If Exists(Select 1 From ChannelMst With(NoLock) Where Name=@Name And TrnStatus <> 3)
	  		 Set @ErrorMsg='Channel name already exists.'
	  End
	Else If @TrnMode=2
	  Begin
		  If Exists(Select 1 From ChannelMst Where ID<>@ID And Name=@Name And TrnStatus <> 3)
			 Set @ErrorMsg='Channel name already exists.'
	  End
    
    
	If @ErrorMsg <> ''
	  Begin
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChannelMst',@ID,'False',@ErrorMsg)
		  Return
	  End
--------Validation Message End---------------------------------------

	If @LogoPath <> ''
	  Begin
		  If Exists(Select 1 From OverlayMst Where Type=@LogoType And Value=@LogoPath)
		     Select @LogoID=ID From OverlayMst Where Type=@LogoType And Value=@LogoPath
		  Else
		    Begin
		  		Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate) Values('N/A',@Logotype,@LogoPath,1,@TrnUserID,GETDATE())
		     	Set @LogoID=SCOPE_IDENTITY()
			End
      End

	--Skin Image
	If @SkinPath <> ''
	  Begin
	  	 If Exists(Select 1 From OverlayMst Where Type=1 And Value=@SkinPath)
	  	    Select @SkinID=ID From OverlayMst Where Type=1 And Value=@SkinPath
	  	 Else
	  	 Begin
	  	 	Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate) Values('N/A',1,@SkinPath,1,@TrnUserID,GETDATE())
	  	 	Set @SkinID=SCOPE_IDENTITY()
	  	 End
      End

	If @TrnMode=1
	  Begin
			If @IsDefault='true'
			Begin
				Update ChannelMst Set IsDefault=0 Where IsDefault=1
			End

		  Insert Into ChannelMst(Name,Mode,Type,LogoID,SkinID,TrnUserID,TrnStatus,TrnDate,IsDefault)
		  Values(@Name,@Mode,@Type,@LogoID,@SkinID,@TrnUserID,@TrnStatus,GetDate(),@IsDefault)
		  		  
		  Set @ID=SCOPE_IDENTITY()
		  Exec Set_ChannelSetting @Type=1,@ChnID=@ID

		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChannelMst',@ID,'True',NULL)
	  End
	Else If @TrnMode=2
	  Begin
			If @IsDefault='true'
				Begin
					Update ChannelMst Set IsDefault=0 Where IsDefault=1
				End
		  Update ChannelMst Set Name=@Name,Mode=@Mode,Type=@Type,LogoID=@LogoID,SkinID=@SkinID,TrnUserID=@TrnUserID,TrnStatus=@TrnStatus,TrnDate=GetDate(),IsDefault=@IsDefault
		  Where ID=@ID
		  
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChannelMst',@ID,'True',NULL)
	  End
	Else If @TrnMode=3 --Delete Record
	  Begin
			Update ChannelMst Set TrnStatus=@TrnStatus,TrnUserID=@TrnUserID,TrnDate=GETDATE() Where ID=@ID
			--Delete From ChannelMst Where ID=@ID
			Update ChnOverlayChild set TrnStatus=2 where ChnID=@ID
			Update ChnSlotMst set TrnStatus=2 where ChnID=@ID
			Update ChnContentChild set TrnStatus=2 where ChnID=@ID

			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ChannelMst',@ID,'True',NULL)
	  End
	Else If @TrnMode=4 --Get Record
	  Begin
			Select ChannelMst.ID,ChannelMst.Name,Cast(ChannelMst.Mode As Int) As[Mode],Cast(ChannelMst.Type As Int) As[Type],
			ChannelMst.LogoID,ChannelMst.SkinID,ChannelMst.TrnStatus,OverlayLogo.Value As[LogoPath],OverlayLogo.Type As[LogoType],
			OverlaySkin.Value As[SkinPath],ChannelMst.IsDefault
			From ChannelMst Left Join OverlayMst As[OverlayLogo] On ChannelMst.LogoID = OverlayLogo.ID
			Left Join OverlayMst As[OverlaySkin] On ChannelMst.SkinID = OverlaySkin.ID
			Where ChannelMst.ID=@ID And ChannelMst.TrnStatus <> 3
	  End
	
END

