CREATE TABLE [dbo].[ChnOverlayStyle] (
    [ID]               [dbo].[PID]   IDENTITY (1, 1) NOT NULL,
    [ChnOverlayDataID] [dbo].[PID]   NULL,
    [Particular]       VARCHAR (200) NULL,
    [Value]            VARCHAR (200) NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ChnOverlayContent''s ID. ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayStyle', @level2type = N'COLUMN', @level2name = N'ChnOverlayDataID';

