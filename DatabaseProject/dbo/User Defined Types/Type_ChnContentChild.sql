CREATE TYPE [dbo].[Type_ChnContentChild] AS TABLE (
    [ID]        [dbo].[PID] NULL,
    [ContentID] [dbo].[PID] NULL,
    [StartDate] DATETIME    NULL,
    [EndDate]   DATETIME    NULL,
    [AllDay]    BIT         NULL,
    [Mon]       BIT         NULL,
    [Tue]       BIT         NULL,
    [Wed]       BIT         NULL,
    [Thu]       BIT         NULL,
    [Fri]       BIT         NULL,
    [Sat]       BIT         NULL,
    [Sun]       BIT         NULL,
    [TrnStatus] TINYINT     NULL);

