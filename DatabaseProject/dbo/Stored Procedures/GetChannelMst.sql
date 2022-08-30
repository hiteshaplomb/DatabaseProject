--Develop 10 09 2021
CREATE PROCEDURE [dbo].[GetChannelMst]
(
 @Status Int=-1
)
As
SET NOCOUNT ON;
BEGIN
	
	--Logo Path
	Select ChannelMst.ID,ChannelMst.Name,ROW_NUMBER() Over (Order by ChannelMst.Name) As[SrNo],
	Case When ChannelMst.Mode=1 Then 'Time Base' When ChannelMst.Mode=2 Then 'Sequence Base' Else '' End As[Mode],
	Case ChannelMst.Type When 1 Then 'General' When 2 Then 'Song' When 3 Then 'News' When 4 Then 'Sports' End As[Type],
	OverlayLogo.Value As[LogoPath],OverlaySkin.Value As[SkinPath],
	Case When ChannelMst.TrnStatus=1 Then 'Active' When ChannelMst.TrnStatus=2 Then 'DeActive' End As[Status]
	From ChannelMst Left Join OverlayMst As[OverlayLogo] With(NoLock) On ChannelMst.LogoID = OverlayLogo.ID
	Left Join OverlayMst As[OverlaySkin] With(NoLock) On ChannelMst.SkinID = OverlaySkin.ID
	Where ChannelMst.TrnStatus = Case When @Status=-1 Then ChannelMst.TrnStatus Else @Status End
	And ChannelMst.TrnStatus <> 3
	Order by ChannelMst.Name
END

