
CREATE OR ALTER PROCEDURE Insert_data_to_bronze_layr AS 
BEGIN TRY
    BEGIN 
        PRINT'Loding Data To Loan Table';
        PRINT'';
        PRINT'Start Truncating Loan Table';
        TRUNCATE TABLE [Bronze].[Loan];
        PRINT'Successful';
        PRINT'';
        PRINT'';
        PRINT'Start Loding Data To Loan Table';
        BULK INSERT [Bronze].[Loan] 
        FROM 'C:\Users\HP ZBOOK\OneDrive\Desktop\Lending Club Loan Data Analysis\loan.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            FIELDQUOTE = '"',
            CODEPAGE = '65001',
            TABLOCK
        );
        PRINT'Successful';

        PRINT'';
        PRINT'==============================================';
        PRINT'Loding Data To LoanStats Table';
        PRINT'';
        PRINT'Start Truncating LoanStats Table';
        TRUNCATE TABLE  Bronze.LoanStats;
        PRINT'Successful';
        PRINT'';
        PRINT'';
        PRINT'Start Loding Data To LoanStats Table';
        INSERT INTO Bronze.LoanStats(
        LoanStatNew ,
        [Description])
        SELECT [LoanStatNew],
        [Description]
        FROM [dbo].[LoanStats] ;
        PRINT'Successful';
    
        PRINT'';
        PRINT'===============================================';
        PRINT'Loding Data To RejectStats Table';
        PRINT'';
        PRINT'Start Truncating RejectStats Table';
        TRUNCATE TABLE Bronze.RejectStats;
        PRINT'Successful';
        PRINT'';
        PRINT'';
        PRINT'Start Loding Data To RejectStats Table';
        INSERT INTO Bronze.RejectStats(
        RejectStats_File,
        [Description])
        SELECT [RejectStats File],
        [Description]
        FROM [dbo].[RejectStats];
        PRINT'Successful';
    
        PRINT'';
        PRINT'===============================================';
        PRINT'Loding Data To browseNotes Table';
        PRINT'';
        PRINT'Start Truncating browseNotes Table';
        TRUNCATE TABLE Bronze.browseNotes;
        INSERT INTO Bronze.browseNotes(
        BrowseNotesFile  ,
        [Description]
        )
        SELECT [BrowseNotesFile],
        [Description]
        FROM [dbo].[browseNotes];
        PRINT'Successful';
        PRINT'---------------------------';
        PRINT'--DONE--';
    END 
END TRY
BEGIN CATCH
    SELECT 
        ERROR_MESSAGE() AS ERRORMESSAGE,
        ERROR_NUMBER() AS ERRORNUMBER,
        ERROR_LINE() AS ERRORLINE
END CATCH



