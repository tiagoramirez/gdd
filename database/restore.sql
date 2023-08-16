USE [master]
RESTORE DATABASE [GD2015C1] FROM  DISK = N'/usr/src/backups/GD2015C1.bak' WITH  FILE = 1,  MOVE N'GESTION2009_Data' TO N'/var/opt/mssql/data/GD2014.MDF',  MOVE N'GESTION2009_Log' TO N'/var/opt/mssql/data/GD2014.LDF',  NOUNLOAD,  STATS = 5

GO