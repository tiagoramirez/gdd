## Start database
1. Build image
```
docker-compose build
```
2. Run image
```
docker-compose up -d
```
3. Restore database
```
docker-compose exec db /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Hola@1234 -i /usr/src/restore.sql
```