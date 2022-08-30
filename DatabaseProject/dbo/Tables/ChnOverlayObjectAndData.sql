CREATE TABLE [dbo].[ChnOverlayObjectAndData] (
    [ID]                [dbo].[PID]    IDENTITY (1, 1) NOT NULL,
    [ChnOverlayChildID] [dbo].[PID]    NULL,
    [Name]              VARCHAR (250)  NULL,
    [Value]             NVARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [IX_ChnOverlayObjectAndData]
    ON [dbo].[ChnOverlayObjectAndData]([ChnOverlayChildID] ASC);

