/*

File: fn_addCachedMine.sqf
Author: Fen

Description:
Adds a mine to the cached mines array

Parameters:
_this select 0 : player
_this select 1 : start position

*/

params [
	["_mine",objNull,[objNull]]
];

if ([_mine] call fen_fnc_isVCBGroundSign) exitWith {};

private _mineData=[typeOf _mine,getPosWorld _mine,direction _mine,(_mine call BIS_fnc_getPitchBank)];

private _cachedMines=missionNamespace getVariable["fen_cachedMines",[]];
_cachedMines pushBack _mineData;
missionNamespace setVariable["fen_cachedMines",_cachedMines];
deleteVehicle _mine;
