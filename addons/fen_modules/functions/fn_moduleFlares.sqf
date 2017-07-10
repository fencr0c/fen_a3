/*

File: fn_moduleFlares.sqf
Author: Fen 

Description:
Function for module ArtilleryFX

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _maxDistance=_logic getVariable ["maxDistance",300];
private _numSimFlares=_logic getVariable ["numSimFlares",10];
private _frequency=_logic getVariable ["frequency",30];
private _runTimes=_logic getVariable ["runTimes",10];

[position _logic,_maxDistance,_numSimFlares,_frequency,_runTimes] spawn fen_fnc_flares;

