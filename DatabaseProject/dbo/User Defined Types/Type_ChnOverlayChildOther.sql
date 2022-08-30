CREATE TYPE [dbo].[Type_ChnOverlayChildOther] AS TABLE (
    [ID]            [dbo].[PID]   NULL,
    [StartDate]     DATETIME      NULL,
    [EndDate]       DATETIME      NULL,
    [Mon]           BIT           NULL,
    [Tue]           BIT           NULL,
    [Wed]           BIT           NULL,
    [Thu]           BIT           NULL,
    [Fri]           BIT           NULL,
    [Sat]           BIT           NULL,
    [Sun]           BIT           NULL,
    [XMLData]       VARCHAR (MAX) NULL,
    [IsDispProgram] BIT           NULL,
    [IsDispFiller]  BIT           NULL,
    [IsDispAdvt]    BIT           NULL);

