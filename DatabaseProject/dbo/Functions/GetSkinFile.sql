
--Develop 15 12 2021 For Getting Skin Path
Create FUNCTION [dbo].[GetSkinFile]
(
  @ChnID Dbo.ChnID
 
) RETURNS VARCHAR(MAX)
AS
BEGIN
	Declare @ReturnPath Varchar(Max)

	If Exists(Select 1 From ChannelMst With(NoLock) Inner Join OverlayMst With(NoLock) On ChannelMst.SkinID= OverlayMst.ID Where ChannelMst.ID=@ChnID And ChannelMst.SkinID Is Not NULL)
	   	Set @ReturnPath = (Select Value From OverlayMst Where ID In(Select SkinID From ChannelMst Where ID=@ChnID))

	If Dbo.ExistFile(@ReturnPath) = 'False'
		Set @ReturnPath =''
		
	
 RETURN @ReturnPath
END

