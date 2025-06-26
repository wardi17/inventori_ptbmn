USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_TampilDataMutasi]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TampilDataMutasi]
@SoTransacID char(15)
AS


BEGIN
SELECT Shipdate,SOEntryDesc FROM  mutasi2 where SoTransacID=@SoTransacID AND flagsave is NULL  AND flagposted  is NULL	
END;
GO
