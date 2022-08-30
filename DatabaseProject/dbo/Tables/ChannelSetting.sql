CREATE TABLE [dbo].[ChannelSetting] (
    [ID]           [dbo].[PID]                                 IDENTITY (1, 1) NOT NULL,
    [ChnID]        [dbo].[ChnID]                               NOT NULL,
    [Particular]   VARCHAR (250)                               NOT NULL,
    [Value]        SQL_VARIANT                                 NULL,
    [Category]     VARCHAR (250)                               NULL,
    [DefaultValue] SQL_VARIANT                                 NULL,
    [DataType]     CHAR (1)                                    NULL,
    [Desp]         VARCHAR (MAX)                               NULL,
    [TrnUserID]    [dbo].[TrnUserID]                           NULL,
    [TrnDate]      [dbo].[TrnDate]                             CONSTRAINT [DF_ChannelSetting_TrnDate] DEFAULT (getdate()) NULL,
    [SysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START CONSTRAINT [ChannelSetting_DF_SysStart] DEFAULT (sysutcdatetime()) NOT NULL,
    [SysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END   CONSTRAINT [ChannelSetting_DF_SysEnd] DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59',(0))) NOT NULL,
    CONSTRAINT [PK_ChannelSetting] PRIMARY KEY CLUSTERED ([ID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'N=Numeric | S=String | B=Boolean | D=Date | C=Combobox', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ChannelSetting', @level2type = N'COLUMN', @level2name = N'DataType';

