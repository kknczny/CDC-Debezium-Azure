USE [WideWorldImporters]
GO

-- CREATE TABLE 

DROP TABLE IF EXISTS DBO.TRANSACTIONS
CREATE TABLE [DBO].[TRANSACTIONS](
	[TRAN_CREATE_BY] [nvarchar](max) NOT NULL,
	[TRAN_CREATE_DATE] [datetime] NOT NULL,
	[TRAN_SEQNO] [int] NOT NULL,
	[TRAN_ACCOUNT_NO] [int] NOT NULL,
	[TRAN_SUBACC_NO] [int] NOT NULL,
	[TRAN_REVERSAL_IND] [varchar](1) NOT NULL,
	[TRAN_SOC_SEQNO] [int] NULL,
	--[TRAN_BRN_CODE] [varchar](4) NOT NULL,
	[TRAN_ACT_CODE] [varchar](6) NULL,
	[TRAN_GACT_TYPE] [varchar](1) NULL,
	[TRAN_GTRANS_TYPE] [varchar](3) NULL,
	[TRAN_CLASS] [varchar](6) NULL,
	[TRAN_TRANS_CODE] [varchar](6),
	[TRAN_REFERENCE] [varchar](max) NOT NULL,
	--[TRAN_AMOUNT_DB] [float] NULL,
	[TRAN_AMOUNT_CR] [float](2) NULL)

-- FIRST RECORD
INSERT INTO [DBO].[TRANSACTIONS] 
VALUES (
	'SUMMIT', 
	GETDATE(), 
	20000000, 
	50000000, 
	1, 
	'N', 
	1, 
	--'CODE', 
	'COD000', 
	'C', 
	'TYP', 
	'CLASS0', 
	'TRCODE', 
	'Sample Reference 0',
	--RAND()*1000,
	RAND()*1000
	)

/*
	Enable CDC on selected tables
*/
EXEC sys.sp_cdc_enable_table N'dbo', N'Transactions', @role_name=null, @supports_net_changes=0
GO

/*
	Verify the CDC has been enabled for the selected tables
*/
EXEC sys.sp_cdc_help_change_data_capture
GO


-- ADD NEW TRANSACTION
DECLARE @NEW_ID INT
SELECT @NEW_ID = COUNT(*) FROM [DBO].[TRANSACTIONS]

INSERT INTO [DBO].[TRANSACTIONS] 
VALUES (
	'SUMMIT', 
	GETDATE(), 
	20000000+@NEW_ID, 
	50000000+@NEW_ID, 
	1, 
	'N', 
	1, 
	--'CODE', 
	'COD'+RIGHT('000' + CAST(@NEW_ID as varchar(3)),3), 
	'C', 
	'TYP', 
	'CLASS'+LEFT(@NEW_ID,1), 
	'TRCODE', 
	'Sample Reference '+CAST(@NEW_ID AS nvarchar), 
	--RAND()*1000, 
	RAND()*1000
	)


-- SELECT TABLE 
SELECT 
[TRAN_CREATE_BY],
[TRAN_CREATE_DATE],
[TRAN_SEQNO],
[TRAN_ACCOUNT_NO],
[TRAN_SUBACC_NO],
[TRAN_REVERSAL_IND],
[TRAN_SOC_SEQNO],
--[TRAN_BRN_CODE],
[TRAN_ACT_CODE],
[TRAN_GACT_TYPE],
[TRAN_GTRANS_TYPE],
[TRAN_CLASS],
[TRAN_TRANS_CODE],
[TRAN_REFERENCE],
--[TRAN_AMOUNT_DB],
[TRAN_AMOUNT_CR]
FROM [DBO].[TRANSACTIONS] 


-- SELECT CDC
select * from [cdc].[dbo_Transactions_CT]