SELECT * INTO [bmnpt].[dbo].mutasidetail2 FROM [bambi-bmi].[dbo].mutasidetail2

SELECT * INTO [bmnpt].[dbo].mutasi2 FROM [bambi-bmi].[dbo].mutasi2



ALTER  TABLE [bmnpt].[dbo].mutasi2
ADD CustomerID char(10),
CustName char(50),
CustAddress varchar(5000)


USE [bmnpt]
GO

/****** Object:  Table [dbo].[mutasidetail2]    Script Date: 6/24/2025 4:10:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[mutasidetail2](
	[SOTransacID] [char](15) NOT NULL,
	[Itemno] [float] NOT NULL,
	[PartId] [char](10) NULL,
	[PartName] [char](60) NULL,
	[prodclass] [char](10) NULL,
	[subprod] [char](10) NULL,
	[product] [char](10) NULL,
	[Quantity] [float] NULL,
	[keterangan] [text] NULL,
	[Refno] [varchar](150) NULL,
	[batchno] [varchar](50) NULL,
	[warehouse] [varchar](50) NULL,
	[warehouse2] [varchar](50) NULL,
	[transtype] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER  TABLE  [dbo].[mutasidetail2]
ADD price FLOAT DEFAULT 0,
discount FLOAT DEFAULT 0,
amount FLOAT DEFAULT 0

