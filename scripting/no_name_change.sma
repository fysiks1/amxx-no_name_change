#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

new g_pEnable

public plugin_init()
{
	register_plugin("No Name Change", "0.1", "Fysiks")

	g_pEnable = register_cvar("no_name_change_enable", "0")

	register_forward(FM_ClientUserInfoChanged, "ClientUserInfoChanged")
}

public ClientUserInfoChanged(id)
{
	static const name[] = "name"
	static szOldName[32], szNewName[32]

	if( !is_user_admin(id) && get_pcvar_num(g_pEnable) )
	{
		pev(id, pev_netname, szOldName, charsmax(szOldName))
		if( szOldName[0] )
		{
			get_user_info(id, name, szNewName, charsmax(szNewName))
			if( !equal(szOldName, szNewName) )
			{
				set_user_info(id, name, szOldName)
				return FMRES_HANDLED
			}
		}
	}
	return FMRES_IGNORED
}

