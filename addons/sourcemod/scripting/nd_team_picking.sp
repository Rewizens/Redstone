#include <sourcemod>
#include <nd_stocks>
#include <nd_rounds>
#include <nd_redstone>
#include <nd_print>

public Plugin myinfo = 
{
	name = "[ND] Team Picker",
	author = "Stickz",
	description = "Lets two selected commanders pick their team",
	version = "rebuild",
	url = "https://github.com/stickz/Redstone/"
}

#define CONSORT_aIDX 0
#define EMPIRE_aIDX 1

int last_choice[2];
int team_captain[2];

bool g_bEnabled = false;
bool g_bPickStarted = false;
bool doublePlace = true;
bool firstPlace = true;
bool checkPlacement = true;
bool DebugTeamPicking = false;

ConVar cvarPickTimeLimit;
ConVar cvarFirstPickTime;

/* Auto-Updater Support */
#define UPDATE_URL  "https://github.com/stickz/Redstone/raw/build/updater/nd_team_picking/nd_team_picking.txt"
#include "updater/standard.sp"

#include "nd_team_pick/commands.sp"
#include "nd_team_pick/start_picking.sp"
#include "nd_team_pick/picking_timer.sp"
#include "nd_team_pick/picking_process.sp"

public void OnPluginStart()
{
	LoadTranslations("common.phrases");
	LoadTranslations("nd_team_picking.phrases");
	
	cvarPickTimeLimit = CreateConVar("sm_tp_time", "20", "Set time allocated for each pick");
	cvarFirstPickTime = CreateConVar("sm_tp_time_first", "40", "Set time allocated for first pick");	
	AutoExecConfig(true, "nd_teampick");
	
	RegisterPickingCommand(); //start_picking.sp: Command for starting team picking
	RegisterCommands(); //commands.sp: Extra commands, not directly related to picking
	
	AddCommandListener(Command_JoinTeam, "jointeam");	
	PrintToChatAll("\x05[xG] Team picker plugin reloaded successfully");

	AddUpdaterLibrary(); //auto-updater
}

public Action Command_JoinTeam(int client, char[] command, int argc)
{
	if (!ND_RoundStarted() && g_bEnabled)
	{
		PrintToChat(client,"\x05Please stay in spectator until you're chosen.");
		return Plugin_Handled;
	}
	
	return Plugin_Continue;
}

bool PlayerIsPickable(int client) {
	// If the client is valid by Redstone standards and not already on a team
	return IsValidClient(client, !DebugTeamPicking) && RED_IsValidCIndex(client) && GetClientTeam(client) < 2;
}

int GetPickingTimeLimit() {
	return checkPlacement ? cvarFirstPickTime.IntValue : cvarPickTimeLimit.IntValue;
}
