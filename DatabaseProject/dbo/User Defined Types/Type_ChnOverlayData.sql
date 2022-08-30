CREATE TYPE [dbo].[Type_ChnOverlayData] AS TABLE (
    [ID]                [dbo].[PID]    NULL,
    [OverlayObjID]      [dbo].[PID]    NULL,
    [Value]             NVARCHAR (MAX) NULL,
    [ChnOverlayChildID] [dbo].[PID]    NULL,
    [SourceType]        VARCHAR (20)   NULL);

