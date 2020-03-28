/*

File: fn_groupAlive.sqf
Author: Fen

Description:
Return if group is alive or not

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

({alive _x} count units _group)>0
