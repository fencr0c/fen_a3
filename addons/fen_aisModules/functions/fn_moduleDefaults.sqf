/*

File: fn_moduleDefaults.sqf
Author: Fen

Description:
Function for module Defaults

*/


params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _locationSpawnFrequency=_logic getVariable["locationSpawnFrequency",2];
private _locationDespawnFrequency=_logic getVariable["locationDespawnFrequency",300];
private _smoothSpawnGroups=_logic getVariable["smoothSpawnGroups",0.03];
private _smoothSpawnVehicles=_logic getVariable["smoothSpawnVehicles",0.03];
private _skillAimAccuracy=_logic getVariable["skillAimAccuracy",0];
private _removeMagazines=[_logic getVariable["removeMagazines",""]] call BIS_fnc_parseNumber;
if (typeName _removeMagazines!="ARRAY") then {
	_removeMagazines=[];
};
private _factionSideSwap=[_logic getVariable["factionSideSwap",""]] call BIS_fnc_parseNumber;
if (typeName _factionSideSwap!="ARRAY") then {
	_factionSideSwap=[];
};

missionNamespace setVariable["fen_ais_locationSpawnFrequency",_locationSpawnFrequency,true];
missionNamespace setVariable["fen_ais_locationDespawnFrequency",_locationDespawnFrequency,true];
missionNamespace setVariable["fen_ais_smoothSpawnGroups",_smoothSpawnGroups,true];
missionNamespace setVariable["fen_ais_smoothSpawnVehicles",_smoothSpawnVehicles,true];
missionNamespace setVariable["fen_ais_skillAimAccuracy",_skillAimAccuracy,true];
missionNamespace setVariable["fen_ais_removeMagazines",_removeMagazines,true];
missionNamespace setVariable["fen_ais_factionSideSwap",_factionSideSwap,true];
