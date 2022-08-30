-- Stored Procedure

--Develop 29 05 2022, For Insert Record Im ChnOverlayObjectAndData 
CREATE PROCEDURE [dbo].[Bulk_ChnOverlayObjectAndData]
(
	@Type_ChnOverlayObjectAndData Dbo.Type_ChnOverlayObjectAndData Readonly,
	@Type_ChnOverlayChild_5 Dbo.Type_ChnOverlayChild_5 Readonly
)	
As
SET NOCOUNT ON;
Begin
		Declare @TempReturn Table(ID Int,ChnOverlayChildID Int)
		Declare @ReturnID NVarchar(Max) --Return Value

		--Delete ChnOverlayData Where Not Required.
		Delete From ChnOverlayObjectAndData
		Where ChnOverlayChildID In(Select ChnOverlayChildID From @Type_ChnOverlayObjectAndData) 
		And ID Not In(Select ID From @Type_ChnOverlayObjectAndData Where ID<>0)

		--First Check If @Type_ChnOverlayData'ID is Zero That Time It Will Insert Record.
		Insert Into ChnOverlayObjectAndData(ChnOverlayChildID,Name,Value)
		Output inserted.ID,inserted.ChnOverlayChildID into @TempReturn
		Select ChnOverlayChildID,Name,Value
		From @Type_ChnOverlayObjectAndData 
		Where ID=0 

		--Update Record Related Changes
		Update COOD Set Name=Type_COOD.Name,Value=Type_COOD.Value
		From ChnOverlayObjectAndData As[COOD] Inner Join @Type_ChnOverlayObjectAndData As[Type_COOD] 
		On COOD.ID = Type_COOD.ID

		Update ChnOverlayChild Set IsDisplay=Type_ChnOverlayChild_5.IsDisplay
		From ChnOverlayChild Inner Join @Type_ChnOverlayChild_5 As[Type_ChnOverlayChild_5] 
		On ChnOverlayChild.ID = Type_ChnOverlayChild_5.ChnOverlayChildID

		Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
		Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnOverlayObjectAndData',@ReturnID ,'True',NULL)
End		
