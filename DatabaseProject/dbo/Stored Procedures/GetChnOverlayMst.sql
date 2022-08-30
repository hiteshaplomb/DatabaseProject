--Develop 08 mar 2022 This is For ChnOverlayMst
CREATE Procedure [dbo].[GetChnOverlayMst]
	@Type TinyInt,		  --Pass ChnOverlayMst Type 1=Static 2=Sequence 3-Ticker 7=Text 8=FlashVariable
	@ChnID Dbo.ChnID --While Pass That Time, ChannelMaster.
As
SET NOCOUNT ON;
Begin

	If @Type=1
	   Begin
			Select Isnull(ChnOverlayChild.ID,0) As[ID],OverlayMst.ID As[OverlayID],
			Case OverlayMst.Type When 1 Then 'Image' When 2 Then 'Image Seq' When 3 Then 'Text' When 4 Then 'Ticker' When 5 Then 'Template' When 6 Then 'Flash' Else '' End As[Type],
			ROW_NUMBER() Over(Order by OverlayMst.ID Desc) As[SrNo],Name,Value As[Particular],Dbo.GetFileName(Value) As[File],
			Cast(Isnull(ChnOverlayChild.TrnStatus,0) As int) As[Status],
			Isnull(ChnOverlayChild.StartDate,GetDate()) As[StartDate],Isnull(ChnOverlayChild.EndDate,DATEADD(MONTH,1,GetDate())) As[EndDate],
			Isnull(ChnOverlayChild.AllDay,'False') As[AllDay],Isnull(ChnOverlayChild.Mon,'False') As[Mon],
			Isnull(ChnOverlayChild.Tue,'False') As[Tue],Isnull(ChnOverlayChild.Wed,'False') As[Wed],
			Isnull(ChnOverlayChild.Thu,'False') As[Thu],Isnull(ChnOverlayChild.Fri,'False') As[Fri],
			Isnull(ChnOverlayChild.Sat,'False') As[Sat],Isnull(ChnOverlayChild.Sun,'False') As[Sun]
			From OverlayMst Left Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID 
			And ChnOverlayChild.Type=@Type And ChnOverlayChild.ChnID=@ChnID
			Where (Dbo.ExistFile(OverlayMst.Value)='True' Or (Dbo.ExistDirectory(OverlayMst.Value)='True' And OverlayMst.Type=2)) 
			And OverlayMst.TrnStatus=1 And OverlayMst.Type In(1,2,6)
			Order by OverlayMst.ID Desc
	   End
	Else If @Type=2
	   Begin
			Select Isnull(ChnOverlayChild.ID,0) As[ID],OverlayMst.ID As[OverlayID],
			Case OverlayMst.Type When 1 Then 'Image' When 2 Then 'Image Seq' When 3 Then 'Text' When 4 Then 'Ticker' When 5 Then 'Template' When 6 Then 'Flash' When 7 Then 'Text Template' Else '' End As[Type],
			ROW_NUMBER() Over(Order by OverlayMst.ID Desc) As[SrNo],Name,Value As[Particular],Dbo.GetFileName(Value) As[File],
			Cast(Isnull(ChnOverlayChild.TrnStatus,0) As int) As[Status],
			Isnull(ChnOverlayChild.StartDate,GetDate()) As[StartDate],Isnull(ChnOverlayChild.EndDate,DATEADD(MONTH,1,GetDate())) As[EndDate],
			Isnull(ChnOverlayChild.AllDay,'False') As[AllDay],Isnull(ChnOverlayChild.Mon,'False') As[Mon],
			Isnull(ChnOverlayChild.Tue,'False') As[Tue],Isnull(ChnOverlayChild.Wed,'False') As[Wed],
			Isnull(ChnOverlayChild.Thu,'False') As[Thu],Isnull(ChnOverlayChild.Fri,'False') As[Fri],
			Isnull(ChnOverlayChild.Sat,'False') As[Sat],Isnull(ChnOverlayChild.Sun,'False') As[Sun]
			From OverlayMst Left Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID 
			And ChnOverlayChild.Type=@Type And ChnOverlayChild.ChnID=@ChnID And ChnOverlayChild.TrnStatus=1
			Where OverlayMst.TrnStatus=1
			And OverlayMst.Type In(2,6)
			And ((Dbo.ExistFile(OverlayMst.Value)='True' And Right(OverlayMst.Value,4)='.swf') Or (Dbo.ExistDirectory(OverlayMst.Value)='True' And OverlayMst.Type=2))
			Order by OverlayMst.ID Desc
	   End
	Else If @Type=3 --Ticker
	   Begin
			Select Isnull(ChnOverlayChild.ID,0) As[ID],OverlayMst.ID As[OverlayID],
			Case OverlayMst.Type When 1 Then 'Image' When 2 Then 'Image Seq' When 3 Then 'Text' When 4 Then 'Ticker' When 5 Then 'Template' When 6 Then 'Flash' When 7 Then 'Text Template' End As[Type],
			ROW_NUMBER() Over(Order by OverlayMst.ID Desc) As[SrNo],Name,Value As[Particular],Dbo.GetFileName(Value) As[File],
			Cast(Isnull(ChnOverlayChild.TrnStatus,0) As int) As[Status]
			From OverlayMst Left Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID
			And ChnOverlayChild.Type=@Type And ChnOverlayChild.ChnID=@ChnID And ChnOverlayChild.TrnStatus=1
			Where OverlayMst.TrnStatus=1 And OverlayMst.Type=5
			And (Dbo.ExistFile(OverlayMst.Value)='True' And Right(OverlayMst.Value,5)='.atcg')
			Order by OverlayMst.ID Desc
	   End

	Else If @Type=7 --Text Template
	   Begin
			Select Isnull(ChnOverlayChild.ID,0) As[ID],OverlayMst.ID As[OverlayID],
			Case OverlayMst.Type When 1 Then 'Image' When 2 Then 'Image Seq' When 3 Then 'Text' When 4 Then 'Ticker' When 5 Then 'Template' When 6 Then 'Flash' When 7 Then 'Text Template' End As[Type],
			ROW_NUMBER() Over(Order by OverlayMst.ID Desc) As[SrNo],Name,Value As[Particular],Dbo.GetFileName(Value) As[File],
			Cast(Isnull(ChnOverlayChild.TrnStatus,0) As int) As[Status],ChnOverlayChild.ShowTime,ChnOverlayChild.EndTime,ChnOverlayChild.HideTime,ChnOverlayChild.IsDispProgram,IsDispFiller,IsDispAdvt
			From OverlayMst Left Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID
			And ChnOverlayChild.Type=@Type And ChnOverlayChild.ChnID=@ChnID And ChnOverlayChild.TrnStatus=1
			Where OverlayMst.TrnStatus=1 And OverlayMst.Type=7
			And (Dbo.ExistFile(OverlayMst.Value)='True' And Right(OverlayMst.Value,5)='.atcg')
			Order by OverlayMst.ID Desc
	   End
	Else If @Type=8 --Flash Variable.
	   Begin
			Select Isnull(ChnOverlayChild.ID,0) As[ID],OverlayMst.ID As[OverlayID],'Flash' As[Type],
			ROW_NUMBER() Over(Order by OverlayMst.ID Desc) As[SrNo],Name,Value As[Particular],Dbo.GetFileName(Value) As[File],
			Cast(Isnull(ChnOverlayChild.TrnStatus,0) As int) As[Status],
			Isnull(ChnOverlayChild.StartDate,GetDate()) As[StartDate],Isnull(ChnOverlayChild.EndDate,DATEADD(MONTH,1,GetDate())) As[EndDate],
			Isnull(ChnOverlayChild.AllDay,'False') As[AllDay],Isnull(ChnOverlayChild.Mon,'False') As[Mon],
			Isnull(ChnOverlayChild.Tue,'False') As[Tue],Isnull(ChnOverlayChild.Wed,'False') As[Wed],
			Isnull(ChnOverlayChild.Thu,'False') As[Thu],Isnull(ChnOverlayChild.Fri,'False') As[Fri],
			Isnull(ChnOverlayChild.Sat,'False') As[Sat],Isnull(ChnOverlayChild.Sun,'False') As[Sun]
			From OverlayMst Left Join ChnOverlayChild On OverlayMst.ID = ChnOverlayChild.OverlayID 
			And ChnOverlayChild.Type=@Type And ChnOverlayChild.ChnID=@ChnID And ChnOverlayChild.TrnStatus=1
			Where OverlayMst.TrnStatus=1
			And OverlayMst.Type In(6)
			And Dbo.ExistFile(OverlayMst.Value)='True' And Right(OverlayMst.Value,4)='.swf'
	   End
	
End
