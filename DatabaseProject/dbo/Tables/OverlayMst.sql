CREATE TABLE [dbo].[OverlayMst] (
    [ID]        [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (250)     NULL,
    [Type]      TINYINT           NULL,
    [Value]     VARCHAR (MAX)     NULL,
    [TrnStatus] [dbo].[TrnStatus] NULL,
    [TrnUserID] [dbo].[TrnUserID] NULL,
    [TrnDate]   [dbo].[TrnDate]   NULL,
    [XMLData]   VARCHAR (MAX)     NULL,
    CONSTRAINT [PK_OverlayMst] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-Image 2-SequenceImage 3-Text 4-Ticker 5-TemplateFilePath 6-Flash 7-TextTemplate 8-PIP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OverlayMst', @level2type = N'COLUMN', @level2name = N'Type';

