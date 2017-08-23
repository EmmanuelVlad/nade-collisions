#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#define VERSION "1.0"

new Collision_Offsets;
ConVar sm_nade_collisions;

public Plugin:myinfo =
{
	name = "Nade collisions",
	author = "evlad",
	description = "Toggle nade collisions",
	version = VERSION,
	url = "https://emmanuelvlad.com/"
}

public void OnPluginStart()
{
	Collision_Offsets = FindSendPropInfo("CBaseEntity", "m_CollisionGroup");
	sm_nade_collisions = CreateConVar("sm_nade_collisions", "0", "Toggle nade collisions", FCVAR_NOTIFY, true, 0.0, true, 1.0);

	HookEvent("player_spawn", OnPlayerSpawn, EventHookMode_Post);
}

public Action:OnPlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast)
{
	if (GetConVarInt(sm_nade_collisions) == 0)
	{
		new client = GetClientOfUserId(GetEventInt(event, "userid"));
		SetEntData(client, Collision_Offsets, 13, 1, true);
	}
}
