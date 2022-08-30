CREATE TABLE [dbo].[ChannelMst] (
    [ID]           [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [Name]         VARCHAR (250)     NULL,
    [Mode]         TINYINT           NULL,
    [Type]         TINYINT           NULL,
    [LogoID]       [dbo].[OverlayID] NULL,
    [SkinID]       [dbo].[OverlayID] NULL,
    [TrnUserID]    [dbo].[TrnUserID] NULL,
    [TrnStatus]    [dbo].[TrnStatus] NULL,
    [TrnDate]      [dbo].[TrnDate]   NULL,
    [LastPosition] NVARCHAR (200)    NULL,
    [IsDefault]    BIT               CONSTRAINT [DF__ChannelMs__IsDef__2116E6DF] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ChannelMst] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1=TimeBase 2=SequenceBase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChannelMst', @level2type = N'COLUMN', @level2name = N'Mode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-General 2-Song 3-News 4-Sport', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChannelMst', @level2type = N'COLUMN', @level2name = N'Type';

