/*

File: fn_toolsInit.sqf
Author: Fen 

Description:
Starts the tools package running.

Parameters:
none

*/


if (hasInterface) then {

    private _enableTeleport=missionNamespace getVariable ["fen_enableTeleport",true];
    private _enableTeleportGrp=missionNamespace getVariable ["fen_enableTeleportGrp",true];
    private _enableGroupMove=missionNamespace getVariable ["fen_enableGroupMove",true];
    private _enableLogPosition=missionNamespace getVariable ["fen_enableLogPosition",true];
    private _enableLogPositionASL=missionNamespace getVariable ["fen_enableLogPositionASL",true];
    private _enableGrabSentry=missionNamespace getVariable ["fen_enableGrabSentry",true];
    private _enableGrabLocation=missionNamespace getVariable ["fen_enableGrabLocation",true];
    private _enableLogSQF=missionNamespace getVariable ["fen_enableLogSQF",true];
    private _enableLogSkill=missionNamespace getVariable ["fen_enableLogSkill",true];
    private _enableDebugPanel=missionNamespace getVariable ["fen_enableDebugPanel",true];
    private _enableDebugPanelDefault=missionNamespace getVariable ["fen_enableDebugPanelDefault",true];
    private _enableEnemyMarkers=missionNamespace getVariable ["fen_enableEnemyMarkers",true];
    private _enableEnemyMarkersDefault=missionNamespace getVariable ["fen_enableEnemyMarkersDefault",true];

	// add debug actions
    if (_enableTeleport) then {
        player addAction ["<t color='#FFBF00'>Teleport</t>",fenTools_fnc_teleport,[],0,false,false,""];
    };
    if (_enableTeleportGrp) then {
        player addAction ["<t color='#FFBF00'>Teleport Group</t>",fenTools_fnc_teleportgrp,[],0,false,false,""];
    };
	if (_enableGroupMove) then {
        player addAction ["<t color='#FFBF00'>Group enableAI Move</t>",fenTools_fnc_groupmove,[],0,false,false,""];
    };
    if (_enableLogPosition) then {
        player addAction ["<t color='#FFBF00'>Log Pos</t>",fenTools_fnc_loggetpos,[],0,false,false,""];
    };
    if (_enableLogPositionASL) then {
        player addAction ["<t color='#FFBF00'>Log PosASL</t>",fenTools_fnc_loggetposasl,[],0,false,false,""];
    };
    if (_enableGrabSentry) then {
        player addAction ["<t color='#FFBF00'>Grab Sentry</t>",fenTools_fnc_sentrygrabber,[],0,false,false,""];
    };
    if (_enableGrabLocation) then {
        player addAction ["<t color='#FFBF00'>Grab Locations</t>",fenTools_fnc_locationgrabber,[],0,false,false,""];
    };
    if (_enableLogSQF) then {
        player addAction ["<t color='#FFBF00'>Start Logging Active SQFs</t>",fenTools_fnc_logactive,[],0,false,false,""];
    };
    if (_enableLogSkill) then {
        player addAction ["<t color='#FFBF00'>Report Skill Levels</t>",fenTools_fnc_rptskills,[],0,false,false,""];
    };
    if (_enableDebugPanel) then {
        if (_enableDebugPanelDefault) then {
            fen_tools_panelOn=true;
            [] spawn fenTools_fnc_panelinfo;
            player addAction ["<t color='#FFBF00'>Debug Panel OFF</t>",fenTools_fnc_panelInfoOff,[],0,false,false,""];
        } else {
            player addaction ["<t color='#FFBF00'>Debug Panel ON</t>",fenTools_fnc_panelInfoOn,[],0,false,false,""];
        };
    };
    if (_enableEnemyMarkers) then {
        if (_enableEnemyMarkersDefault) then {
            fen_tools_enemyMarkersOn=true;
            [] spawn fenTools_fnc_enemymarkers;
            player addAction ["<t color='#FFBF00'>Enemy Markers OFF</t>",fenTools_fnc_EnemyMarkersOff,[],0,false,false,""];
        } else {
            player addAction ["<t color='#FFBF00'>Enemy Markers ON</t>",fenTools_fnc_EnemyMarkersOn,[],0,false,false,""];
        };
	};
    
	// set invincible
	player allowDamage false;
	{
		_x allowDamage false;
	} forEach units group player;
    
};

// start server fps monitor
[] spawn fenTools_fnc_serverfps;

// start HC fps monitor
[] spawn fenTools_fnc_headlessfps;

