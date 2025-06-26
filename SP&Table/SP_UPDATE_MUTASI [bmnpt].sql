USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_MUTASI]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_UPDATE_MUTASI]
@transnohider char(15),
@shipdate datetime,
@soentrydesc text,
@dateentry datetime,
@useridenty char(10),
@userid char(10)
AS

BEGIN 
UPDATE  mutasi2  SET Shipdate =@shipdate,SOEntryDesc=@soentrydesc,DateEntry=@dateentry,
UserIDEntry=@useridenty WHERE SoTransacID =@transnohider
END


GO
