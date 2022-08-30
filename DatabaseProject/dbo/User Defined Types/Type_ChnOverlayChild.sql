CREATE TYPE [dbo].[Type_ChnOverlayChild] AS TABLE (
    [ID]        [dbo].[PID]    NULL,
    [OverlayID] [dbo].[PID]    NULL,
    [StartDate] DATETIME       NULL,
    [EndDate]   DATETIME       NULL,
    [AllDay]    BIT            NULL,
    [Mon]       BIT            NULL,
    [Tue]       BIT            NULL,
    [Wed]       BIT            NULL,
    [Thu]       BIT            NULL,
    [Fri]       BIT            NULL,
    [Sat]       BIT            NULL,
    [Sun]       BIT            NULL,
    [TrnStatus] TINYINT        NULL,
    [Path]      NVARCHAR (MAX) NULL,
    [Type]      INT            NULL);

