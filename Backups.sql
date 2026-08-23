USE master;
GO

BACKUP DATABASE DB_GestionVentas
TO DISK = 'C:\Backups\DB_GestionVentas.bak'
WITH INIT,
     NAME = 'Backup DB_GestionVentas';
GO