CREATE TYPE [dbo].[Type_ChnOverlayObjectAndData] AS TABLE (
    [ID]                [dbo].[PID]    NULL,
    [ChnOverlayChildID] [dbo].[PID]    NULL,
    [Name]              VARCHAR (250)  NULL,
    [Value]             NVARCHAR (MAX) NULL);

