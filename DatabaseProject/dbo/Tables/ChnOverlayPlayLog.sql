CREATE TABLE [dbo].[ChnOverlayPlayLog] (
    [ID]             [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnID]          [dbo].[ChnID]     NULL,
    [OverlayID]      [dbo].[PID]       NULL,
    [OverlayChildID] [dbo].[PID]       NULL,
    [FilePath]       VARCHAR (MAX)     NULL,
    [Duration]       TIME (7)          NULL,
    [Playtime]       DATETIME          NULL,
    [Sequence]       INT               NULL,
    [OverlayType]    TINYINT           NULL,
    [Type]           TINYINT           NULL,
    [RefID]          [dbo].[PID]       NOT NULL,
    [StartDate]      DATETIME          NULL,
    [EndDate]        DATETIME          NULL,
    [AllDay]         BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_AllDay] DEFAULT ('False') NULL,
    [Mon]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Mon] DEFAULT ('False') NULL,
    [Tue]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Tue] DEFAULT ('False') NULL,
    [Wed]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Wed] DEFAULT ('False') NULL,
    [Thu]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Thu] DEFAULT ('False') NULL,
    [Fri]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Fri] DEFAULT ('False') NULL,
    [Sat]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Sat] DEFAULT ('False') NULL,
    [Sun]            BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_Sun] DEFAULT ('False') NULL,
    [XMLData]        VARCHAR (MAX)     NULL,
    [IsDispProgram]  BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_IsDispProgram] DEFAULT ('False') NULL,
    [IsDispFiller]   BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_IsDispFiller] DEFAULT ('False') NULL,
    [IsDispAdvt]     BIT               CONSTRAINT [DF_ChnOverlayPlayLog1_IsDispAdvt] DEFAULT ('False') NULL,
    [TrnUserID]      [dbo].[TrnUserID] NULL,
    [TrnStatus]      [dbo].[TrnStatus] NULL,
    [TrnDate]        [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_ChnOverlayPlayLog1] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-Image 2-SequenceImage 3-Text 4-Ticker 5-TemplateFilePath 6-Flash 7-TextTemplate 8-PIP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayPlayLog', @level2type = N'COLUMN', @level2name = N'OverlayType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=Static 2=Sequence', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayPlayLog', @level2type = N'COLUMN', @level2name = N'Type';

