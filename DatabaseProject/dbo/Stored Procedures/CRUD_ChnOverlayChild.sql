--Develop 13 10 2021--Some Time Single Content Removed Related task.
CREATE PROCEDURE [dbo].[CRUD_ChnOverlayChild]
	@TrnMode Dbo.TrnMode,   --1=Insert | 2=Update(Currently Used Only) | 3=Delete 4=GetRecord 5-Used For Auto Entry Time, 
	@IDs Varchar(Max)=NULL, --ChnContentChild PrimaryKey Commaseprated.
	@TrnUserID Dbo.TrnUserID = NULL,
	@TrnStatus Dbo.TrnStatus=NULL -- Pass 2 For DeActive
As
SET NOCOUNT ON;
BEGIN
----------------------------------------------------------------------------------------------------
	If @TrnMode=2 --Update Record Delete Funcationality We Have Not Develop On Status We Save.
	  Begin
		   -- When Trnstatus=2 That time We set AllDay And Other set to deactive if not then issue when allday=true and assign screen it will autometicaly status=1 set as per datatrigger.	
		   Update ChnOverlayChild Set TrnStatus=@TrnStatus,TrnUserID=@TrnUserID,TrnDate=GetDate(),
		   AllDay=Case When @TrnStatus=2 Then 'False' Else AllDay End,
		   Mon=Case When @TrnStatus=2 Then 'False' Else Mon End,
		   Tue=Case When @TrnStatus=2 Then 'False' Else Tue End,
		   Wed=Case When @TrnStatus=2 Then 'False' Else Wed End,
		   Thu=Case When @TrnStatus=2 Then 'False' Else Thu End,
		   Fri=Case When @TrnStatus=2 Then 'False' Else Fri End,
		   Sat=Case When @TrnStatus=2 Then 'False' Else Sat End,
		   Sun=Case When @TrnStatus=2 Then 'False' Else Sun End

		   Where ID In(Select Value From string_split(@IDs,','))

		   If Exists(Select 1 From ChnOverlayData Where ChnOverlayChildID In(Select Value From string_split(@IDs,',')))
			 Begin
					Delete From ChnOverlayStyle 
					Where ChnOverlayDataID In(
					Select ID From ChnOverlayData Where ChnOverlayChildID In(Select Value From string_split(@IDs,',')))
					
					Delete From ChnOverlayData Where ChnOverlayChildID In(Select Value From string_split(@IDs,',')) 
			 End

	  End
		
	Select ObjName,RefID,IsSuccess,Msg From Dbo.Get_ProcResult(99,'CRUD_ChnOverlayChild',0,'True',NULL)
END
