--Develop 21 03 2022 This Procedure Used For IsDispProgram,Advt,Filler Related Task.
CREATE PROCEDURE [dbo].[Bulk_ChnOverlayChild_Other]
	@Type_ChnOverlayChildOther Dbo.Type_ChnOverlayChildOther Readonly
As
SET NOCOUNT ON;
BEGIN
----------------------------------------------------------------------------------------------------
	Update COC Set StartDate=Type_COC.StartDate,EndDate=Type_COC.EndDate,
	Mon=Type_COC.Mon,Tue=Type_COC.Tue,Wed=Type_COC.Wed,Thu=Type_COC.Thu,Fri=Type_COC.Fri,
	Sat=Type_COC.Sat,Sun=Type_COC.Sun,XMLData=Type_COC.XMLData,
	IsDispProgram=Type_COC.IsDispProgram,IsDispFiller=Type_COC.IsDispFiller,IsDispAdvt=Type_COC.IsDispAdvt
	From ChnOverlayChild As[COC] Inner Join @Type_ChnOverlayChildOther As[Type_COC] On COC.ID = Type_COC.ID

			
		--Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'ChnOverlayChild_Other',0,'True',NULL)
	  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'ChnOverlayChild_Other',SCOPE_IDENTITY(),'True',NULL)

END
