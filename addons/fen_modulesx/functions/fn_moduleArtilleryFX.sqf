/*

File: fn_moduleArtilleryFX.sqf
Author: Fen 

Description:
Function for module ArtilleryFX

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _minDistance=_logic getVariable ["minDistance",0];
private _maxDistance=_logic getVariable ["maxDistance",300];
private _fireMissions=_logic getVariable ["fireMissions",2];
private _delayFireMissions=_logic getVariable ["delayFireMissions",60];
private _shellCount=_logic getVariable ["shellCount",5];
private _safeDistance=_logic getVariable ["safeDistance",75];
private _shellClass=_logic getVariable ["shellClass","Sh_82mm_AMOS"];

[position _logic,_minDistance,_maxDistance,_shellClass,_safeDistance,_delayFireMissions,_shellCount,_fireMissions] spawn fen_fnc_artilleryFX;

