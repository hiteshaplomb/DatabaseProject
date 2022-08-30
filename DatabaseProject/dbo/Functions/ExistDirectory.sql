
--Develop 19 02 2022, Check sequence Is Exists Or Not.
Create FUNCTION [dbo].[ExistDirectory]
(
  @DirectoryPath As Dbo.Path
 
) RETURNS bit
AS
BEGIN
	Declare @IsExists bit
	
	

	If Exists(Select 1 From sys.dm_os_file_exists(@DirectoryPath) Where file_is_a_directory=1)
		Set @IsExists='True'
	Else
		Set @IsExists='False'

	
 RETURN @IsExists
END

