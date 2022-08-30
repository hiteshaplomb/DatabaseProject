--Develop 06 10 2021, Only Insert Is Working , First It Will Delete Record and Then Insert.
CREATE PROCEDURE [dbo].[CRUD_ChnConfig]
	@TrnMode Dbo.TrnMode=NULL, --1 For Insert/Update/Delete And 4 For Getting Record
	@ChnID Dbo.ChnID=NULL,
	@InputType Varchar(100)=NULL, --Playlist/URL
	@InputURL Varchar(500)=NULL, --Pass When Input Type Is URL That Time URL Is Required.
	@Video Varchar(100)=NULL,
	@Audio Varchar(100)=NULL,
	@Type_ChnConfig Dbo.Type_ChnConfig Readonly,
	@TrnUserID Dbo.TrnUserID=NULL,
	@TrnStatus Dbo.TrnStatus=NULL,
	@Volume Varchar(100)=NULL
	
As
SET NOCOUNT ON;
BEGIN
	Declare @ChnConfigeID Dbo.PID

	If @TrnMode=1
	  Begin
			Delete From ChannelConfigChild Where ChnConfigID In(Select ID From ChannelConfig Where ChnID=@ChnID)
			Delete From ChannelConfig Where ChnID=@ChnID

			--Input/Output/VideoFormat/AudioFormat
			--Video Resolution
			Insert Into ChannelConfig(ChnID,Type,Particular,TrnStatus,TrnUserID,TrnDate)
			Values(@ChnID,'VideoFormat',@Video,@TrnStatus,@TrnUserID,Getdate())

			--Audio Resolution
			Insert Into ChannelConfig(ChnID,Type,Particular,TrnStatus,TrnUserID,TrnDate)
			Values(@ChnID,'AudioFormat',@Audio,@TrnStatus,@TrnUserID,GetDate())

			--Volume Related
			Insert Into ChannelConfig(ChnID,Type,Particular,TrnStatus,TrnUserID,TrnDate)
			Values(@ChnID,'Volume',@Volume,@TrnStatus,@TrnUserID,GetDate())

			--Inpute Configure
			Insert Into ChannelConfig(ChnID,Type,Particular,TrnStatus,TrnUserID,TrnDate)
			Values(@ChnID,'Input','',@TrnStatus,@TrnUserID,GetDate())

			Set @ChnConfigeID = SCOPE_IDENTITY()

			Insert Into ChannelConfigChild(ChnConfigID,Particular,URL,Argument,TrnStatus)
			Values(@ChnConfigeID,@InputType,@InputURL,'',1)


			--Output Configure
			Insert Into ChannelConfig(ChnID,Type,Particular,TrnStatus,TrnUserID,TrnDate)
			Values(@ChnID,'Output','',@TrnStatus,@TrnUserID,GetDate())

			Set @ChnConfigeID = SCOPE_IDENTITY()

			Insert Into ChannelConfigChild(ChnConfigID,Particular,URL,Argument,TrnStatus)
			Select @ChnConfigeID,Type_ChnConfig.Particular,Type_ChnConfig.URL,Type_ChnConfig.Argument,Type_ChnConfig.Trnstatus 
			From @Type_ChnConfig As[Type_ChnConfig]

			--If @OutputType='Renderer'
			--	Insert Into ChannelConfigChild(ChnConfigID,Particular,URL,Argument,TrnStatus)
			--	Values(@ChnConfigeID,@OutputType,'',@RendererSource,1)
			--Else If @OutputType ='Stream'
			--	Insert Into ChannelConfigChild(ChnConfigID,Particular,URL,Argument,TrnStatus)
			--	Select @ChnConfigeID,Type_ChnConfig.Particular,Type_ChnConfig.URL,Type_ChnConfig.Argument,Type_ChnConfig.Trnstatus From @Type_ChnConfig As[Type_ChnConfig]

			Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnConfig',0,'True',NULL)
			
	  End
	Else If @TrnMode=4 --For Getting Record
	  Begin
			Declare @RetVideoFormat Varchar(500)
			Declare @RetAudioFormat Varchar(500)
			Declare @RetInputType Varchar(500)
			Declare @RetInputURL Varchar(500)
			Declare @RetIsRenderer Bit='False'
			Declare @RetRendererOutput Varchar(2000)
			Declare @RetVolume Varchar(100)

			Select @RetVideoFormat=Particular From ChannelConfig Where ChnID=@ChnID And Type='VideoFormat'
			Select @RetAudioFormat=Particular From ChannelConfig Where ChnID=@ChnID And Type='AudioFormat'
			Select @RetVolume=Particular From ChannelConfig Where ChnID=@ChnID And Type='Volume'

			Select @RetInputType=CCC.Particular,@RetInputURL=CCC.URL
			From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
			Where CC.ChnID=@ChnID And CC.Type='Input' 

			If Exists(Select 1 From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
				Where CC.ChnID=1 And CC.Type='Output' And CCC.Particular='Renderer')

			    Select @RetRendererOutput=CCC.Argument,@RetIsRenderer='True'
				From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
				Where CC.ChnID=@ChnID And CC.Type='Output' And CCC.Particular='Renderer'


			----Return Values-------------
			Select @RetVideoFormat As[VideoFormat],@RetAudioFormat As[AudioFormat],@RetInputType As[InputType],@RetInputURL As[InputURL],@RetIsRenderer As[IsRenderer],@RetRendererOutput As[RendererOutput],@RetVolume As[Volume]

		    Select CCC.Particular,CCC.URL,CCC.Argument,Case When CCC.TrnStatus=1 Then 'Active' Else 'DeActive' End As[Status]
			From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
			Where CC.ChnID=@ChnID And CC.Type='Output' And CCC.Particular <> 'Renderer'




			--Select ID,Type,Particular,Narration,TrnStatus From ChannelConfig Where ChnID=@ChnID

			--Select CCC.Particular,CCC.URL,CCC.Argument,CCC.TrnStatus
			--From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
			--Where CC.ChnID=@ChnID
	  End

	
	
END
