CREATE TABLE [dbo].[ChnAdditionalOverlay] (
    [Id]               INT           IDENTITY (1, 1) NOT NULL,
    [ItemType]         VARCHAR (50)  NULL,
    [OverlayId]        VARCHAR (255) NULL,
    [TemplateName]     VARCHAR (255) NULL,
    [XmlData]          TEXT          NULL,
    [FileName]         TEXT          NULL,
    [FilePath]         TEXT          NULL,
    [Status]           BIT           NULL,
    [ChnId]            INT           NULL,
    [TimeToDisplay]    INT           NULL,
    [TimeToHide]       INT           NULL,
    [TimeToShow]       INT           NULL,
    [IsDisplayProgram] BIT           NULL,
    [IsDisplayAdvt]    BIT           NULL,
    [IsDisplayFiller]  BIT           NULL,
    CONSTRAINT [PK_OverlayAdditionalItems] PRIMARY KEY CLUSTERED ([Id] ASC)
);

