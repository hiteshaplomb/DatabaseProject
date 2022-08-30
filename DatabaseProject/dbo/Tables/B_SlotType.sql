CREATE TABLE [dbo].[B_SlotType] (
    [ID]        [dbo].[PID]       NOT NULL,
    [Name]      VARCHAR (200)     NULL,
    [TrnStatus] [dbo].[TrnStatus] NULL,
    CONSTRAINT [PK_BaseSlotType] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Base Slot Type Table Is Used For Set Category And Maintain By Developer. There Is Not any Front Hand.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'B_SlotType';

