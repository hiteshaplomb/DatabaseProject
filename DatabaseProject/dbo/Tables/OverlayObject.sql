CREATE TABLE [dbo].[OverlayObject] (
    [ID]        [dbo].[PID]   IDENTITY (1, 1) NOT NULL,
    [OverlayID] [dbo].[PID]   NULL,
    [Name]      VARCHAR (250) NULL,
    [GroupType] VARCHAR (250) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Key Of  ChnOverlayChild''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OverlayObject', @level2type = N'COLUMN', @level2name = N'OverlayID';

