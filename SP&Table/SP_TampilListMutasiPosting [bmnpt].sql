USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_TampilListMutasiPosting]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_TampilListMutasiPosting]
@userid varchar(100),
@tahun varchar(4),
@flagtf char(10),
@akseposting char(1)
AS
BEGIN
IF EXISTS(SELECT [Table_name] FROM tempdb.information_schema.tables WHERE [Table_name] like '#temptess') 
    BEGIN
      DROP TABLE #temptess;
 END;

create table #temptess(
	SoTransacID char(15),
	Shipdate datetime,
	SOEntryDesc varchar(3000),
	UserId char(10)
	
)


IF(@akseposting ='Y')
 BEGIN
    IF(@flagtf ='NULL')
            BEGIN
            INSERT INTO #temptess
            SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
            where  YEAR(Shipdate) =@tahun AND flagsave='Y' AND flagposted ='Y' AND flagtransfer is NULL			
            END;
        ELSE
            BEGIN
            INSERT INTO #temptess
            SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
            where   YEAR(Shipdate) =@tahun AND flagsave='Y' AND flagposted ='Y' AND flagtransfer='TF'			
            END;
  END;
ELSE 
BEGIN
    IF(@flagtf ='NULL')
        BEGIN
        INSERT INTO #temptess
        SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
        where UserIDEntry=@userid AND YEAR(Shipdate) =@tahun AND flagsave='Y' AND flagposted ='Y' AND flagtransfer is NULL			
        END;
    ELSE
        BEGIN
        INSERT INTO #temptess
        SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
        where UserIDEntry=@userid AND YEAR(Shipdate) =@tahun AND flagsave='Y' AND flagposted ='Y' AND flagtransfer='TF'			
        END;
END
SELECT * FROM #temptess
END;


GO

EXEC SP_TampilListMutasiPosting 'herman','2025','TF' ,'Y'