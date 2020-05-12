/*

File: fn_getUnitsNearPosition.sqf
Author: Fen

Description:
Returns array of units within proximity of a position

Parameters:
_this select 0 : position
_this select 1 : side
_this select 2 : proximity
_this select 3 : use line of sight

*/

params [
  ["_position",[0,0,0],[[]]],
  ["_side",west,[sideLogic]],
  ["_proximity",150,[0]]
];

private _units=[];
{
  _units pushBackUnique _x;
} forEach (allUnits select {(side _x==_side) and ((_position distance _x)<=_proximity)});

_units
