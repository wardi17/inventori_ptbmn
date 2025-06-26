USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_Getpartid]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Getpartid]

@filterdata varchar(100)
AS

BEGIN
SELECT  partid,partname FROM partmaster  where parttype='FG' AND divisi=1 AND partid like @filterdata	order by partid ASC	
END;

--go
--EXEC SP_Getpartid

--100P20-99 
--SELECT top 10 partid,partname  FROM partmaster  where parttype='FG' AND divisi=1	order by partid ASC		



GO
