/*

File: fn_moduleToolsInit.sqf
Author: Fen 

Description:
Function for module Tools Init

*/


params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith{};

private _numberTraces=_logic getVariable["numberTraces",5];

[_numberTraces] remoteExec ["fenTools_fnc_bulletTrace",0,true];
