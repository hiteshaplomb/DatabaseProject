--Develop 07 02 2022, Getting Overlay.
CREATE Procedure [dbo].[GetOverlayMst]
	@Type TinyInt
As
SET NOCOUNT ON;
Begin

	If @Type=1 Or @Type=0
	--Image
	Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Name,Value As[Particular],
	Dbo.GetFileName(Value) As[File]
	From OverlayMst 
	Where Dbo.ExistFile(Value)='True' And Type=1 And TrnStatus=1
	Order by ID Desc

	If @Type=2 Or @Type=0
	--Sequence Image
	Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Name,Value As[Particular],
	Dbo.GetFileName(Value) As[File]
	From OverlayMst
	Where Dbo.ExistDirectory(Value)='True' And Type=2 And TrnStatus=1
	Order by ID Desc

	If @Type=6 Or @Type=0
	--Flash 
	Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Name,Value As[Particular],
	Dbo.GetFileName(Value) As[File]
	From OverlayMst
	Where Dbo.ExistFile(Value)='True' And Type=6 And TrnStatus=1
	Order by ID Desc

	If @Type=5 Or @Type=0
	--Template
	Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Name,Value As[Particular],
	Dbo.GetFileName(Value) As[File]
	From OverlayMst
	Where Dbo.ExistFile(Value)='True' And Type=5 And TrnStatus=1
	Order by ID Desc

	
	If @Type=7 Or @Type=0
	--Template
	Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Name,Value As[Particular],
	Dbo.GetFileName(Value) As[File]
	From OverlayMst
	Where Dbo.ExistFile(Value)='True' And Type=7 And TrnStatus=1
	Order by ID Desc

End
