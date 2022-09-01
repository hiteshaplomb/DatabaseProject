CREATE PROCEDURE [dbo].[CRUD_Appsetting]
(
	@FwdBckwdskip int=NULL,
	@IsContentWiseAudioVideoFormat Int=0,
	@ParameterForGraphicscard Nvarchar(200)=NULL,
	@SequenceOverlayTemplate nvarchar(50)=NULL,
	@SequenceOverlayProgramDisplay Int=0,
	@SequenceOverlayFillerDisplay Int=0,
	@SequenceOverlayAdvtDisplay Int=0,
	@ChnID Int=0,
	@OverlayObjectStyle Nvarchar(200)=NULL,
	@TickerProgramDisplay Int=0,
	@TickerFillerDisplay Int=0,
	@TickerAdvtDisplay Int=0,
	@EnableAutoPlay Int=0,
	@AutoPlayTiming Int=0,
	@NewsProgramDisplay Int=0,
	@NewsFillerDisplay Int=0,
	@NewsAdvtDisplay Int=0,
	@NewsOverlayTemplate nvarchar(50)=NULL,
	@LiveInputSource Varchar(250)=NULL

)
As
Set NoCount ON;

IF @ChnID = 0
Begin

		Update AppSetting set Value=@FwdBckwdskip Where Particular='FwdBckwdskip'
		Update AppSetting set Value=@IsContentWiseAudioVideoFormat Where Particular='IsContentWiseAudioVideoFormat'
		Update AppSetting set Value=@ParameterForGraphicscard Where Particular='ParameterForGraphicscard'		
		Update AppSetting set Value=@SequenceOverlayTemplate Where Particular='SequenceOverlayTemplate'
		Update AppSetting set Value=@SequenceOverlayProgramDisplay Where Particular='SequenceOverlayProgramDisplay'
		Update AppSetting set Value=@SequenceOverlayFillerDisplay Where Particular='SequenceOverlayFillerDisplay'
		Update AppSetting set Value=@SequenceOverlayAdvtDisplay Where Particular='SequenceOverlayAdvtDisplay'
		Update AppSetting set Value=@OverlayObjectStyle Where Particular='OverlayObjectStyle'
		update AppSetting set Value=@TickerProgramDisplay where Particular='TickerProgramDisplay'
		Update AppSetting set Value=@TickerFillerDisplay Where Particular='TickerFillerDisplay'
		Update AppSetting set Value=@TickerAdvtDisplay Where Particular='TickerAdvtDisplay'
		Update AppSetting set Value=@EnableAutoPlay Where Particular='EnableAutoPlay'
		Update AppSetting set Value=@AutoPlayTiming Where Particular='AutoPlayTiming'
		Update AppSetting set Value=@NewsProgramDisplay Where Particular='NewsProgramDisplay'
		Update AppSetting set Value=@NewsFillerDisplay Where Particular='NewsFillerDisplay'
		Update AppSetting set Value=@NewsAdvtDisplay Where Particular='NewsAdvtDisplay'
		Update AppSetting set Value=@NewsOverlayTemplate Where Particular='NewsOverlayTemplate'
		Update AppSetting set Value=@LiveInputSource Where Particular='LiveInputSource'
End
Else
Begin

		--First Check If New Record Added That Time Autometically Added.
		Insert Into ChannelSetting(ChnID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,TrnDate)
		Select @ChnID,Particular,Value,Category,DefaultValue,DataType,Desp,TrnUserID,TrnDate 
		From AppSetting Where Type=2 And Particular Not In(Select Particular From ChannelSetting Where ChnID=@ChnID)

		Update ChannelSetting set Value=@IsContentWiseAudioVideoFormat Where Particular='IsContentWiseAudioVideoFormat' And ChnID=@ChnID
		Update ChannelSetting set Value=@SequenceOverlayTemplate Where Particular='SequenceOverlayTemplate' And ChnID=@ChnID
		Update ChannelSetting set Value=@SequenceOverlayProgramDisplay Where Particular='SequenceOverlayProgramDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@SequenceOverlayFillerDisplay Where Particular='SequenceOverlayFillerDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@SequenceOverlayAdvtDisplay Where Particular='SequenceOverlayAdvtDisplay' And ChnID=@ChnID		
		Update ChannelSetting set Value=@OverlayObjectStyle Where Particular='OverlayObjectStyle' And ChnID=@ChnID				
		Update ChannelSetting set Value=@TickerProgramDisplay Where Particular='TickerProgramDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@TickerFillerDisplay Where Particular='TickerFillerDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@TickerAdvtDisplay Where Particular='TickerAdvtDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@NewsProgramDisplay Where Particular='NewsProgramDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@NewsFillerDisplay Where Particular='NewsFillerDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@NewsAdvtDisplay Where Particular='NewsAdvtDisplay' And ChnID=@ChnID
		Update ChannelSetting set Value=@NewsOverlayTemplate Where Particular='NewsOverlayTemplate' And ChnID=@ChnID
		Update ChannelSetting set Value=@LiveInputSource Where Particular='LiveInputSource' And ChnID=@ChnID

End
		Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_Appsetting',NULL ,'True',NULL)
