/*

File: fn_iedObjectVCBGSDespawn.sqf
Author: Fen

Description:
Removes VCB Ground Sign IED Object

Parameters:
_this select 0 : (Object) IED VCB gound sign
*/

params [
  ["_iedObject",objNull,[objNull]]
];

diag_log format["fn_iedObjectVCBGSDespawn starting for %1",_iedObject]; //debugdeleteme
if (isNull _iedObject) exitWith {};
if not(local _iedObject) exitWith {};

private _iedTrigger=nearestObject [_iedObject,"EmptyDetector"];
if (isNull _iedTrigger) exitWith {};

private _allParameters=_iedTrigger getVariable["fen_iedObject_allParameters",[]];

[_iedObject,_allParameters select 2,_allParameters select 3,_allParameters select 4,_allParameters select 5,_allParameters select 6,_allParameters select 7] call fen_fnc_iedObjectVCBGSAdd;

deleteVehicle _iedObject;
