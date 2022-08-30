CREATE TYPE [dbo].[Type_OverlayObject_2] AS TABLE (
    [ID]           [dbo].[PID]   NULL,
    [OverlayID]    [dbo].[PID]   NULL,
    [Name]         VARCHAR (50)  NULL,
    [GroupType]    VARCHAR (50)  NULL,
    [OverlayValue] VARCHAR (MAX) NULL);

