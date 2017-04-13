/*

File: fn_groupDistance.sqf
Author: Fen 

Description:
Returns distance of futherest group member from a position

Parameters:
_this select 0 : Group 
_this select 1 : Position

*/

private ["_group","_position","_distance"];

_group=param[0,grpNull,[grpNull]];
_position=param[1,[0,0],[[]]];

_distance=0;

if (isNull _group) exitWith {
	_distance
};

{
	if (_x distance _position>_distance) then {
		_distance=_x distance _position;
	};
} forEach units _group;

_distance