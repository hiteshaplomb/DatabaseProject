--Develop 30 10 2021
Create Procedure [dbo].[GetChnConfig]
(
 @ChnID Dbo.ChnID=NULL --While Pass That Time, Channel Configure.
)
As
SET NOCOUNT ON;
Begin
	
	
	Select ID,Type,Particular,Narration From ChannelConfig 
	Where ChnID=@ChnID And TrnStatus=1
	Order by ID

	Select ChnConfigID,Particular,URL,Argument
	From ChannelConfigChild 
	Where ChnConfigID In(Select ID From ChannelConfig Where ChnID=@ChnID And TrnStatus=1)
	And TrnStatus=1

End
