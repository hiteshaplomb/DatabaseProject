--Develop 26 05 2022 Update Time 
CREATE Procedure [dbo].[Bulk_OverlayObject]
	@OverlayID Dbo.OverlayID,
	@Type_OverlayObject Type_OverlayObject Readonly,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''
	Declare @TempReturn Table(ID Int,Value Varchar(Max))

	
	Delete From OverlayObject Where OverlayID=@OverlayID 
	And Name Not In(Select Name From @Type_OverlayObject)

	--OverlayObject Related Table.
	Insert Into OverlayObject(OverlayID,Name,GroupType)
	Select OverlayMst.ID,Type_OverlayObject.Name,Type_OverlayObject.GroupType
	From @Type_OverlayObject As[Type_OverlayObject] Inner Join OverlayMst On Type_OverlayObject.OverlayValue = OverlayMst.Value
	Where Not Exists(Select 1 From OverlayObject Where Name=Type_OverlayObject.Name And OverlayID=OverlayMst.ID)
	
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'Bulk_OverlayObject',0,'True',NULL)
END
