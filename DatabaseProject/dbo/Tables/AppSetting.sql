CREATE TABLE [dbo].[AppSetting] (
    [ID]           [dbo].[PID]                                 IDENTITY (1, 1) NOT NULL,
    [Particular]   VARCHAR (250)                               NOT NULL,
    [Value]        SQL_VARIANT                                 NULL,
    [Category]     VARCHAR (250)                               NULL,
    [DefaultValue] SQL_VARIANT                                 NULL,
    [DataType]     CHAR (1)                                    NULL,
    [Desp]         VARCHAR (MAX)                               NULL,
    [TrnUserID]    [dbo].[TrnUserID]                           NULL,
    [TrnDate]      [dbo].[TrnDate]                             CONSTRAINT [DF_AppSetting_TrnDate] DEFAULT (getdate()) NULL,
    [SysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [AppSetting_DF_SysStart] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [AppSetting_DF_SysEnd] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59')) NOT NULL,
    [Type]         TINYINT                                     DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_AppSetting] PRIMARY KEY CLUSTERED ([ID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[AppSetting_History], DATA_CONSISTENCY_CHECK=ON));


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'N=Numeric | S=String | B=Boolean | D=Date | C=Combobox', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppSetting', @level2type = N'COLUMN', @level2name = N'DataType';


GO
EXECUTE sp_addextendedproperty @name = N'AppSetting_Type_Description', @value = '1 For ApplicationLevel 2 For Channel Wise Setting', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AppSetting', @level2type = N'COLUMN', @level2name = N'Type';

