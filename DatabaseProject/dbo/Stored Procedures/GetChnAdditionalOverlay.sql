-- Stored Procedure

--Develop 10 09 2021
CREATE PROCEDURE [dbo].[GetChnAdditionalOverlay]
(
 @ChnID int=NULL,
 @Id int = NULL
)
As
SET NOCOUNT ON;
BEGIN

IF @Id IS NULL
    BEGIN
        select * from ChnAdditionalOverlay where ChnId = @ChnID;
    END
ELSE
    BEGIN
        select * from ChnAdditionalOverlay where Id = @Id;
    END

END



