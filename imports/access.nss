//Translation ready strings ~URB!
$lang_quickAccess = 'Quick Access'
$lang_shut = 'Shutdown'
$lang_reset = 'Restart'
$lang_logout = 'Logout'

//Hook strings ~URB!
$menu_quick = lang_quickAccess

menu(image=icon.display_settings title=menu_quick sep=before mode=multiple pos=bottom) {

    modify(find='display' menu=menu_quick) //moves display settings into this sub menu
    modify(find='personalise' menu=menu_quick) //moves personalisation settings into this sub menu

    item(image=icon.power_shutdown title=lang_shut sep=before pos=bottom cmd='shutdown.exe' args='/s /t 0') //ability to shutdown system
    item(image=icon.power_restart title=lang_reset pos=bottom cmd='shutdown.exe' args='/r /t 0') //ability to restart system
    item(image=icon.power_logout title=lang_logout pos=bottom cmd='shutdown.exe' args='/l /t 0') //ability to log-out

}