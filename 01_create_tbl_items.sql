USE [SCAN]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_items](
	[index] [bigint] IDENTITY(1,1) NOT NULL,
	[container] [smallint] NOT NULL,
	[slot] [smallint] NOT NULL,
	[item_serial] [bigint] NOT NULL,
	[item_code] [int] NOT NULL,
	[player_serial] [int] NOT NULL,
 CONSTRAINT [PK_tbl_items] PRIMARY KEY CLUSTERED 
(
	[index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO