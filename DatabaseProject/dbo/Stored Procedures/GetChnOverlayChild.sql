--exec GetChnOverlayChild @ChnID=1,@Type=3,@RefIDList=2
--Develop 09 03 2022, Return All Overlay Tables example some table used for ticker so single click return all element.
CREATE PROCEDURE [dbo].[GetChnOverlayChild]
(
   @ChnID Dbo.ChnID,
   @Type Int, --0-All,1-Static,2-Sequence
   @RefIDList Varchar(Max)=NULL
)
As
Set NoCount ON;
Begin
	Create Table #TempOverlay(OverlayID BigInt)
	
	Insert Into #TempOverlay(OverlayID)
	Select Distinct ChnOverlayChild.OverlayID
	From OverlayMst Inner Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID
	Where ChnOverlayChild.Type=Case When @Type=0 Then ChnOverlayChild.Type Else @Type End
	And ChnOverlayChild.ChnID=@ChnID 
	And ChnOverlayChild.TrnStatus=1 And OverlayMst.TrnStatus=1
	And ((Dbo.ExistFile(OverlayMst.Value)='True' And OverlayMst.Type <> 2) Or (Dbo.ExistDirectory(OverlayMst.Value)='True' Or OverlayMst.Type=2))
	And ChnOverlayChild.ID Not In(Select value from string_split(@RefIDList,','))
	
	
	Select ChnOverlayChild.ID,ROW_NUMBER() Over(Partition By ChnOverlayChild.Type Order by ChnOverlayChild.Sequence) As[SrNo],
	ChnOverlayChild.OverlayID,OverlayMst.Value As[Path],
	Case When OverlayMst.Type=2 Then OverlayMst.Value Else Dbo.GetFileName(OverlayMst.Value) End As[FileName],
	Case OverlayMst.Type When 1 Then 'Image' When 2 Then 'Image Seq' When 3 Then 'Text' When 4 Then 'Ticker' When 5 Then 'Template' When 6 Then 'Flash' Else '' End As[Type],
	ChnOverlayChild.StartDate,ChnOverlayChild.EndDate,
	ChnOverlayChild.Type As[DisplayType],
	ChnOverlayChild.Mon,ChnOverlayChild.Tue,ChnOverlayChild.Wed,ChnOverlayChild.Thu,
	ChnOverlayChild.Fri,ChnOverlayChild.Sat,ChnOverlayChild.Sun,ChnOverlayChild.XMLData,
	Isnull(ChnOverlayChild.IsDispProgram,'False') As[IsDispProgram],
	Isnull(ChnOverlayChild.IsDispFiller,'False') As[IsDispFiller],
	Isnull(ChnOverlayChild.IsDispAdvt,'False') As[IsDispAdvt],	
	Isnull(ChnOverlayChild.IsDisplay,'False') As[IsDisplay]
	From OverlayMst Inner Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID
	Where ChnOverlayChild.Type=Case When @Type=0 Then ChnOverlayChild.Type Else @Type End
	And ChnOverlayChild.ChnID=@ChnID 
	And ChnOverlayChild.TrnStatus=1 And OverlayMst.TrnStatus=1
	And ((Dbo.ExistFile(OverlayMst.Value)='True' And OverlayMst.Type <> 2) Or (Dbo.ExistDirectory(OverlayMst.Value)='True' Or OverlayMst.Type=2))
	And ChnOverlayChild.ID Not In(Select value from string_split(@RefIDList,','))
	Order by ChnOverlayChild.Sequence


	Select OverlayObject.ID,OverlayObject.OverlayID,OverlayObject.Name,OverlayObject.GroupType 
	From OverlayObject Inner Join #TempOverlay As[TempOverlay] On  OverlayObject.OverlayID = TempOverlay.OverlayID
	
	
	Select ID,OverlayObjID,Value,ChnOverlayChildID,SourceType 
	From ChnOverlayData 

	Select ID,ChnOverlayDataID,Particular,Value From ChnOverlayStyle

	Select ID,ChnOverlayChildID,Name,Value From ChnOverlayObjectAndData
End