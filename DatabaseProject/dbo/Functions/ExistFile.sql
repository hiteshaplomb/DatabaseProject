
--Develop 09 10 2021
CREATE FUNCTION [dbo].[ExistFile]
(
  @FilePath As Dbo.Path
 
) RETURNS bit
AS
BEGIN
	Declare @IsExists bit
	Declare @i Int

	Exec xp_fileexist @FilePath,@i out
	--Exec master..xp_fileexist @file,@i out

	Set @IsExists = Case When @i=1 Then 'True' Else 'False' End

		
 RETURN @IsExists
END

