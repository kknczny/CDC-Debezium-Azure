use [WideWorldImporters]
select LastEditedWhen, * from [cdc].[Sales_Orders_CT]

select ValidFrom, * from [cdc].[Warehouse_StockItems_CT]

--select * from [cdc].[ddl_history]

--select * from [cdc].[captured_columns]

select * from [cdc].[lsn_time_mapping]