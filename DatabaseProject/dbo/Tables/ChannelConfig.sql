CREATE TABLE [dbo].[ChannelConfig] (
    [ID]         [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnID]      [dbo].[ChnID]     NULL,
    [Type]       VARCHAR (50)      NULL,
    [Particular] VARCHAR (500)     NULL,
    [Narration]  VARCHAR (500)     NULL,
    [TrnStatus]  [dbo].[TrnStatus] NULL,
    [TrnUserID]  [dbo].[TrnUserID] NULL,
    [TrnDate]    [dbo].[TrnDate]   CONSTRAINT [DF_ChannelConfig_TrnDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ChannelConfig] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Input/Output/VideoFormat/AudioFormat', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChannelConfig', @level2type = N'COLUMN', @level2name = N'Type';

