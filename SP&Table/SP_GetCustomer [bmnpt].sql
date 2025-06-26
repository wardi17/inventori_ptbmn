USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomer]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SP_GetCustomer]

AS


BEGIN
SELECT CustomerID,CustName FROM customer			
END;

go
EXEC SP_GetCustomer




