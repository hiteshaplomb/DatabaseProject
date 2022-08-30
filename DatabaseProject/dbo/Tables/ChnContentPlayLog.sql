CREATE TABLE [dbo].[ChnContentPlayLog] (
    [ID]        [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ContentID] [dbo].[PID]       NULL,
    [RefID]     [dbo].[PID]       NOT NULL,
    [Type]      TINYINT           NULL,
    [FilePath]  VARCHAR (2000)    NULL,
    [Duration]  TIME (7)          NULL,
    [Playtime]  DATETIME          NULL,
    [TrnUserID] [dbo].[TrnUserID] NULL,
    [TrnDate]   [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_ChnContentPlayLog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-Program 2-Adverstise 3-Filler 8-Stable 9-Sequel', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnContentPlayLog', @level2type = N'COLUMN', @level2name = N'Type';

