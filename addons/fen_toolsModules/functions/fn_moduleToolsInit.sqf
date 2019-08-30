/*

File: fn_moduleToolsInit.sqf
Author: Fen 

Description:
Function for module Tools Init

*/


params [
	["_logic",objNull,[objNull]]
];

private _editorOnly=_logic getVariable ["editorOnly",false];
missionNamespace setVariable ["fen_enableTeleport",(_logic getVariable ["enableTeleport",true]),true];
missionNamespace setVariable ["fen_enableTeleportGrp",(_logic getVariable ["enableTeleportGrp",true]),true];
missionNamespace setVariable ["fen_enableGroupMove",(_logic getVariable ["enableGroupMove",true]),true];
missionNamespace setVariable ["fen_enableLogPosition",(_logic getVariable ["enableLogPosition",true]),true];
missionNamespace setVariable ["fen_enableLogPositionASL",(_logic getVariable ["enableLogPositionASL",true]),true];
missionNamespace setVariable ["fen_enableGrabSentry",(_logic getVariable ["enableGrabSentry",true]),true];
missionNamespace setVariable ["fen_enableGrabLocation",(_logic getVariable ["enableGrabLocation",true]),true];
missionNamespace setVariable ["fen_enableLogSQF",(_logic getVariable ["enableLogSQF",true]),true];
missionNamespace setVariable ["fen_enableLogSkill",(_logic getVariable ["enableLogSkill",true]),true];
missionNamespace setVariable ["fen_enableDebugPanel",(_logic getVariable ["enableDebugPanel",true]),true];
missionNamespace setVariable ["fen_enableDebugPanelDefault",(_logic getVariable ["enableDebugPanelDefault",true]),true];
missionNamespace setVariable ["fen_enableEnemyMarkers",(_logic getVariable ["enableEnemyMarkers",true]),true];
missionNamespace setVariable ["fen_enableEnemyMarkersDefault",(_logic getVariable ["enableEnemyMarkersDefault",true]),true];

if (_editorOnly) then {
	if (isServer and hasInterface) then {
		fen_debug=true;
		publicVariable "fen_debug";
		[] spawn fenTools_fnc_toolsInit;
	};
} else {
	if (isServer) then {
		fen_debug=true;
		publicVariable "fen_debug";
		[] remoteExec ["fenTools_fnc_toolsInit",0,true];
	};
};



