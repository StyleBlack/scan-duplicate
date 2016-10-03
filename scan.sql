USE [SCAN]
GO

TRUNCATE TABLE [dbo].[tbl_items]
TRUNCATE TABLE [dbo].[tbl_duplicate]

DECLARE	@return_value int

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 8,
		@container = 0
SELECT	'[tbl_base] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 6,
		@container = 1
SELECT	'[tbl_general] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 100,
		@container = 2
SELECT	'[tbl_inven] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 100,
		@container = 3
SELECT	'[tbl_AccountTrunk] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 40,
		@container = 4
SELECT	'[tbl_AccountTrunk_Extend] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 100,
		@container = 5
SELECT	'[tbl_general.force] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsBase]
		@db_world = N'RF_WORLD',
		@max_slot = 1,
		@container = 6
SELECT	'[tbl_supplement] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectItemsPost]
		@db_world = N'RF_WORLD'
SELECT	'[tbl_PostStorage] Return Value' = @return_value

EXEC	@return_value = [dbo].[pSelectDuplicateItems]
		@db_world = N'RF_WORLD'

SELECT	'[scan items] Return Value' = @return_value

GO
