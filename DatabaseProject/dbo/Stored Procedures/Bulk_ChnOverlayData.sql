--Develop 19 05 2022, For Insert Record Im ChnOverlayData And it's Child Style Table.
CREATE PROCEDURE [dbo].[Bulk_ChnOverlayData]
(
	@Type_ChnOverlayData Dbo.Type_ChnOverlayData Readonly,
	@Type_ChnOverlayStyle Dbo.Type_ChnOverlayStyle_2 Readonly,
	@Type_ChnOverlayChild_5 Dbo.Type_ChnOverlayChild_5 Readonly
)	
As
SET NOCOUNT ON;
Begin
		Declare @TempReturn Table(ID Int,OverlayObjID Int)
		Declare @ReturnID NVarchar(Max) --Return Value

		--First Check If @Type_ChnOverlayData'ID is Zero That Time It Will Insert Record.
		Insert Into ChnOverlayData(OverlayObjID,ChnOverlayChildID,Value,SourceType)
		Output inserted.ID,inserted.OverlayObjID into @TempReturn
		Select OverlayObjID,ChnOverlayChildID,Value,SourceType 
		From @Type_ChnOverlayData As[Type_ChnOverlayData]
		Where Type_ChnOverlayData.ID=0 
		--And Not Exists(Select 1 From ChnOverlayData Where OverlayObjID=Type_ChnOverlayData.OverlayObjID And ChnOverlayChildID=Type_ChnOverlayData.ChnOverlayChildID) 

		Insert Into ChnOverlayStyle(ChnOverlayDataID,Particular,Value)
		Select TempReturn.ID, Type_ChnOverlayStyle.Particular,Type_ChnOverlayStyle.Value
		From @Type_ChnOverlayStyle As[Type_ChnOverlayStyle] Inner Join @TempReturn As[TempReturn] On Type_ChnOverlayStyle.OverlayObjID=TempReturn.OverlayObjID
		Where Type_ChnOverlayStyle.ChnOverlayDataID=0

		--Update Record Related Changes
		Update COD Set SourceType=Type_ChnOverlayData.SourceType,Value=Type_ChnOverlayData.Value
		From ChnOverlayData As[COD] Inner Join @Type_ChnOverlayData As[Type_ChnOverlayData] 
		On COD.ID = Type_ChnOverlayData.ID

		--Delete ChnOverlayData Where Not Required.
		Delete From ChnOverlayData  
		Where ID In(
		Select ChnOverlayData.ID 
		From ChnOverlayData Inner Join @Type_ChnOverlayData As[Type_ChnOverlayData] On ChnOverlayData.OverlayObjID = Type_ChnOverlayData.OverlayObjID And ChnOverlayData.ChnOverlayChildID = Type_ChnOverlayData.ChnOverlayChildID
		And ChnOverlayData.ID Not in(Select ID From @TempReturn)
		And ChnOverlayData.ID Not In(Select ID From @Type_ChnOverlayData Where ID <> 0))
		
		--ChnOverlayStyle First Check If Record
		Update COStyle Set Particular=Type_ChnOverlayStyle.Particular,Value=Type_ChnOverlayStyle.Value
		From ChnOverlayStyle As[COStyle] Inner Join @Type_ChnOverlayStyle As[Type_ChnOverlayStyle] 
		On COStyle.ID = Type_ChnOverlayStyle.ID

		
		Insert Into ChnOverlayStyle(ChnOverlayDataID,Particular,Value)
		Select ChnOverlayDataID,Particular,Value 
		From @Type_ChnOverlayStyle As[Type_ChnOverlayStyle] 
		Where  Type_ChnOverlayStyle.ID=0 And Type_ChnOverlayStyle.ChnOverlayDataID <> 0
		And Not Exists(Select 1 From ChnOverlayStyle Where ChnOverlayDataID=Type_ChnOverlayStyle.ChnOverlayDataID And Particular=Type_ChnOverlayStyle.Particular)
		
		Update ChnOverlayChild Set IsDisplay=Type_ChnOverlayChild_5.IsDisplay
		From ChnOverlayChild Inner Join @Type_ChnOverlayChild_5 As[Type_ChnOverlayChild_5] 
		On ChnOverlayChild.ID = Type_ChnOverlayChild_5.ChnOverlayChildID
	
		Set @ReturnID = (Select STRING_AGG(Cast(ID As varchar(Max)),',') From @TempReturn)
		Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_ChnOverlayData',@ReturnID ,'True',NULL)
End		