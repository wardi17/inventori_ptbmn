USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDASI_MUTASI]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VALIDASI_MUTASI]
@SOTransacID varchar(15),
@userid char(30)
AS


BEGIN
DECLARE @Shipdate datetime;
 SET @Shipdate = (SELECT Shipdate FROM  [bmnpt].[dbo].mutasi2 WHERE SoTransacID =@SOTransacID);
END

BEGIN
		SELECT
		@Shipdate AS Shipdate,PartId,PartName,warehouse,warehouse2,Quantity,transtype,(select flagupdatestock from [bambi-bmi].[dbo].trantypefg where code=transtype) AS flagstock
		FROM [bmnpt].[dbo].mutasidetail2 WHERE SoTransacID =@SOTransacID ORDER BY Itemno ASC;
		
END


--GO	
--EXEC SP_VALIDASI_MUTASI 'FG240215164342','herman'

--select * from [bmnpt].[dbo].mutasidetail2




GO
