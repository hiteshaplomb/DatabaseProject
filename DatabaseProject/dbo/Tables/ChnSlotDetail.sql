CREATE TABLE [dbo].[ChnSlotDetail] (
    [ID]           [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [SlotID]       INT               NOT NULL,
    [Sequence]     INT               NULL,
    [ChnContentID] [dbo].[PID]       NULL,
    [TrnUserID]    [dbo].[TrnUserID] NULL,
    [TrnStatus]    [dbo].[TrnStatus] NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [Ix_ChnSlotDetail_SlotID]
    ON [dbo].[ChnSlotDetail]([SlotID] ASC)
    INCLUDE([ChnContentID], [Sequence]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'UserID When Sequence Up And Down That Time Use.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnSlotDetail', @level2type = N'COLUMN', @level2name = N'TrnUserID';

