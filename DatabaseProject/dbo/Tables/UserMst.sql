CREATE TABLE [dbo].[UserMst] (
    [ID]        [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (250)     NOT NULL,
    [Pwd]       VARCHAR (250)     NULL,
    [TrnUserID] [dbo].[TrnUserID] NOT NULL,
    [TrnStatus] [dbo].[TrnStatus] NOT NULL,
    [TrnDate]   [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_UserMst] PRIMARY KEY CLUSTERED ([ID] ASC)
);

