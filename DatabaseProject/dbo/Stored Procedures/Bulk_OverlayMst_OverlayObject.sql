--Develop 21 05 2022 This Is Used When Ticker Control Object Stored.
CREATE PROCEDURE [dbo].[Bulk_OverlayMst_OverlayObject]
	@Type_OverlayMst Dbo.Type_OverlayMst Readonly,
	@Type_OverlayObject Type_OverlayObject Readonly,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @TempReturn Table(ID Int,Value Varchar(Max))

	--Insert Record To ContentMst Main Table IF Type And Path Not Found.
	Insert Into OverlayMst(Name,Type,Value,TrnStatus,TrnUserID,TrnDate)
	Output inserted.ID,inserted.Value into @TempReturn
	Select 'N/A',Type,Path,@TrnStatus,@TrnUserID,Getdate() From @Type_OverlayMst As[Type_OverlayMst]
	Where Not Exists(Select 1 From OverlayMst With(NoLock) Where Type=Type_OverlayMst.Type And OverlayMst.Value=Type_OverlayMst.Path And TrnStatus=1)
	
	--OverlayObject Related Table.
	Insert Into OverlayObject(OverlayID,Name,GroupType)
	Select OverlayMst.ID,Type_OverlayObject.Name,Type_OverlayObject.GroupType
	From @Type_OverlayObject As[Type_OverlayObject] Inner Join OverlayMst On Type_OverlayObject.OverlayValue = OverlayMst.Value
	Where Not Exists(Select 1 From OverlayObject Where Name=Type_OverlayObject.Name And OverlayID=OverlayMst.ID)
	
	

	--If Exists(Select 1 From @Type_OverlayObject)
	--  Begin
	--		Insert Into OverlayObject(OverlayID,Name,GroupType)
	--		Select TempReturn.ID,Name,GroupType
	--		From @Type_OverlayObject As[Type_OverlayObject] Inner Join @TempReturn As[TempReturn] On Type_OverlayObject.OverlayValue = TempReturn.Value
	--		Where Type_OverlayObject.ID=0 And Type_OverlayObject.OverlayID=0

	--		--This Is For new Insert Object After Changes.
	--		Insert Into OverlayObject(OverlayID,Name,GroupType)
	--		Select OverlayID,Name,GroupType
	--		From @Type_OverlayObject As[Type_OverlayObject] 
	--		Where Type_OverlayObject.ID=0 And Type_OverlayObject.OverlayID<>0

	--		--This Is for Update Record.
	--		Update OverlayObject Set Name=OverlayObject.Name,GroupType=OverlayObject.Name
	--		From OverlayObject Inner Join @Type_OverlayObject As[Type_OverlayObject] On OverlayObject.ID = Type_OverlayObject.ID
	--  End

	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_OverlayMst',0,'True',NULL)
END
