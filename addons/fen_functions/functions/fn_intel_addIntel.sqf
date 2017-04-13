/*

File: fn_intel_addIntel.sqf
Author: Fen 

Description:
Allows inteligence to be gathered from an object e.g. documents, photos etc.

Parameters:
_this select 0 : (Object) object
_this select 1 : (String) text

*/

private ["_object","_intel"];

_object=param[0,objNull,[objNull]];
_intel=param[1,""];

if not(local _object) exitWith {};

[_object,_intel] remoteExec ["fen_fnc_intel_addAction",0,true];

