USE [bmnpt]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTransType]    Script Date: 02/13/2024 16:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetTransType]

AS


BEGIN
SELECT code,description FROM trantypefg order by number ASC 					
END;



GO
