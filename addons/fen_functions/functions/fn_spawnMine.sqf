/*

File: fn_addSpawnMine.sqf
Author: Fen 

Description:
Spawns a mine.

Parameters:
_this select 0 : type of mine
_this select 1 : position to world
_this select 2 : direction
_this select 3 : pitch/bank

*/

params [
    ["_mineData",[],[[]]]
];

if (isNil "fen_debug") then {
    fen_debug=false;
};

private _type=_mineData select 0;
private _position=_mineData select 1;
private _direction=_mineData select 2;
private _pitchBank=_mineData select 3;

private _mine=createVehicle [_type,_position,[],0,"CAN_COLLIDE"];
_mine setPosWorld _position;
[_mine,_pitchBank select 0,_pitchBank select 1] call BIS_fnc_setPitchBank;	
_mine setDir _direction;

private _cachedMines=missionNamespace getVariable["fen_cachedMines",[]];
_cachedMines=_cachedMines-[_mineData];
missionNamespace setVariable["fen_cachedMines",_cachedMines];

