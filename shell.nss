settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=1
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'

import 'imports/modify.nss'

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}


// Turned-Off vanilla File Manage options ~Dvojo
//import 'imports/file-manage.nss'

//Turned-Off vanilla Go To options ~Dvojo
//import 'imports/goto.nss'

import 'imports/develop.nss'
import 'imports/taskbar.nss'

//Edited and Merged File Manage, Go To menus ~Dvojo
import 'imports/manage_menu.nss'

import 'imports/terminal.nss'

remove(find='AMD Software: Adrenalin Edition') //disable sys. placed AMD Adrenalin App ~Dvojo
remove(find='NVIDIA App') //disable sys. placed NVIDIA app ~Dvojo
remove(find='NVIDIA Control Panel') //disable sys. placed old NVIDIA Control Panel app ~Dvojo
item(title='Adrenalin Software' cmd='C:\Program Files\AMD\CNext\CNext\RadeonSoftware.exe' image) //AMD Adrenalin App ~Dvojo
item(title='NVIDIA' cmd='C:\Program Files\NVIDIA Corporation\NVIDIA App\CEF\NVIDIA App.exe' image) //NVIDIA App ~Dvojo
item(image title='Seelen' cmd='seelen-ui.exe') //Launches SeelenUI GUI
item(image title=appx.name('MicaForEveryone') cmd='@package.path("MicaForEveryone.MicaForEveryone2_2.0.5.0_x64__eydvrrwaqjtyw")\MicaForEveryone.App.exe') //Launches Mica for Everyone GUI
item(image=\uE249 title=app.name cmd='@app.exe') //Launches Nilesoft Shell GUI

//Power Menu also with custom icons ~Dvojo
import 'imports/access.nss'