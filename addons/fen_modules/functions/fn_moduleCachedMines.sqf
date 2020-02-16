/*

File: fn_moduleCachedMines.sqf
Author: Fen 

Description:
Function for module Cached Mines

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _proximity=_logic getVariable ["proximity",800];
private _frequency=_logic getVariable ["frequency",5];

[_proximity,_frequency] spawn fen_fnc_initCachedMines;
