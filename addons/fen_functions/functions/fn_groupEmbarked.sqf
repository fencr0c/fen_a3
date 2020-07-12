/*

File: fn_groupEmbarked.sqf
Author: Fen

Description:
Returns if group is all embarked

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

private _allEmbarked=true;
{
  if (vehicle _x==_x) then {
    _allEmbarked=false;
  }
} forEach units _group;

_allEmbarked
