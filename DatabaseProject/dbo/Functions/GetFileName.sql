
--Develop 21 09 2021 For Getting File Name From Path
CREATE FUNCTION [dbo].[GetFileName]
(
  @FilePath As varchar(max)
 
) RETURNS VARCHAR(MAX)
AS
BEGIN
	Declare @ReturnPath Varchar(Max)

	Set @ReturnPath = SUBSTRING(@FilePath,Len(@FilePath)- CHARINDEX('\', REVERSE(@FilePath),0) + 2,CHARINDEX('\', REVERSE(@FilePath),0)) 
	
 RETURN @ReturnPath
END

