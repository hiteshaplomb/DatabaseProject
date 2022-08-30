--Develop 20 05 2022, Getting OverlayStyle Related Data.
Create PROCEDURE [dbo].[GetChnOverlayStyle]
(
   @IDs Varchar(Max) --ChnOverlayData's ID Commaseprated Value
)
As
Set NoCount ON;
Begin

	Select ID,ChnOverlayDataID,Particular,Value 
	From ChnOverlayStyle
	Where ChnOverlayDataID in (select value from string_split(@IDs,','))

End