/*

File: fn_groupIsBehaviour.sqf
Author: Fen

Description:
Returns if all units in group have passed behaviour

Parameters:
_this select 0 : group
_this select 1 : behaviour

*/
params [
  ["_group",grpNull,[grpNull]],
  ["_behaviour","AWARE",[""]]
];

private _sameBehaviour=true;

{
  if not(behaviour _x==_behaviour) then {
    _sameBehaviour=false;
  };
} forEach units _group;

_sameBehaviour
