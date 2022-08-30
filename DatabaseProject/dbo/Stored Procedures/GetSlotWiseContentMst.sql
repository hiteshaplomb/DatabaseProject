--Develop 03 03 2022, This Procedure Get Content List Based On SlotID.
CREATE PROCEDURE [dbo].[GetSlotWiseContentMst]
(
  @Type TinyInt,
  @ChnID Dbo.ChnID, --Pass ChannelID
  @SlotID Int      --Pass Slot ID For Those Record Received. 
 
)
As
SET NOCOUNT ON;
Begin
		Select ChnContentChild.ID,ContentMst.ID As[ContentID],
		ROW_NUMBER() Over(Order by ContentMst.ID Desc) As[SrNo],
		Dbo.GetFileName(Path) As[File],Path As[Particular],
		ChnContentChild.StartDate,ChnContentChild.EndDate,
		ChnContentChild.AllDay,ChnContentChild.Mon,ChnContentChild.Tue,ChnContentChild.Wed,
		ChnContentChild.Thu,ChnContentChild.Fri,ChnContentChild.Sat,ChnContentChild.Sun
		From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
		Where ChnContentChild.ChnID=@ChnID And ContentMst.TrnStatus=1 And ContentMst.Type=@Type And Dbo.ExistFile(ContentMst.Path)='True'
		And ChnContentChild.Id Not In(Select ChnContentID From ChnSlotDetail Where SlotID=@SlotID And TrnStatus=1)
		And ChnContentChild.TrnStatus=1
		Order by ContentMst.ID Desc
End
		


