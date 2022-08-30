CREATE TABLE [dbo].[ContentMst] (
    [ID]        [dbo].[PID]       IDENTITY (1, 1) NOT NULL,
    [Type]      TINYINT           NULL,
    [Path]      [dbo].[Path]      NULL,
    [TrnUserID] [dbo].[TrnUserID] NULL,
    [TrnStatus] [dbo].[TrnStatus] NULL,
    [TrnDate]   [dbo].[TrnDate]   NULL,
    CONSTRAINT [PK_ContentMst] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO
CREATE COLUMNSTORE INDEX [CL_ContentMst]
    ON [dbo].[ContentMst]([Path], [Type]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1-Program 2-Adverstise 3-Song', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ContentMst', @level2type = N'COLUMN', @level2name = N'Type';

