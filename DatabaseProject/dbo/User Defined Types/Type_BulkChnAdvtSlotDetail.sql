CREATE TYPE [dbo].[Type_BulkChnAdvtSlotDetail] AS TABLE (
    [ObjName]   VARCHAR (500)  NULL,
    [RefID]     NVARCHAR (MAX) NULL,
    [IsSuccess] BIT            NULL,
    [Msg]       NVARCHAR (MAX) NULL);

