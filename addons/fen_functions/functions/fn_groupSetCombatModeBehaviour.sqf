/*

File: fn_groupSetCombatModeBehaviour.sqf
Author: Fen

Description:
Sets a groups combat mode and behaviour

Parameters:
_this select 0 : group
_this select 1 : combat mode
_this select 2 : behaviour

*/

params [
  ["_group",grpNull,[grpNull]],
  ["_combatMode","YELLOW",[""]],
  ["_behaviour","AWARE",[""]]
];

{
  _x setCombatMode _combatMode;
  _x setBehaviour _behaviour;
} forEach units _group;
