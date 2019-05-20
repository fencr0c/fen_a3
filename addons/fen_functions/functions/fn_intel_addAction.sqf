/*

File: fn_intel_addAction.sqf
Author: Fen 

Description:
Adds Action object for intel gathering, see fen_fnc_intel_addIntel

Parameters:
_this select 0 : (Object) object
_this select 1 : (String) intel

*/

private ["_unit","_intel"];

_object=param[0,objNull,[objNull]];
_intel=param[1,""];

if (hasInterface) then {
	_object addAction ["Pick up Intel",fen_fnc_intel_gather,_intel,99,true,true,"","",2];
};
