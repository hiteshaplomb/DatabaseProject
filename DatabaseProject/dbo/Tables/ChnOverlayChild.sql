CREATE TABLE [dbo].[ChnOverlayChild] (
    [ID]            [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnID]         [dbo].[ChnID]     NULL,
    [OverlayID]     [dbo].[PID]       NULL,
    [TrnUserID]     [dbo].[TrnUserID] NULL,
    [TrnStatus]     [dbo].[TrnStatus] NULL,
    [TrnDate]       [dbo].[TrnDate]   NULL,
    [Sequence]      INT               NULL,
    [Type]          TINYINT           NULL,
    [StartDate]     DATETIME          NULL,
    [EndDate]       DATETIME          NULL,
    [AllDay]        BIT               CONSTRAINT [DF_ChnOverlayChild_AllDay] DEFAULT ('False') NULL,
    [Mon]           BIT               CONSTRAINT [DF_ChnOverlayChild_Mon] DEFAULT ('False') NULL,
    [Tue]           BIT               CONSTRAINT [DF_ChnOverlayChild_Tue] DEFAULT ('False') NULL,
    [Wed]           BIT               CONSTRAINT [DF_ChnOverlayChild_Wed] DEFAULT ('False') NULL,
    [Thu]           BIT               CONSTRAINT [DF_ChnOverlayChild_Thu] DEFAULT ('False') NULL,
    [Fri]           BIT               CONSTRAINT [DF_ChnOverlayChild_Fri] DEFAULT ('False') NULL,
    [Sat]           BIT               CONSTRAINT [DF_ChnOverlayChild_Sat] DEFAULT ('False') NULL,
    [Sun]           BIT               CONSTRAINT [DF_ChnOverlayChild_Sun] DEFAULT ('False') NULL,
    [XMLData]       VARCHAR (MAX)     NULL,
    [IsDispProgram] BIT               DEFAULT ('False') NULL,
    [IsDispFiller]  BIT               DEFAULT ('False') NULL,
    [IsDispAdvt]    BIT               CONSTRAINT [DF_ChnOverlayChild_IsDispAdvt] DEFAULT ('False') NULL,
    [ShowTime]      INT               NULL,
    [HideTime]      INT               NULL,
    [EndTime]       INT               NULL,
    [IsDisplay]     BIT               NULL,
    CONSTRAINT [PK_ChnOverlayChild] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ChnOverlayChild_ContentID]
    ON [dbo].[ChnOverlayChild]([OverlayID] ASC)
    INCLUDE([ChnID], [TrnStatus]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=Static 2=Sequence 3=Ticker 7=Text 8=Flash Variable', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnOverlayChild', @level2type = N'COLUMN', @level2name = N'Type';

