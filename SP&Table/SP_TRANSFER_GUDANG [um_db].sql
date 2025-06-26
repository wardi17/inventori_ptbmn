USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFER_GUDANG]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRANSFER_GUDANG]
@SOTransacID varchar(15),
@userposting char(30),
@tglposting datetime
AS
BEGIN
 DECLARE @tglclosing datetime;
 DECLARE @Shipdatecek datetime;
 DECLARE @st_flagsave varchar(1);
END

BEGIN
 SET @tglclosing =(SELECT tglclosing AS tglclosing FROM [bmnpt].[dbo].accmodule);
 
 SET @Shipdatecek =(SELECT Shipdate AS shipdate FROM mutasi2 WHERE SoTransacID =@SOTransacID);
END
IF(@Shipdatecek >=@tglclosing)
	BEGIN
			SET @st_flagsave =(SELECT flagsave FROM mutasi2 WHERE SoTransacID =@SOTransacID)
			
		
			IF(@st_flagsave is NULL  OR @st_flagsave ='N')
			 BEGIN
			   INSERT INTO stockposting(
				TransNo,StockTransacTypeID,Description,FlagUpdateStock,TransModule,
				StockTransacDate,batchNo,StockTransacReferDocID,WHSID,
				WHSID2,PartType,PartId,prodclass,subprod,product,
				Pcs,Memo,StatusPosting,LastUserIDAccess,LastDateAccess,userinput
				)
				SELECT
				SoTransacID,'ITM','Inventory Transfer In','+','IT',
				(SELECT Shipdate FROM mutasi2 WHERE SoTransacID =@SOTransacID),itemno,Refno,warehouse2,
				'NULL','FG',PartId,prodclass,subprod,product,
				Quantity,keterangan,'Y',@userposting,@tglposting,(SELECT UserId FROM mutasi2 WHERE SoTransacID =@SOTransacID)
				FROM mutasidetail2 WHERE SoTransacID =@SOTransacID;


				INSERT INTO stockposting(
				TransNo,StockTransacTypeID,Description,FlagUpdateStock,TransModule,
				StockTransacDate,batchNo,StockTransacReferDocID,WHSID,
				WHSID2,PartType,PartId,prodclass,subprod,product,
				Pcs,Memo,StatusPosting,LastUserIDAccess,LastDateAccess,userinput
				)
				SELECT
				SoTransacID,'ITK','Inventory Transfer Out','-','IT',
				(SELECT Shipdate FROM mutasi2 WHERE SoTransacID =@SOTransacID),itemno,Refno,warehouse,
				'NULL','FG',PartId,prodclass,subprod,product,
				Quantity,keterangan,'Y',@userposting,@tglposting,(SELECT UserId FROM mutasi2 WHERE SoTransacID =@SOTransacID)
				FROM mutasidetail2 WHERE SoTransacID =@SOTransacID;
				
				UPDATE  mutasi2 SET flagsave='Y',flagposted='Y' WHERE SoTransacID =@SOTransacID
				--DELETE FROM mutasi2 WHERE SoTransacID =@SOTransacID
				--DELETE FROM mutasidetail2 WHERE SoTransacID=@SOTransacID
				SELECT flagsave FROM mutasi2 WHERE SoTransacID =@SOTransacID
	  	 END
	  
	END
 ELSE
	 BEGIN
	  SELECT flagsave FROM mutasi2 WHERE SoTransacID =@SOTransacID
	 END






GO
