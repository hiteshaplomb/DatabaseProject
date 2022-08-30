CREATE TYPE [dbo].[Type_OverlayObject] AS TABLE (
    [ID]           [dbo].[PID]   NULL,
    [OverlayID]    [dbo].[PID]   NULL,
    [Name]         VARCHAR (250) NULL,
    [GroupType]    VARCHAR (250) NULL,
    [OverlayValue] VARCHAR (MAX) NULL);

