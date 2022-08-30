--Develop 30 09 2021, Getting Type
CREATE PROCEDURE [dbo].[GetContentMst]
(
 @Type TinyInt,
 @ChnID Dbo.ChnID=NULL --While Pass That Time, ChannelMaster.
 
)
As
SET NOCOUNT ON;
Begin
	--Select ID,Path As[Particular],Cast(Case When TrnStatus=1 Then 'True' When TrnStatus=2 Then 'False' End As Bit) As[Status]
	--From ContentMst Where Type=@Type Order by Path

	--Select ID,ROW_NUMBER() Over(Order by Path) As[SrNo],Path As[Particular],TrnStatus As[Status]
	--From ContentMst Where Type=@Type Order by Path

	If @ChnID Is NULL
		Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Path As[Particular],Dbo.GetFileName(Path) As[File],
		Case When TrnStatus=1 Then 'Active' When TrnStatus=2 Then 'DeActive' End  As[Status]
		From ContentMst Where TrnStatus=1 And Type=@Type And Dbo.ExistFile(Path)='True'  
		Order by ID Desc
	Else
		Begin
			If @Type=1 --Program
				Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Dbo.GetFileName(Path) As[File],Path As[Particular],Case When TrnStatus=1 Then 'Active' When TrnStatus=2 Then 'DeActive' End  As[Status]
				From ContentMst Where TrnStatus=1 And Type=@Type  
				--And ID Not In(Select ContentID From ChnContentChild Where ChnID=@ChnID And TrnStatus=1)
				And Dbo.ExistFile(Path)='True' 
				Order by ID Desc
			Else If @Type=3 --Filler
				Select ID,ROW_NUMBER() Over(Order by ID Desc) As[SrNo],Dbo.GetFileName(Path) As[File],Path As[Particular],Case When TrnStatus=1 Then 'Active' When TrnStatus=2 Then 'DeActive' End  As[Status]
				From ContentMst Where TrnStatus=1 And Type=@Type 
				--And ID Not In(Select ContentID From ChnContentChild Where ChnID=@ChnID And TrnStatus=1)
				And Dbo.ExistFile(Path)='True'
				Order by ID Desc
			Else If @Type=2 --Advt
				Select Isnull(ChnContentChild.ID,0) As[ID],ContentMst.ID As[ContentID],
				ROW_NUMBER() Over(Order by ContentMst.ID Desc) As[SrNo],
				Dbo.GetFileName(Path) As[File],Path As[Particular],Isnull(ChnContentChild.TrnStatus,0) As[Status],
				Isnull(ChnContentChild.StartDate,GetDate()) As[StartDate],Isnull(ChnContentChild.EndDate,DATEADD(MONTH,1,GetDate())) As[EndDate],
				Isnull(ChnContentChild.AllDay,'False') As[AllDay],Isnull(ChnContentChild.Mon,'False') As[Mon],
				Isnull(ChnContentChild.Tue,'False') As[Tue],Isnull(ChnContentChild.Wed,'False') As[Wed],
				Isnull(ChnContentChild.Thu,'False') As[Thu],Isnull(ChnContentChild.Fri,'False') As[Fri],
				Isnull(ChnContentChild.Sat,'False') As[Sat],Isnull(ChnContentChild.Sun,'False') As[Sun]
				From ContentMst Left Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1
				Where ContentMst.TrnStatus=1 And ContentMst.Type=2 And Dbo.ExistFile(ContentMst.Path)='True'
				Order by ContentMst.ID Desc

				--Begin
				--	If Isnull(@SlotID,0)=0
				--		Select Isnull(ChnContentChild.ID,0) As[ID],ContentMst.ID As[ContentID],
				--		ROW_NUMBER() Over(Order by ContentMst.ID Desc) As[SrNo],
				--		Dbo.GetFileName(Path) As[File],Path As[Particular],Isnull(ChnContentChild.TrnStatus,0) As[Status],
				--		Isnull(ChnContentChild.StartDate,GetDate()) As[StartDate],Isnull(ChnContentChild.EndDate,GetDate()) As[EndDate],
				--		Isnull(ChnContentChild.AllDay,'False') As[AllDay],Isnull(ChnContentChild.Mon,'False') As[Mon],
				--		Isnull(ChnContentChild.Tue,'False') As[Tue],Isnull(ChnContentChild.Wed,'False') As[Wed],
				--		Isnull(ChnContentChild.Thu,'False') As[Thu],Isnull(ChnContentChild.Fri,'False') As[Fri],
				--		Isnull(ChnContentChild.Sat,'False') As[Sat],Isnull(ChnContentChild.Sun,'False') As[Sun]
				--		From ContentMst Left Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
				--		Where ContentMst.TrnStatus=1 And ContentMst.Type=2 And Dbo.ExistFile(ContentMst.Path)='True'
				--		Order by ContentMst.ID Desc
				--	Else
				--		Begin
				--			 --Select @ChnID=ChnID From ChnSlotMst Where ID=@SlotID
				--			 Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.ID Desc) As[SrNo],
				--			 Dbo.GetFileName(ContentMst.Path) As[File],ContentMst.Path As[Particular],
				--			 ChnContentChild.StartDate,ChnContentChild.EndDate,ChnContentChild.AllDay,
				--			 ChnContentChild.Mon,ChnContentChild.Tue,ChnContentChild.Wed,ChnContentChild.Thu,
				--			 ChnContentChild.Fri,ChnContentChild.Sat,ChnContentChild.Sun
				--			 From ContentMst Inner Join ChnContentChild On ContentMst.ID=ChnContentChild.ContentID
				--			 Where ContentMst.TrnStatus=1 And ContentMst.Type=@Type And ChnContentChild.TrnStatus=1
				--			 And ChnContentChild.ID Not In(Select ChnContentID From ChnSlotDetail With(NoLock) Where SlotID=@SlotID And TrnStatus=1)
				--			 And Dbo.ExistFile(Path)='True'
				--			 Order by ChnContentChild.ID Desc
				--		End
						
				--End
		End
		

End
