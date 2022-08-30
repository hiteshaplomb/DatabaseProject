CREATE TABLE [dbo].[ChnContentOtherInfo] (
    [ID]          [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnID]       [dbo].[ChnID]     NULL,
    [ContentID]   [dbo].[PID]       NULL,
    [VideoFormat] VARCHAR (500)     NULL,
    [AudioFormat] VARCHAR (500)     NULL,
    [Language]    VARCHAR (500)     NULL,
    [CCType]      TINYINT           NULL,
    [CCSource]    VARCHAR (500)     NULL,
    [TrnUserID]   [dbo].[TrnUserID] NULL,
    [TrnDate]     [dbo].[TrnDate]   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ChnContentOtherConfig]
    ON [dbo].[ChnContentOtherInfo]([ChnID] ASC, [ContentID] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=Inbuilt 2=External File', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChnContentOtherInfo', @level2type = N'COLUMN', @level2name = N'CCType';

