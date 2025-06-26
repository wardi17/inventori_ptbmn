USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_TampilDatadetail]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TampilDatadetail]
@SoTransacID char(15)
AS

BEGIN
IF EXISTS(SELECT [Table_name] FROM tempdb.information_schema.tables WHERE [Table_name] like '#temptess') 
    BEGIN
      DROP TABLE #temptess;
 END;

create table #temptess(
    PartId char(10),
    PartName char(60),
    warehouse varchar(50),
    warehouse2 varchar(50),
    Quantity float,
    jumlah_rikode float
)

BEGIN
     DECLARE @PartId char(10);
     DECLARE @partname varchar(60);
     DECLARE @warehouse varchar(50);
     DECLARE @warehouse2 varchar(50);
     DECLARE @Quantity float;
     DECLARE @jumlah_rikode float;
     
END

BEGIN
 SET  @PartId =(SELECT top 1 PartId from mutasidetail2 where SOTransacID=@SoTransacID ORDER BY Itemno DESC);
 SET  @partname =(SELECT top 1 PartName from mutasidetail2 where SOTransacID=@SoTransacID ORDER BY Itemno DESC);
 SET  @warehouse =(SELECT top 1 warehouse from mutasidetail2 where SOTransacID=@SoTransacID ORDER BY Itemno DESC);
  SET  @warehouse2 =(SELECT top 1 warehouse2 from mutasidetail2 where SOTransacID=@SoTransacID ORDER BY Itemno DESC);
 SET  @Quantity =(SELECT SUM(Quantity) from mutasidetail2 where SOTransacID=@SoTransacID);
  SET  @jumlah_rikode =(SELECT COUNT(SOTransacID) from mutasidetail2 where SOTransacID=@SoTransacID);
END


BEGIN
	 INSERT INTO #temptess(PartId,PartName,warehouse,warehouse2,Quantity,jumlah_rikode)
	 VALUES(@PartId,@partname,@warehouse,@warehouse2,@Quantity,@jumlah_rikode)		
END;
SELECT * FROM #temptess
END;


GO
