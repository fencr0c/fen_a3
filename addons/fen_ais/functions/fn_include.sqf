/*

File: fn_include.sqf
Author: Fen 

Description:
Adds a group or vehicle to AIS

Parameters:
_this select 0 : unit or object
_this select 1 : optional parameters
_this select 2 : optional owning location

*/

private ["_thing","_data","_vari"];

_thing=param[0,objNull,[objNull]];
_data=param[1,true];
_vari=param[2,objNull,[objNull]];

if (isNull _thing)  exitWith {};

if (isNull (group _thing)) then {
	[_thing,_data,_vari] call fenAIS_fnc_vehicle;
} else {
	[_thing,_data,_vari] call fenAIS_fnc_group;
};
