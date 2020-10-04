/*

File: fn_playersNearPosition.sqf
Author: Fen

Description:
Returns if players in proximity to a position.

Parameters:
_this select 0 : position (array)
_this select 0 : proximity (scalar)

*/

params [
  ["_position",[0,0,0],[[]]],
  ["_proximity",500,[0]]
];

({(getPos _x) distance _position<_proximity} count (call BIS_fnc_listPlayers)>0)
