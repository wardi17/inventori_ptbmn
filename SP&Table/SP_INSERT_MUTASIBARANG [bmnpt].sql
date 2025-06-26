USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_MUTASIBARANG]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_INSERT_MUTASIBARANG]
@transnohider char(15),
@shipdate datetime,
@soentrydesc text,
@dateentry datetime,
@useridenty char(10),
@userid char(10),
@flagtf char(10),
@custid char(10),
@custname char(50)
AS
  BEGIN
   DECLARE @cust_address vArchar(8000);
   
   SET @cust_address = (SELECT TOP 1 CAST(CustAddress AS VARCHAR(8000)) FROM [bmnpt].[dbo].customer WHERE CustomerID =@custid);

	
	BEGIN 
	INSERT  INTO mutasi2(SoTransacID,Shipdate,SOEntryDesc,DateEntry,UserIDEntry,UserId,flagtransfer,
	 CustomerID,CustName,CustAddress)
	 VALUES(@transnohider,@shipdate,@soentrydesc,@dateentry,@useridenty,@userid,@flagtf,
	 @custid,@custname,@cust_address)
	END

--SELECT * FROM mutasi2  where SoTransacID=@transnohider

--delete FROM mutasi2 where SoTransacID=@transnohider
END

GO

/*exec SP_INSERT_MUTASIBARANG 'WT241014162259','2024-10-14','test','2024-10-14 16:23:44'
				 ,'lia','lia','TF','PTMSA','PT.MSA CERTIFICATION'*/
