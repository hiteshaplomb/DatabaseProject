CREATE TABLE [dbo].[ChnSlotMst] (
    [ID]         [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [B_SlotType] [dbo].[PID]       NULL,
    [ChnID]      [dbo].[ChnID]     NULL,
    [Name]       VARCHAR (200)     NULL,
    [Slot]       TIME (7)          NULL,
    [Remark]     VARCHAR (500)     NULL,
    [TrnStatus]  [dbo].[TrnStatus] NULL,
    [TrnUserID]  [dbo].[TrnUserID] NULL,
    [TrnDate]    [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_ChnSlotMst] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ChnSlotMst]
    ON [dbo].[ChnSlotMst]([ID] ASC, [ChnID] ASC, [Name] ASC, [Slot] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Channel Wise Slot Related Information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnSlotMst';

