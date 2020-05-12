/*

File: fn_getUnitsNearPosition.sqf
Author: Fen

Description:
Returns array of units within proximity of a position

Parameters:
_this select 0 : position
_this select 1 : side
_this select 2 : proximity
_this select 3 : use line of sight

*/

params [
  ["_unit",objNull,[objNull]],
  ["_side",west,[sideLogic]],
  ["_proximity",150,[0]],
  ["_useLOS",true,[true]]
];

private _units=[];
{
  if not(_useLOS) then {
    _units pushBackUnique _x;
  } else {
    if (([objNull,"VIEW",_unit] checkVisibility [(eyePos _unit),(eyePos _x)])==1) then {
      _units pushBackUnique _x;
    };
  };
} forEach (allUnits select {(side _x==_side) and ((_unit distance _x)<=_proximity)});

_units
