/*

File: fn_unitEvasion.sqf
Author: Fen

Description:
Orders unit to keep distance from nearby players

Parameters:
_this select 0 : unit
_this select 1 : evade side
_this select 2 : proximity
_this select 3 : evade move distance

*/

params [
  ["_unit",objNull,[objNull]],
  ["_evadeSide",west,[sideLogic]],
  ["_proximity",100,[0]],
  ["_evadeDistance",100,[0]]
];

private ["_unit"];

while {alive _unit} do {

  waitUntil {
    sleep 1;
    not(alive _unit) or ((count([_unit,_evadeSide,_proximity,true] call fen_fnc_getUnitsNearUnit)>0) and unitReady _unit);
  };

  if not(alive _unit) exitWith {};

  _unit setUnitPos "UP";
  _unit setSpeedMode "FULL";

  private _unitsNearby=[_unit,_evadeSide,_proximity,true] call fen_fnc_getUnitsNearUnit;

  private _nearestUnit=objNull;
  private _closestProximity=99999;
  {
    if ((_unit distance _x)<_closestProximity) then {
      _nearestUnit=_x;
      _closestProximity=(_unit distance _x);
    }
  } forEach _unitsNearby;

  private _evadeDirection=[_nearestUnit,_unit] call BIS_fnc_dirTo;
  switch (true) do {
    case (_evadeDirection<0) : {_evadeDirection=_evadeDirection+360};
    case (_evadeDirection>360) : {_evadeDirection=_evadeDirection-360};
  };
  _evadeDirection=_evadeDirection + (selectRandom [-30,30]);
  switch (true) do {
    case (_evadeDirection<0) : {_evadeDirection=_evadeDirection+360};
    case (_evadeDirection>360) : {_evadeDirection=_evadeDirection-360};
  };

  private _evadeToPosition=[(position _nearestUnit),_evadeDistance,_evadeDirection] call BIS_fnc_relPos;
  _evadeToPosition=[_evadeToPosition,0,50,10,0,9,0] call BIS_fnc_findSafePos;

  _unit doMove _evadeToPosition;
  waitUntil {
    sleep 1;
    not(alive _unit) or unitReady _unit;
  };
  _unit doWatch _nearestUnit;

};
