/*

File: fn_civThrowGrenade.sqf
Author: Fen

Description:
Civilian unit will be equiped with MiniGrenade and throw it at nearest enemy unit.

Parameters:
_this select 0 : unit to throw grenade
_this select 1 : side to engage
_this select 2 : proximity to throw grenade
_this select 3 : evasion proximity
_this select 4 : evasion move

*/

params[
  ["_thrower",objNull,[objNull]],
  ["_sideToEngage",west,[sideLogic]],
  ["_proximity",60,[0]],
  ["_evasionProximity",30,[0]],
  ["_evasionMove",100,[0]]
];

if not(local _thrower) exitWith{};

_thrower allowFleeing 0;
_thrower addMagazines["MiniGrenade",1];

while {(alive _thrower) and (count(magazines _thrower select {_x=="MiniGrenade"})>0)} do {

  private _unitsNearby=[_thrower,_sideToEngage,_proximity,true] call fen_fnc_getUnitsNearUnit;

  if (count _unitsNearby>0) then {

    private _nearestUnit=objNull;
    private _closestProximity=99999;
    {
      if ((_thrower distance _x)<_closestProximity) then {
        _nearestUnit=_x;
        _closestProximity=(_thrower distance _x);
      }
    } forEach _unitsNearby;

    [group _thrower] call fen_fnc_groupDeleteWaypoints;

    _thrower selectWeapon "HandGrenadeMuzzle";
    _thrower doFire _nearestUnit;

  };

  sleep 3;
};

if (_evasionProximity>0) then {
  [_thrower,_sideToEngage,_evasionProximity,_evasionMove] spawn fen_fnc_unitEvasion;
};
