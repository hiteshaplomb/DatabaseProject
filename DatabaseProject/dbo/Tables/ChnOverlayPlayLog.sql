CREATE TABLE [dbo].[ChnOverlayPlayLog] (
    [ID]             [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [OverlayID]      [dbo].[PID]       NULL,
    [FilePath]       VARCHAR (MAX)     NULL,
    [Duration]       TIME (7)          NULL,
    [Playtime]       DATETIME          NULL,
    [OverlayType]    TINYINT           NULL,
    [Type]           TINYINT           NULL,
    [RefID]          [dbo].[PID]       NOT NULL,
    [TrnUserID]      [dbo].[TrnUserID] NULL,
    [TrnDate]        [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_ChnOverlayPlayLog1] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-Image 2-SequenceImage 3-Text 4-Ticker 5-TemplateFilePath 6-Flash 7-TextTemplate 8-PIP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayPlayLog', @level2type = N'COLUMN', @level2name = N'OverlayType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=Static 2=Sequence', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayPlayLog', @level2type = N'COLUMN', @level2name = N'Type';

