CREATE TABLE [dbo].[ChnOverlayData] (
    [ID]                [dbo].[PID]    IDENTITY (1, 1) NOT NULL,
    [OverlayObjID]      [dbo].[PID]    NULL,
    [Value]             NVARCHAR (MAX) NULL,
    [ChnOverlayChildID] [dbo].[PID]    NULL,
    [SourceType]        VARCHAR (20)   NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'OverlayObject''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayData', @level2type = N'COLUMN', @level2name = N'OverlayObjID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ChnOverlayChild ''s ID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayData', @level2type = N'COLUMN', @level2name = N'ChnOverlayChildID';

