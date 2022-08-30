--Develop 13 10 2021--Some Time Single Content Removed Related task.
CREATE PROCEDURE [dbo].[CRUD_ChnContentChild]
	@TrnMode Dbo.TrnMode, --1=Insert | 2=Update(Currently Used Only) | 3=Delete 4=GetRecord 5-Used For Auto Entry Time, 
	@IDs Varchar(Max)=NULL, --ChnContentChild PrimaryKey Commaseprated.
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL, -- Pass 2 For DeActive
	@StartDate Datetime=NULL,
	@EndDate Datetime=NULL,
	@AllDay Bit=NULL,
	@Mon Bit=NULL,
	@Tue Bit=NULL,
	@Wed Bit=NULL,
	@Thu Bit=NULL,
	@Fri Bit=NULL,
	@Sat Bit=NULL,
	@Sun Bit=NULL
	
As
SET NOCOUNT ON;
BEGIN
----------------------------------------------------------------------------------------------------
	If @TrnMode=2 --Update Record Delete Funcationality We Have Not Develop On Status We Save.
	  Begin
		   Update ChnContentChild Set TrnStatus=@TrnStatus,TrnUserID=@TrnUserID,TrnDate=GetDate(),
		   StartDate=Cast(@StartDate As Date),EndDate=Cast(@EndDate As Date),
		   AllDay=@AllDay,Mon=@Mon,Tue=@Tue,Wed=@Wed,Thu=@Thu,Fri=@Fri,Sat=@Sat,Sun=@Sun
		   Where ID In(Select Value From string_split(@IDs,','))
	  End
		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnContentChild',0,'True',NULL)
END
