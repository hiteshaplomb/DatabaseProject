
--Develop 16 03 2022 Getting OVerlay Detail As Per Requirment
Create FUNCTION [dbo].[Props_ChnOverlayChild]
(
  @ChnOverlayChild Int,	
  @Type Varchar(255) --'Value' For OvelayMst' Value Field.
 
) 
  RETURNS VARCHAR(MAX)
AS
BEGIN
	Declare @ReturnPath Varchar(Max)

	If @Type='Value'
	  Begin
		 Set @ReturnPath = 
		 (
			Select Value From OverlayMst With(NoLock) Where ID In(Select OverlayID From ChnOverlayChild Where ID=@ChnOverlayChild)
		 )
	  End

	
		
	
 RETURN @ReturnPath
END

