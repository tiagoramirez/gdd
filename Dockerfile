FROM mcr.microsoft.com/mssql/server:2022-latest

COPY ["./GD2015C1.bak", "/usr/src/backups/GD2015C1.bak"]
COPY ["./restore.sql", "/usr/src/restore.sql"]