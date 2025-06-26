USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_SIMPANDATA_MUTASI]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SIMPANDATA_MUTASI]
@SOTransacID varchar(15),
@userposting char(30),
@tglposting datetime
AS
BEGIN
 DECLARE @tglclosing datetime;
 DECLARE @Shipdatecek datetime;
 
END

BEGIN
 SET @tglclosing =(SELECT tglclosing AS tglclosing FROM [bambi-bmi].[dbo].accmodule);
 
 SET @Shipdatecek =(SELECT Shipdate AS shipdate FROM mutasi2 WHERE SoTransacID =@SOTransacID);
END
IF(@Shipdatecek >=@tglclosing)
	BEGIN
			INSERT INTO stockposting(
			TransNo,StockTransacTypeID,Description,FlagUpdateStock,TransModule,
			StockTransacDate,batchNo,StockTransacReferDocID,WHSID,
			WHSID2,PartType,PartId,prodclass,subprod,product,
			Pcs,Memo,StatusPosting,LastUserIDAccess,LastDateAccess,userinput
			)
			SELECT
			SoTransacID,transtype,(SELECT description FROM trantypefg where code =transtype),(SELECT flagupdatestock FROM trantypefg where code =transtype),(SELECT transmodule FROM trantypefg where code =transtype),
			(SELECT Shipdate FROM mutasi2 WHERE SoTransacID =@SOTransacID),itemno,Refno,warehouse,
			'NULL','FG',PartId,prodclass,subprod,product,
			Quantity,keterangan,'Y',@userposting,@tglposting,(SELECT UserId FROM mutasi2 WHERE SoTransacID =@SOTransacID)
			FROM mutasidetail2 WHERE SoTransacID =@SOTransacID;
			
			UPDATE  mutasi2 SET flagsave='Y',flagposted='Y' WHERE SoTransacID =@SOTransacID
			--DELETE FROM mutasi2 WHERE SoTransacID =@SOTransacID
			--DELETE FROM mutasidetail2 WHERE SoTransacID=@SOTransacID
	 SELECT flagsave FROM mutasi2 WHERE SoTransacID =@SOTransacID
	END
 ELSE
	 BEGIN
	  SELECT flagsave FROM mutasi2 WHERE SoTransacID =@SOTransacID
	 END

 --SELECT @tglclosing,@Shipdatecek




GO
