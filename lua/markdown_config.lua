require('mkdnflow').setup {
	tables = {
		format_on_move=true,
		auto_extend_rows = true,
		auto_extend_cols = true,
	},
	mappings = {
		MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
	}
}
