/*

File: fn_iedObjectVCBGSAdd.sqf
Author: Fen

Description:
Adds VCB grounds sign to the gound sign processing array

Parameters:
_this select 0 : (Object) object
_this select 1 : (String) explosion class
_this select 2 : (Array) min/max range for triggering IED
_this select 3 : (Array) min/max delay from trigger to explosion
_this select 4 : (Side) side that will trigger IED
_this select 5 : (String) daisy chain ID
_this select 6 : (String) trigger man ID
*/

params [
  ["_iedObject",objNull,[objNull]],
  ["_explosionClass","M_NLAW_AT_F",[""]],
  ["_proximityLimits",[1,8],[[]],[2]],
  ["_delayLimits",[1,8],[[]],[2]],
  ["_triggeringSide",west,[sideLogic]],
  ["_daisyChainID","",[""]],
  ["_triggerManID","",[""]]
];

if not([_iedObject] call fen_fnc_isVCBGroundSign) exitWith {};

if (isNull _iedObject) exitWith {};
if not(local _iedObject) exitWith {};

private _iedObjectVCBGSData=[
  typeOf _iedObject,
  getPos _iedObject,
  direction _iedObject,
  (_iedObject call BIS_fnc_getPitchBank),
  _explosionClass,
  _proximityLimits,
  _delayLimits,
  _triggeringSide,
  _daisyChainID,
  _triggerManID
];

private _iedObjectVCBGSCache=missionNamespace getVariable ["fen_iedObjectVCBGSCache",[]];
_iedObjectVCBGSCache pushBack _iedObjectVCBGSData;
missionNamespace setVariable["fen_iedObjectVCBGSCache",_iedObjectVCBGSCache];
deleteVehicle _iedObject;

if not(missionNamespace getVariable["fen_iedObjectVCBGSHandler_running",false]) then {
  missionNamespace setVariable["fen_iedObjectVCBGSHandler_running",true];
  [] spawn fen_fnc_iedObjectVCBGSHandler;
};
