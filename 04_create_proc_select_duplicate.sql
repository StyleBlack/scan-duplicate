SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pSelectDuplicateItems]
	@db_world varchar(64) 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CURSOR CURSOR

	SET @CURSOR  = CURSOR SCROLL
	FOR
	SELECT [item_serial],[item_code] FROM [dbo].[tbl_items] 
		GROUP BY [item_serial],[item_code] HAVING count(*)>1;

	open @CURSOR

	declare @item_id smallint
	declare @serial int
	declare @item_code int
	declare @container smallint
	declare @account_serial int
	declare @serial_item bigint
	DECLARE @asQuery NVARCHAR(4000)

	fetch next from @CURSOR INTO @serial_item, @item_code
	while @@FETCH_STATUS = 0
	begin
		DECLARE @ITEM_CURSOR CURSOR
	
		SET @ITEM_CURSOR  = CURSOR SCROLL
		for
		select [index],[container], [player_serial] from [dbo].[tbl_items] 
			where [item_serial] = @serial_item

		open @ITEM_CURSOR
		fetch next from @ITEM_CURSOR INTO @item_id, @container, @serial
		while @@FETCH_STATUS = 0
		begin
			set @account_serial = @serial
			if @container = 0 or @container = 1 or @container = 2 or @container = 5 or @container = 6
			begin
				set @asQuery = 
					'select @account_serialOUT=AccountSerial from ' 
					+ @db_world + '.dbo.tbl_base where serial=' + CAST(@serial AS varchar(11)) 
				EXEC SP_EXECUTESQL 
					@Query  = @asQuery
				  , @Params = N'@account_serialOUT int output'
				  , @account_serialOUT = @account_serial output
			end

			INSERT INTO [dbo].[tbl_duplicate]
			   ([item_id]
			   ,[account_serial])
			 VALUES
				   (@item_id
				   ,@account_serial)
			fetch next from @ITEM_CURSOR INTO @item_id, @container, @serial
		end
		close @ITEM_CURSOR
		deallocate @ITEM_CURSOR
	
		FETCH NEXT FROM @CURSOR INTO @serial_item, @item_code
	end
	close @CURSOR

END
