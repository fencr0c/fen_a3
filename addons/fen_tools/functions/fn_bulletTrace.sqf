/*

File: fn_bulletTrace.sqf
Author: Fen 

Description:
Start tracing bullet paths.

Parameters:

*/

params [
    ["_numberTraces",5,[0]]
];

if not(hasInterface) exitWith{};

[player,_numberTraces] spawn BIS_fnc_traceBullets;