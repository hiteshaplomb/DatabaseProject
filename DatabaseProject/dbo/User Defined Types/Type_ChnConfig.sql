CREATE TYPE [dbo].[Type_ChnConfig] AS TABLE (
    [Particular] VARCHAR (50)      NULL,
    [URL]        VARCHAR (500)     NULL,
    [Argument]   VARCHAR (2000)    NULL,
    [Trnstatus]  [dbo].[TrnStatus] NULL);

