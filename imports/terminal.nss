menu(image='@package.path("WindowsTerminal")\WindowsTerminal.exe'  title=title.terminal type='*' where=(sel.count or wnd.is_taskbar or wnd.is_edit)) {
	
	$tip_run_admin=["\xE1A7 Press SHIFT key to run " + this.title + " as administrator", tip.warning, 1.0]
	$has_admin=key.shift() or key.rbutton()
	
	item(where=package.exists("WindowsTerminal") title=title.terminal tip=tip_run_admin admin=has_admin cmd='wt.exe' arg='-d "@sel.path\."' image='@package.path("WindowsTerminal")\WindowsTerminal.exe')
}