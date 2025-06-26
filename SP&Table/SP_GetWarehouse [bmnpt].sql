USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetWarehouse]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetWarehouse]

AS


BEGIN
SELECT WHSID,WHSName FROM warehouse  where parttype='FG' AND WHSID <>'BMI'	order by WHSID ASC				
END;

--go
--EXEC SP_GetTransType


GO
