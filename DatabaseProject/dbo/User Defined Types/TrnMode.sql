CREATE TYPE [dbo].[TrnMode]
    FROM TINYINT NULL;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'1=Insert | 2=Update | 3=Delete | 4=Get For Fill Form', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TYPE', @level1name = N'TrnMode';

