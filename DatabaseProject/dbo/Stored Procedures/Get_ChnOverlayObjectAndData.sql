-- Stored Procedure

--Develop 01 07 2022. Getting Get_ChnOverlayObjectAndData
CREATE PROCEDURE [dbo].[Get_ChnOverlayObjectAndData]
(
	@ChnID Dbo.ChnID
)	
As
SET NOCOUNT ON;
Begin
	Select COOD.ID,COOD.ChnOverlayChildID,COOD.Name,COOD.Value 
	From ChnOverlayObjectAndData As[COOD] Inner Join ChnOverlayChild On COOD.ChnOverlayChildID = ChnOverlayChild.ID
	Where ChnOverlayChild.ChnID=@ChnID
	 
End		


