--Develop 29 12 2021
CREATE FUNCTION [dbo].[VLD_ChnSlotMst]
(
  @ID dbo.PID,
  @ChnID Dbo.ChnID,
  @Type Varchar(200), --Name|Slot
  @Value Varchar(200)
) RETURNS bit
AS
BEGIN
	Declare @IsExists bit='False'
	
	If @Type='Name'
	  Begin
	  	  If @Value Is Not NULL 
		  Begin
			  If Exists(Select 1 From ChnSlotMst With(NoLock) Where Name=Isnull(@Value,'') And ChnID=Isnull(@ChnID,0) And ID<>Isnull(@ID,0) And TrnStatus=1)
	  			 Set @IsExists='True'	
		  End	
	  End
	Else If @Type='Slot'
	  Begin
	  	  If @Value Is Not NULL 
		    Begin
				If Exists(Select 1 From ChnSlotMst With(NoLock) Where Slot=Isnull(@Value,'') And ChnID=Isnull(@ChnID,0) And ID<>Isnull(@ID,0) And TrnStatus=1)
	  			 Set @IsExists='True'
			End
	  End
	
 RETURN @IsExists
END

