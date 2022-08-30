CREATE TABLE [dbo].[ChnContentChild] (
    [ID]        [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnID]     [dbo].[ChnID]     NULL,
    [ContentID] [dbo].[PID]       NULL,
    [TrnUserID] [dbo].[TrnUserID] NULL,
    [TrnStatus] [dbo].[TrnStatus] NULL,
    [TrnDate]   [dbo].[TrnDate]   NULL,
    [Sequence]  INT               NULL,
    [StartDate] DATETIME          NULL,
    [EndDate]   DATETIME          NULL,
    [AllDay]    BIT               DEFAULT ('False') NULL,
    [Mon]       BIT               DEFAULT ('False') NULL,
    [Tue]       BIT               DEFAULT ('False') NULL,
    [Wed]       BIT               DEFAULT ('False') NULL,
    [Thu]       BIT               DEFAULT ('False') NULL,
    [Fri]       BIT               DEFAULT ('False') NULL,
    [Sat]       BIT               DEFAULT ('False') NULL,
    [Sun]       BIT               DEFAULT ('False') NULL,
    CONSTRAINT [PK_ChnContentChild] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ChnContentChild_ContentID]
    ON [dbo].[ChnContentChild]([ContentID] ASC)
    INCLUDE([ChnID], [TrnStatus]);

