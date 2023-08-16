USE [master]
RESTORE DATABASE [GD2015C1] FROM DISK = N'/usr/src/backups/GD2015C1.bak' WITH FILE = 1, MOVE N'GD2015C1' TO N'/var/opt/mssql/data/GD2015C1.mdf', MOVE N'GD2015C1_log' TO N'/var/opt/mssql/data/GD2015C1_log.ldf', NOUNLOAD, STATS = 5

GO