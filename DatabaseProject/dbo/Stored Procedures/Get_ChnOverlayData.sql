--Develop 25 05 2022. Getting ChnOverlayata
Create PROCEDURE [dbo].[Get_ChnOverlayData]
(
	@ChnID Dbo.ChnID
)	
As
SET NOCOUNT ON;
Begin
	 Select ChnOverlayData.ID,ChnOverlayData.OverlayObjID,ChnOverlayData.Value,ChnOverlayData.ChnOverlayChildID,ChnOverlayData.SourceType
	 From ChnOverlayData Inner Join ChnOverlayChild On ChnOverlayData.ChnOverlayChildID = ChnOverlayChild.ID
	 Where ChnOverlayChild.ChnID=@ChnID
End		