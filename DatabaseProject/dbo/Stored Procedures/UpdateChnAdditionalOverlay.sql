--Develop 10 09 2021
CREATE PROCEDURE [dbo].[UpdateChnAdditionalOverlay]
(
 @Id int,
 @ItemType varchar(250),
 @OverlayId varchar(250),
 @TemplateName varchar(max),
 @XmlData text,
 @FileName text,
 @FilePath text,
 @status bit,
 @ChnId int,
 @TimeToDisplay int,
 @TimeToHide int,
 @TimeToShow int,
 @IsDisplayProgram int,
 @IsDisplayAdvt int,
 @IsDisplayFiller int
)
As
SET NOCOUNT ON;
BEGIN
	
UPDATE dbo.ChnAdditionalOverlay
SET  ItemType = @ItemType, OverlayId = @OverlayId, TemplateName = @TemplateName, XmlData = @XmlData, FileName = @FileName, FilePath = @FilePath, status = @status, ChnId = @ChnId, TimeToDisplay = @TimeToDisplay, TimeToHide = @TimeToHide, TimeToShow = @TimeToShow, IsDisplayProgram = @IsDisplayProgram, IsDisplayAdvt = @IsDisplayAdvt, IsDisplayFiller = @IsDisplayFiller
WHERE id=@Id;


END



