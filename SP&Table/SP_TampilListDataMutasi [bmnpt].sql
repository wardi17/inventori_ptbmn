USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_TampilListDataMutasi]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TampilListDataMutasi]
@userid varchar(100),
@tahun varchar(4),
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
	SOEntryDesc varchar(255),
	UserId char(10)
	
)

IF(@akseposting ='Y')
	BEGIN
	INSERT INTO #temptess
	SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
	where YEAR(Shipdate) =@tahun AND (flagsave is NULL OR flagsave='N') AND (flagtransfer is NULL OR flagtransfer='N')
	END;
ELSE
	BEGIN
	INSERT INTO #temptess
	SELECT SoTransacID,Shipdate,SOEntryDesc,UserId FROM mutasi2 
	where UserIDEntry=@userid AND YEAR(Shipdate) =@tahun AND (flagsave is NULL OR flagsave='N') AND (flagtransfer is NULL OR flagtransfer='N')
	END;

SELECT * FROM #temptess
END;

--go
--EXEC SP_TampilListDataMutasi 'asian','2024' , 'Y'


GO
