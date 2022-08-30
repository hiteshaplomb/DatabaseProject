CREATE TYPE [dbo].[PID]
    FROM INT NULL;


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This key Is Used For PrimaryKey.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TYPE', @level1name = N'PID';

