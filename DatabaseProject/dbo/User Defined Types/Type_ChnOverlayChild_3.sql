CREATE TYPE [dbo].[Type_ChnOverlayChild_3] AS TABLE (
    [ID]            [dbo].[PID] NULL,
    [OverlayID]     [dbo].[PID] NULL,
    [TrnStatus]     TINYINT     NULL,
    [ShowTime]      INT         NULL,
    [HideTime]      INT         NULL,
    [EndTime]       INT         NULL,
    [IsDispProgram] BIT         NULL,
    [IsDispFiller]  BIT         NULL,
    [IsDispAdvt]    BIT         NULL);

