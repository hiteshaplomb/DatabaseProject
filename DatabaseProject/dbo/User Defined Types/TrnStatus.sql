CREATE TYPE [dbo].[TrnStatus]
    FROM TINYINT NOT NULL;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'1=Active 2=Block/Paused 3=Delete, This Is Record Status', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TYPE', @level1name = N'TrnStatus';

