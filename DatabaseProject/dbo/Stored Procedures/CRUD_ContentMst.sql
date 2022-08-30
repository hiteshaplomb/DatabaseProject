--Develop 28 09 2021, Insert Record In ContentMaster Table. 
CREATE PROCEDURE [dbo].[CRUD_ContentMst]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update (Current Not Develop Only Insert And then Delete) | 3=Delete 4=GetRecord 5-Used For Auto Entry Time
	@ID Varchar(Max)=NULL out,
	@Type TinyInt=NULL,
	@Path Dbo.Path=NULL,
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL
	
As
SET NOCOUNT ON;
BEGIN
	
	Declare @ErrorMsg Varchar(Max)=''

	If @TrnMode=1
	  Begin
	  	 If Exists(Select 1 From ContentMst With(NoLock) Where Path=@Path)
	  		Set @ErrorMsg='Content Path already exists.'
	  End
	

	If @ErrorMsg <> ''
	  Begin
		  Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ContentMst',@ID,'False',@ErrorMsg)
		  Return
	  End
----------------------------------------------------------------------------------------------------

	If @TrnMode=1
	  Begin
		   Insert Into ContentMst(Type,Path,TrnUserID,TrnStatus,TrnDate)
		   Values(@Type,@Path,@TrnUserID,1,GetDate())

		   Set @ID=SCOPE_IDENTITY()
	  End
	
	Else If @TrnMode=3		
	  Begin	


		If Exists(Select 1 From ChnContentChild Where ContentID In(Select Value From string_split(@ID,',')))
		   Begin
				Delete From ContentMst Where ID In(Select Value From string_split(@ID,','))
				And ID Not In(Select ContentID From ChnContentChild)

				Update ContentMst Set TrnStatus=2 Where ID In(Select Value From string_split(@ID,','))
				And Not Exists(Select 1 From ChnContentChild Where ContentID=ContentMst.ID And ChnContentChild.TrnStatus=1)	

				Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ContentMst',@ID,'True','if Content entry available in channel content Then Not Delete Other Deleted.')
		   End
		Else
		   Begin
				Delete From ContentMst Where ID In(Select Value From string_split(@ID,','))
				And ID Not In(Select ContentID From ChnContentChild)

				Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(@TrnMode,'CRUD_ContentMst',0,'True',NULL)
		   End
	  End
END
