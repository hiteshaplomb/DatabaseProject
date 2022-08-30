CREATE TABLE [dbo].[AppSetting_History] (
    [ID]           [dbo].[PID]       NOT NULL,
    [Particular]   VARCHAR (250)     NOT NULL,
    [Value]        SQL_VARIANT       NULL,
    [Category]     VARCHAR (250)     NULL,
    [DefaultValue] SQL_VARIANT       NULL,
    [DataType]     CHAR (1)          NULL,
    [Desp]         VARCHAR (MAX)     NULL,
    [TrnUserID]    [dbo].[TrnUserID] NULL,
    [TrnDate]      [dbo].[TrnDate]   NULL,
    [SysStartTime] DATETIME2 (7)     NOT NULL,
    [SysEndTime]   DATETIME2 (7)     NOT NULL,
    [Type]         TINYINT           NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_AppSetting_History]
    ON [dbo].[AppSetting_History]([SysEndTime] ASC, [SysStartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

