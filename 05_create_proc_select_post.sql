SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pSelectItemsPost]
	@db_world varchar(64)
AS
BEGIN
	SET NOCOUNT ON;
	declare @SQL NVARCHAR(4000)

	declare @serial int
	declare @item_code int
	declare @item_serial bigint

	set @SQL = 
		'Declare users_cursor CURSOR FOR '
		+ 'select owner, k, uid ' 
		+ 'from '
		+ @db_world 
		+ '.dbo.tbl_PostStorage'
	exec sp_executesql @SQL

	open users_cursor
	
	fetch next from users_cursor into @serial, @item_code, @item_serial
	while @@FETCH_STATUS = 0
	begin
		if (@item_code <> -1 AND @item_serial <> 0)
			INSERT INTO 
				[dbo].[tbl_items]
					([container]
					,[slot]
					,[item_serial]
					,[item_code]
					,[player_serial])
				VALUES
					(7
					,0
					,@item_serial
					,@item_code
					,@serial)
		fetch next from users_cursor into @serial, @item_code, @item_serial
	end;

	close users_cursor
	deallocate users_cursor
END

