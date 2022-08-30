CREATE TABLE [dbo].[ChannelConfigChild] (
    [ID]          [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [ChnConfigID] [dbo].[PID]       NULL,
    [Particular]  VARCHAR (200)     NULL,
    [URL]         VARCHAR (500)     NULL,
    [Argument]    VARCHAR (2000)    NULL,
    [TrnStatus]   [dbo].[TrnStatus] NULL
);

