insert_query_1 = """
DECLARE @NEW_ID INT
SELECT @NEW_ID = COUNT(*) FROM [DBO].[TRANSACTIONS]

INSERT INTO [DBO].[TRANSACTIONS] 
VALUES ('SUMMIT', GETDATE(), 20000000+@NEW_ID, 50000000+@NEW_ID, 1, 'N', 1, 'COD'+RIGHT('000' + CAST(@NEW_ID as varchar(3)),3), 'C', 'TYP', 'CLASS'+LEFT(@NEW_ID,1), 'TRCODE', 'Sample Reference '+CAST(@NEW_ID AS nvarchar), RAND()*1000)
"""

insert_query_2 = """
DECLARE @NEW_ID INT
SELECT @NEW_ID = COUNT(*) FROM [DBO].[TRANSACTIONS]

INSERT INTO [DBO].[TRANSACTIONS] 
VALUES ('SUMMIT', GETDATE(), 20000000+@NEW_ID, 50000000+@NEW_ID, 2, 'Y', 2, 'COD'+RIGHT('000' + CAST(@NEW_ID as varchar(3)),3), 'C', 'TP1', 'CLASS'+LEFT(@NEW_ID,1), 'TRCODE', 'Capitalisation '+CAST(@NEW_ID AS nvarchar), RAND()*1000)
"""

insert_query_3 = """
DECLARE @NEW_ID INT
SELECT @NEW_ID = COUNT(*) FROM [DBO].[TRANSACTIONS]

INSERT INTO [DBO].[TRANSACTIONS] 
VALUES ('SUMMIT', GETDATE(), 20000000+@NEW_ID, 50000000+@NEW_ID, 3, 'N', 3, 'COD'+RIGHT('000' + CAST(@NEW_ID as varchar(3)),3), 'B', 'TP2', 'CLASS'+LEFT(@NEW_ID,1), 'TRCODE', 'Sample Other Ref '+CAST(@NEW_ID AS nvarchar), RAND()*1000)
"""
