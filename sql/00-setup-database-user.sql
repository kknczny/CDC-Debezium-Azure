USE [master]
GO
CREATE LOGIN [debezium-wwi] WITH PASSWORD = 'SB_RElDB_CDC_Streaming'
GO
USE [WideWorldImporters]
GO
CREATE USER [debezium-wwi] FROM LOGIN [debezium-wwi]
GO
ALTER ROLE [db_owner] ADD MEMBER [debezium-wwi]
GO
