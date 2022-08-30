--Develop 22 09 2021, Getting ChnContentChild Detail
CREATE PROCEDURE [dbo].[GetChnContentChild]
(
   @ChnID Dbo.ChnID,
   @Type Int, --0-All 1-Program 2-Adverstise 3-Song 
   @FileList Varchar(Max)=NULL
)
As
Set NoCount ON;
Begin
	If @Type=0 Or @Type=1	
	  Begin
		  If Isnull(@FileList,'') = ''
		 	Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=1 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True' 
			Order by ChnContentChild.Sequence
		  Else
			Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=1 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True'  And ChnContentChild.ID In(Select value From string_split(@FileList,','))
			Order by ChnContentChild.Sequence
	  End

	If @Type=0 Or @Type=2
	  Begin
		  If Isnull(@FileList,'') = ''
			Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=2 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True'
			Order by ChnContentChild.Sequence
		  Else
		    Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=2 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True' And ChnContentChild.ID In(Select value From string_split(@FileList,','))
			Order by ChnContentChild.Sequence
	  End
	  
	If @Type=0 Or @Type=3
      Begin
		  If Isnull(@FileList,'') = ''
			Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=3 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True'
			Order by ChnContentChild.Sequence
		  Else
		    Select ChnContentChild.ID,ROW_NUMBER() Over(Order by ChnContentChild.Sequence) As[SrNo],ChnContentChild.ContentID,ContentMst.Path,Dbo.GetFileName(ContentMst.Path) As[FileName]
			From ContentMst Inner Join ChnContentChild On ContentMst.ID = ChnContentChild.ContentID
			Where ContentMst.Type=3 And ChnContentChild.ChnID=@ChnID And ChnContentChild.TrnStatus=1 And ContentMst.TrnStatus=1
			And Dbo.ExistFile(ContentMst.Path)='True' And ChnContentChild.ID In(Select value From string_split(@FileList,','))
			Order by ChnContentChild.Sequence
	  End
End