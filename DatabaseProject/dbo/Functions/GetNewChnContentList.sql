
--Develop 11 01 2022, Getting ChnWisecontentList Which Is New Added.
CREATE Function [dbo].[GetNewChnContentList]
(
  @ChnID Dbo.ChnID,
  @Type TinyInt,
  @RefIDList NVarchar(Max)
 
) RETURNS VARCHAR(MAX)
AS
Begin
	Declare @ReturnPath Varchar(Max)

	Set @ReturnPath=(Select STRING_AGG(ChnContentChild.ID,',') 
	From ChnContentChild Inner Join ContentMst On ChnContentChild.ContentID = ContentMst.ID
	Where ChnContentChild.ChnID=@ChnID And ChnContentChild.ID Not in(Select value From string_split(@RefIDList,','))
	And ContentMst.TrnStatus=1 And ContentMst.Type=@Type 
	And Dbo.ExistFile(ContentMst.Path)='True' And ChnContentChild.TrnStatus=1)

	RETURN @ReturnPath
End