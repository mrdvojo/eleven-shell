//Edited Vanilla File Manage Config, only changed Separator and merged with Go To ~Dvojo
menu(where=sel.count>0 type='file|dir|drive|namespace|back' mode="multiple" title='File manage' sep='before' image=\uE253)
{
	menu(separator="after" title=title.copy_path image=icon.copy_path)
	{
		item(where=sel.count > 1 title='Copy (@sel.count) items selected' cmd=command.copy(sel(false, "\n")))
		item(mode="single" title=@sel.path tip=sel.path cmd=command.copy(sel.path))
		item(mode="single" type='file' separator="before" find='.lnk' title='open file location')
		separator
		item(mode="single" where=@sel.parent.len>3 title=sel.parent cmd=@command.copy(sel.parent))
		separator
		item(mode="single" type='file|dir|back.dir' title=sel.file.name cmd=command.copy(sel.file.name))
		item(mode="single" type='file' where=sel.file.len != sel.file.title.len title=@sel.file.title cmd=command.copy(sel.file.title))
		item(mode="single" type='file' where=sel.file.ext.len>0 title=sel.file.ext cmd=command.copy(sel.file.ext))
	}

	item(mode="single" type="file" title="Change extension" image=\uE0B5 cmd=if(input("Change extension", "Type extension"),
		io.rename(sel.path, path.join(sel.dir, sel.file.title + "." + input.result))))

	menu(separator="after" image=\uE290 title=title.select)
	{
		item(title="All" image=icon.select_all cmd=command.select_all)
		item(title="Invert" image=icon.invert_selection cmd=command.invert_selection)
		item(title="None" image=icon.select_none cmd=command.select_none)
	}

	item(type='file|dir|back.dir|drive' title='Take ownership' image=[\uE194,#f00] admin
		cmd args='/K takeown /f "@sel.path" @if(sel.type==1,null,"/r /d y") && icacls "@sel.path" /grant *S-1-5-32-544:F @if(sel.type==1,"/c /l","/t /c /l /q")')
	separator
	menu(title="Show/Hide" image=icon.show_hidden_files)
	{
		item(title="System files" image=inherit cmd='@command.togglehidden')
		item(title="File name extensions" image=icon.show_file_extensions cmd='@command.toggleext')
	}

	menu(type='file|dir|back.dir' mode="single" title='Attributes' image=icon.properties)
	{
		$atrr = io.attributes(sel.path)
		item(title='Hidden' checked=io.attribute.hidden(atrr)
			cmd args='/c ATTRIB @if(io.attribute.hidden(atrr),"-","+")H "@sel.path"' window=hidden)

		item(title='System' checked=io.attribute.system(atrr)
			cmd args='/c ATTRIB @if(io.attribute.system(atrr),"-","+")S "@sel.path"' window=hidden)

		item(title='Read-Only' checked=io.attribute.readonly(atrr)
			cmd args='/c ATTRIB @if(io.attribute.readonly(atrr),"-","+")R "@sel.path"' window=hidden)

		item(title='Archive' checked=io.attribute.archive(atrr)
			cmd args='/c ATTRIB @if(io.attribute.archive(atrr),"-","+")A "@sel.path"' window=hidden)
		separator
		item(title="Created" keys=io.dt.created(sel.path, 'y/m/d') cmd=io.dt.created(sel.path,2000,1,1) vis=label)
		item(title="Modified" keys=io.dt.modified(sel.path, 'y/m/d') cmd=io.dt.modified(sel.path,2000,1,1) vis=label)
		item(title="Accessed" keys=io.dt.accessed(sel.path, 'y/m/d') cmd=io.dt.accessed(sel.path,2000,1,1) vis=label)
	}

	menu(mode="single" type='file' find='.dll|.ocx' separator="before" title='Register Server' image=\uea86)
	{
		item(title='Register' admin cmd='regsvr32.exe' args='@sel.path.quote' invoke="multiple")
		item(title='Unregister' admin cmd='regsvr32.exe' args='/u @sel.path.quote' invoke="multiple")
	}

	menu(mode="single" type='back' expanded=true)
	{
		menu(separator="before" title='New Folder' image=icon.new_folder)
		{
			item(title='DateTime' cmd=io.dir.create(sys.datetime("ymdHMSs")))
			item(title='Guid' cmd=io.dir.create(str.guid))
		}

		menu(title='New File' image=icon.new_file)
		{
			$dt = sys.datetime("ymdHMSs")
			item(title='TXT' cmd=io.file.create('@(dt).txt', 'Hello World!'))
			item(title='XML' cmd=io.file.create('@(dt).xml', '<root>Hello World!</root>'))
			item(title='JSON' cmd=io.file.create('@(dt).json', '[]'))
			item(title='HTML' cmd=io.file.create('@(dt).html', "<html>\n\t<head>\n\t</head>\n\t<body>Hello World!\n\t</body>\n</html>"))
		}
	}

	item(where=!wnd.is_desktop title=title.folder_options image=icon.folder_options cmd=command.folder_options)
}

//Edited Vanilla Go To Config, only changed Separator and merged with File Manage ~Dvojo
menu(type='*' where=window.is_taskbar||sel.count mode=mode.multiple title=title.go_to sep='after' image=\uE14A) //Changed separator from both to bottom only ~Dvojo
{
	menu(title='Folder' image=\uE1F4)
	{
		item(title='Windows' image=inherit cmd=sys.dir)
		item(title='System' image=inherit cmd=sys.bin)
		item(title='Program Files' image=inherit cmd=sys.prog)
		item(title='Program Files x86' image=inherit cmd=sys.prog32)
		item(title='ProgramData' image=inherit cmd=sys.programdata)
		item(title='Applications' image=inherit cmd='shell:appsfolder')
		item(title='Users' image=inherit cmd=sys.users)
		separator
		//item(title='@user.name@@@sys.name' vis=label)
		item(title='Desktop' image=inherit cmd=user.desktop)
		item(title='Downloads' image=inherit cmd=user.downloads)
		item(title='Pictures' image=inherit cmd=user.pictures)
		item(title='Documents' image=inherit cmd=user.documents)
		item(title='Startmenu' image=inherit cmd=user.startmenu)
		item(title='Profile' image=inherit cmd=user.dir)
		item(title='AppData' image=inherit cmd=user.appdata)
		item(title='Temp' image=inherit cmd=user.temp)
	}
	item(title=title.control_panel image=\uE0F3 cmd='shell:::{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}')
	item(title='All Control Panel Items' image=\uE0F3 cmd='shell:::{ED7BA470-8E54-465E-825C-99712043E01C}')
	item(title=title.run image=\uE14B cmd='shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}')
	menu(where=sys.ver.major >= 10 title=title.settings sep=sep.before image=\uE0F3)
	{
		// https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
		item(title='system' image=inherit cmd='ms-settings:')
		item(title='about' image=inherit cmd='ms-settings:about')
		item(title='your-info' image=inherit cmd='ms-settings:yourinfo')
		item(title='system-info' image=inherit cmd-line='/K systeminfo')
		item(title='search' cmd='search-ms:' image=inherit)
		item(title='usb' image=inherit cmd='ms-settings:usb')
		item(title='windows-update' image=inherit cmd='ms-settings:windowsupdate')
		item(title='windows-defender' image=inherit cmd='ms-settings:windowsdefender')
		menu(title='apps' image=inherit)
		{
			item(title='apps-features' image=inherit cmd='ms-settings:appsfeatures')
			item(title='default-apps' image=inherit cmd='ms-settings:defaultapps')
			item(title='optional-features' image=inherit cmd='ms-settings:optionalfeatures')
			item(title='startup' image=inherit cmd='ms-settings:startupapps')
		}
		menu(title='personalization' image=inherit)
		{
			item(title='personalization' image=inherit cmd='ms-settings:personalization')
			item(title='lockscreen' image=inherit cmd='ms-settings:lockscreen')
			item(title='background' image=inherit cmd='ms-settings:personalization-background')
			item(title='colors' image=inherit cmd='ms-settings:colors')
			item(title='themes' image=inherit cmd='ms-settings:themes')
			item(title='start' image=inherit cmd='ms-settings:personalization-start')
			item(title='taskbar' image=inherit cmd='ms-settings:taskbar')
		}
		menu(title='network' image=inherit)
		{
			item(title='status' image=inherit cmd='ms-settings:network-status')
			item(title='ethernet' image=inherit cmd='ms-settings:network-ethernet')
			item(title='connections' image=inherit cmd='shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}')
		}
	}
}
