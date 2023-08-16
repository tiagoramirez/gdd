FROM mcr.microsoft.com/mssql/server:2022-latest

COPY ["./database/GD2015C1.bak", "/usr/src/backups/GD2015C1.bak"]
COPY ["./database/restore.sql", "/usr/src/restore.sql"]