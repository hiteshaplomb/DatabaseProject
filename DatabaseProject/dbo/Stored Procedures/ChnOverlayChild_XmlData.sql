--Develop 16 03 2022 This Is Special for XMLData Update Time Used And Its Temporary.
CREATE PROCEDURE [dbo].[ChnOverlayChild_XmlData]
	@IDs Varchar(Max), --ChnContentChild PrimaryKey Commaseprated.
	@XMLData Varchar(Max)
As
SET NOCOUNT ON;
BEGIN
----------------------------------------------------------------------------------------------------
	Update ChnOverlayChild Set XMLData=@XMLData Where ID In(Select value from string_split(@IDs,','))

		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'ChnOverlayChild_XmlData',0,'True',NULL)
END
