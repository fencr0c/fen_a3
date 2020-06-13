/*

File: fn_IEDObjectTriggerMan.sqf
Author: Fen

Description:
Defines unit as a trigger man for IED Object(s)

Parameters:
_this select 0 : trigger man unit
_this select 1 : side to engage
_this select 2 : proximity to IED
_this select 3 : trigger Man ID
_this select 4 : start evasion _proximity
_this select 5 : evasion move distances

*/

params[
  ["_triggerMan",objNull,[objNull]],
  ["_sideToEnage",west,[sideLogic]],
  ["_proximityIED",25,[0]],
  ["_triggerManID","",[""]],
  ["_evasionProximity",75,[0]],
  ["_evasionMove",100,[0]]
];

if not(local _triggerMan) exitWith{};

_triggerMan allowFleeing 0;

if (_evasionProximity>0) then {
  [_triggerMan,_sideToEnage,_evasionProximity,_evasionMove] spawn fen_fnc_unitEvasion;
};

while {alive _triggerMan} do {

  /*{
    private _iedObject=_x;
    if (count(allUnits select {side _x==_sideToEnage and _x distance _iedObject<_proximityIED and ([_triggerMan,_x] call fen_fnc_hasLOStoUnit)})>0) then {
      _iedObject setVariable ["fen_iedObject_hasTriggeredRemotely",true];
    };
  } forEach ((allmissionObjects "") select {(_x getVariable ["fen_iedObject_triggerManID",""])==_triggerManID});*/
  {
    private _iedTrigger=_x;
    if (count(allUnits select {side _x==_sideToEnage and _x distance _iedTrigger<_proximityIED and ([_triggerMan,_x] call fen_fnc_hasLOStoUnit)})>0) then {
      _iedTrigger setVariable ["fen_iedObject_hasTriggeredRemotely",true];
    };

  } forEach (_triggerMan nearObjects["EmptyDetector",500] select {(_x getVariable["fen_iedObject_triggerManID",""])==_triggerManID});

  sleep 3;

};
