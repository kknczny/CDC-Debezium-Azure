USE [WideWorldImporters]
GO


--SELECT owner_sid FROM sys.databases where name = 'WideWorldImporters';

--SELECT sid,* from WideWorldImporters.sys.database_principals WHERE name = 'dbo';

--EXEC sp_dropuser 'SOFTSERVE\jkoni'
--EXEC sp_changedbowner 'SOFTSERVE\jkoni'

/*
	Change owner in order to proceed with enabling CDC
*/
--EXEC sp_changedbowner 'sa'

/*
	Enable CDC on database (make sure SQL Server Agent is running!)
*/
EXEC sys.sp_cdc_enable_db
GO

/*
	Enable CDC on selected tables
*/
EXEC sys.sp_cdc_enable_table N'Sales', N'Orders', @role_name=null, @supports_net_changes=0
EXEC sys.sp_cdc_enable_table N'Warehouse', N'StockItems', @role_name=null, @supports_net_changes=0
GO

/*
	Verify the CDC has been enabled for the selected tables
*/
EXEC sys.sp_cdc_help_change_data_capture
GO

/*FIX - stop and start CDC job*/
EXEC sys.sp_cdc_start_job
GO
EXEC sys.sp_cdc_stop_job