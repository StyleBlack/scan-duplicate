USE [SCAN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_duplicate](
	[index] [bigint] IDENTITY(1,1) NOT NULL,
	[item_id] [bigint] NOT NULL,
	[account_serial] [int] NOT NULL,
 CONSTRAINT [PK_tbl_duplicate] PRIMARY KEY CLUSTERED 
(
	[index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
