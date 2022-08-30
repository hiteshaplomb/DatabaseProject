
--Develop 15 12 2021 For Getting Skin Path
CREATE FUNCTION [dbo].[GetChnLastPosition]
(
  @ChnID Dbo.ChnID
 
) RETURNS VARCHAR(MAX)
AS
BEGIN
	Declare @ReturnPath Varchar(Max)

	
	Select @ReturnPath= ISNULL(ChannelMst.LastPosition,'') From ChannelMst With(NoLock)  Where ChannelMst.ID=@ChnID And ChannelMst.TrnStatus <> 3

	RETURN @ReturnPath
END


