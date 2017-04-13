/*

File: fn_toolsInit.sqf
Author: Fen 

Description:
Starts the tools package running.

Parameters:
none

*/


if (hasInterface) then {

	// add debug actions
	player addAction ["<t color='#FFBF00'>Teleport</t>",fenTools_fnc_teleport];
	player addAction ["<t color='#FFBF00'>Teleport Group</t>",fenTools_fnc_teleportgrp];
	player addAction ["<t color='#FFBF00'>Group enableAI Move</t>",fenTools_fnc_groupmove];
	player addAction ["<t color='#FFBF00'>Log Pos</t>",fenTools_fnc_loggetpos];
	player addAction ["<t color='#FFBF00'>Log PosASL</t>",fenTools_fnc_loggetposasl];
	player addAction ["<t color='#FFBF00'>Grab Sentry</t>",fenTools_fnc_sentrygrabber];
	player addAction ["<t color='#FFBF00'>Start Logging Active SQFs</t>",fenTools_fnc_logactive];
	player addAction ["<t color='#FFBF00'>Report Skill Levels</t>",fenTools_fnc_rptskills];
	player addAction ["<t color='#FFBF00'>Debug Panel OFF</t>",fenTools_fnc_panelInfoOff];
	
	// set invincible
	player allowDamage false;
	{
		_x allowDamage false;
	} forEach units group player;
	// start debug panel
	fen_tools_panelOn=true;
	[] spawn fenTools_fnc_panelinfo;
	
	// start enemy markers 
	[] spawn fenTools_fnc_enemymarkers;

};

// start server fps monitor
[] spawn fenTools_fnc_serverfps;

// start HC fps monitor
[] spawn fenTools_fnc_headlessfps;

