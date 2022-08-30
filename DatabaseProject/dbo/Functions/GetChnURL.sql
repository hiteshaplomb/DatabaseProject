
CREATE FUNCTION [dbo].[GetChnURL]
(
  @ID As bigint
 
) RETURNS VARCHAR(MAX)
AS
BEGIN
	Declare @Return Varchar(Max)

	Set @Return =(Select top 1  'URL:'+ ChannelConfigChild.URL + ',Argument:' + ChannelConfigChild.Argument from ChannelConfigChild left join ChannelConfig on ChannelConfigChild.ChnConfigID = ChannelConfig.ID and Type = 'Output' where ChannelConfig.ChnID = @ID and ChannelConfigChild.URL <> '' order by ChannelConfigChild.ID) 
		
 RETURN @Return
END

