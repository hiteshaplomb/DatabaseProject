
CREATE PROCEDURE [dbo].[CleanDB]
	@Type TinyInt=0 --0 - CleanData + Default ApplicationSetting | 1-ClenData | 2-Content
	
As
SET NOCOUNT ON;
Begin
	If @Type=0
	  Begin
		  	Truncate Table ChannelConfig
			Truncate Table ChannelConfigChild
			Truncate Table ChannelMst
			Truncate Table OverlayMst
			Truncate Table ChnContentChild
			Truncate Table ChnContentOtherInfo
			Truncate Table ContentMst
			Truncate Table ChnSlotMst
			Truncate Table ChnSlotDetail
			Truncate Table ChnContentPlayLog
			Truncate Table ChnOverlayChild
			Truncate Table ChannelSetting
			Truncate Table OverlayObject
			Truncate Table ChnOverlayData
			Truncate Table ChnOverlayStyle
			Truncate Table ChnOverlayPlayLog
			Truncate Table ChnOverlayObjectAndData
			
			Update AppSetting Set Value=DefaultValue
	  End
	Else If @Type=1
	  Begin
			Truncate Table ChannelConfig
			Truncate Table ChannelConfigChild
			Truncate Table ChannelMst
			Truncate Table OverlayMst
			Truncate Table ChnContentChild
			Truncate Table ChnContentOtherInfo
			Truncate Table ContentMst
			Truncate Table ChnSlotMst
			Truncate Table ChnSlotDetail
			Truncate Table ChnContentPlayLog
			Truncate Table ChnOverlayChild
			Truncate Table ChannelSetting
			Truncate Table OverlayObject
			Truncate Table ChnOverlayData
			Truncate Table ChnOverlayStyle
			Truncate Table ChnOverlayPlayLog
			Truncate Table ChnOverlayObjectAndData
	  End
	Else If @Type =2 --Content Clean
	  Begin
			Truncate Table ContentMst
			Truncate Table ChnSlotMst
			Truncate Table ChnSlotDetail
			Truncate Table ChnContentPlayLog
			Truncate Table ChnContentChild
			Truncate Table ChnContentOtherInfo
	  End
	Else If @Type=3 -- Overlay Clean
	  Begin
			Truncate Table OverlayMst
			Truncate Table ChnOverlayChild
			Truncate Table OverlayObject
			Truncate Table ChnOverlayData
			Truncate Table ChnOverlayStyle
			Truncate Table ChnOverlayPlayLog
			Truncate Table ChnOverlayObjectAndData
	  End
End


