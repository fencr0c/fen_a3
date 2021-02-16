/*

File: fn_intel_addIntel.sqf
Author: Fen

Description:
Allows inteligence to be gathered from an object e.g. documents, photos etc.

Parameters:
_this select 0 : (Object) object
_this select 1 : (String) text

Usage:
[object,"HVT is hidding towards the south of this position"] spawn fen_fnc_intel_addIntel;

*/

private ["_object","_intel"];

_object=param[0,objNull,[objNull]];
_intel=param[1,""];
_intelGathered=param[2,""];

if not(local _object) exitWith {};

[_object,_intel,_intelGathered] remoteExec ["fen_fnc_intel_addAction",0,true];
