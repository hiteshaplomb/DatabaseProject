-- Stored Procedure

--Develop 06 10 2021, Only Insert Is Working , First It Will Delete Record and Then Insert.
--exec Set_DefaultChannel @DefaultChnID=1,@NewChnID=3
--exec CRUD_ChnConfig @TrnMode=4,@ChnID=1
CREATE PROCEDURE [dbo].[Set_DefaultChannel]	
	@DefaultChnID Dbo.ChnID=NULL,
	@NewChnID Dbo.ChnID=NULL,
	@URL Varchar(500)
	
As
SET NOCOUNT ON;
BEGIN

Declare @RetVideoFormat Varchar(500)
Declare @RetAudioFormat Varchar(500)
Declare @RetInputType Varchar(500)
Declare @RetInputURL Varchar(500)
Declare @RetIsRenderer Bit='False'
Declare @RetRendererOutput Varchar(2000)
Declare @RetVolume Varchar(100)
Declare @Type_ChnConfig Dbo.Type_ChnConfig
Declare @TrnUserID Dbo.TrnUserID
Declare	@TrnStatus Dbo.TrnStatus
Declare @DefaultChnName nvarchar(100)
Declare @NewChnName nvarchar(100)

	Select @RetVideoFormat=Particular From ChannelConfig Where ChnID=@DefaultChnID And Type='VideoFormat'
	Select @RetAudioFormat=Particular From ChannelConfig Where ChnID=@DefaultChnID And Type='AudioFormat'
	Select @RetVolume=Particular From ChannelConfig Where ChnID=@DefaultChnID And Type='Volume'
	Select TOP 1 @TrnStatus=TrnStatus From ChannelConfig Where ChnID=@DefaultChnID
	Select TOP 1 @TrnUserID=TrnUserID From ChannelConfig Where ChnID=@DefaultChnID	
	Select @DefaultChnName='service_name='''+Name+''+'''' from ChannelMst where ID=@DefaultChnID
	Select @NewChnName='service_name='''+Name+''+'''' from ChannelMst where ID=@NewChnID

	Select @RetInputType=CCC.Particular,@RetInputURL=CCC.URL
			From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
			Where CC.ChnID=@DefaultChnID And CC.Type='Input' 	 	 

	If Exists(Select 1 From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
				Where CC.ChnID=@DefaultChnID And CC.Type='Output' And CCC.Particular='Renderer')

	Select @RetRendererOutput=CCC.Argument,@RetIsRenderer='True'
				From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
				Where CC.ChnID=@DefaultChnID And CC.Type='Output' And CCC.Particular='Renderer'
				
		--Insert Into @Type_ChnConfig (Type_ChnConfig.Particular,Type_ChnConfig.URL,Type_ChnConfig.Argument,Type_ChnConfig.Trnstatus)
		--Select CCC.Particular,CCC.URL,CCC.Argument,CCC.TrnStatus
		--From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
		--Where CC.ChnID=@DefaultChnID And CC.Type='Output' 

		--Insert Into @Type_ChnConfig (Type_ChnConfig.Particular,Type_ChnConfig.URL,Type_ChnConfig.Argument,Type_ChnConfig.Trnstatus)
		--Select CCC.Particular,@URL,CCC.Argument,CCC.TrnStatus
		--From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
		--Where CC.ChnID=@DefaultChnID And CC.Type='Output' 
		--And CCC.Particular <> 'Renderer'  		

		Insert Into @Type_ChnConfig (Type_ChnConfig.Particular,Type_ChnConfig.URL,Type_ChnConfig.Argument,Type_ChnConfig.Trnstatus)
		Select CCC.Particular,@URL,REPLACE(CCC.Argument,@DefaultChnName,@NewChnName),CCC.TrnStatus
		From ChannelConfigChild As[CCC] Inner Join ChannelConfig As[CC] On CCC.ChnConfigID = CC.ID
		Where CC.ChnID=@DefaultChnID And CC.Type='Output' 

	Exec [dbo].[CRUD_ChnConfig] @TrnMode=1,@ChnID=@NewChnID,@InputType=@RetInputType,@InputURL=@RetInputURL,@Video=@RetVideoFormat,@Audio=@RetAudioFormat,@Type_ChnConfig=@Type_ChnConfig,@TrnUserID=@TrnUserID,@TrnStatus=@TrnStatus,@Volume=@RetVolume
	--Exec [dbo].[CRUD_ChnConfig] @TrnMode=1,@ChnID=@NewChnID,@InputType=@RetInputType,@InputURL=@URL,@Video=@RetVideoFormat,@Audio=@RetAudioFormat,@Type_ChnConfig=@Type_ChnConfig,@TrnUserID=@TrnUserID,@TrnStatus=@TrnStatus,@Volume=@RetVolume
	
END

