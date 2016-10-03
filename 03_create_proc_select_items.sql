SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pSelectItemsBase]
	@db_world varchar(64),
	@max_slot smallint,
	@container smallint
AS
BEGIN
	SET NOCOUNT ON;
	declare @SQL NVARCHAR(4000)
	declare @tbl_items varchar(64)
	declare @tbl_serial_field varchar(16)
	declare @tbl_items_spref varchar(16)
	declare @tbl_items_kpref varchar(16)
	declare @min_slot smallint

	if @container > 6
		return 1

	-- select table by type container
	if @container = 0
		set @tbl_items = 'tbl_base'

	if @container = 1
		set @tbl_items = 'tbl_general'

	if @container = 2
		set @tbl_items = 'tbl_inven'

	if @container = 3
		set @tbl_items = 'tbl_AccountTrunk'

	if @container = 4
		set @tbl_items = 'tbl_AccountTrunk_Extend'

	if @container = 5
		set @tbl_items = 'tbl_general'
		
	if @container = 6
		set @tbl_items = 'tbl_supplement'
		
	set @tbl_serial_field = 'Serial'

	if @container = 3 or @container = 4
		set @tbl_serial_field = 'AccountSerial'

	-- select prefix by type container
	if @container = 0 or @container = 1 or @container = 6
	begin
		set @tbl_items_spref = 'ES'
		set @tbl_items_kpref = 'EK'
	end
	
	if @container = 2 or @container = 3 or @container = 4
	begin
		set @tbl_items_spref = 'S'
		set @tbl_items_kpref = 'K'
	end
	
	if @container = 5
	begin
		set @tbl_items_spref = 'FS'
		set @tbl_items_kpref = 'F'
	end

	set @min_slot = 0
	if @container = 6
	begin
		set @min_slot = 6
		set @max_slot = 7
	end	
	
	
	declare @serial int
	declare @item_code int
	declare @item_serial bigint

	declare @slot smallint
	set @slot = @min_slot
	while @slot < @max_slot
	begin
		set @SQL = 
			'Declare users_cursor CURSOR FOR '
			+ 'SELECT ' + @tbl_serial_field + ', ' 
			+ @tbl_items_kpref + CAST(@slot AS varchar(3)) + ',' 
			+ @tbl_items_spref + CAST(@slot AS varchar(3)) + ' ' 
			+ 'from '
			+ @db_world 
			+ '.dbo.' + @tbl_items
		exec sp_executesql @SQL

		open users_cursor
	
		fetch next from users_cursor into @serial, @item_code, @item_serial
		while @@FETCH_STATUS = 0
		begin
			if (@item_code <> -1)
				INSERT INTO 
					[dbo].[tbl_items]
					   ([container]
					   ,[slot]
					   ,[item_serial]
					   ,[item_code]
					   ,[player_serial])
				 VALUES
					   (@container
					   ,@slot
					   ,@item_serial
					   ,@item_code
					   ,@serial)
			fetch next from users_cursor into @serial, @item_code, @item_serial
		end;

		close users_cursor
		deallocate users_cursor

		set @slot = @slot + 1;
	end;
END
