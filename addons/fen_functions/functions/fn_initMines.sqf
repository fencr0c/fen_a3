/*

File: fn_initMines.sqf
Author: Fen 

Description:
Function to handle the starting of cached mines.
Functions will find allMines in the mission added them to the mine cache and spawning them based on player proximity.

Parameters:
_this select 0 : proximity (scalar)
_this select 1 : frequency check (scalar)

*/

params [
    ["_proximity",500,[0]],
    ["_frequency",5,[0]]
];

if not(isServer) exitWith{};


private _cachedMinesData=[];
{
    [_x] call fen_fnc_addCachedMine;
} forEach allMines;

if (count (missionNamespace getVariable["fen_cachedMines",[]])>0) then {
    [_proximity,_frequency] call fen_fnc_handleMines;
};

