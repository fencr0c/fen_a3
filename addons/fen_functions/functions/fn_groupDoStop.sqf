/*

File: fn_groupDoStop.sqf
Author: Fen

Description:
Issues doStop command on each unit in the group

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

{
  doStop _x;
} forEach units _group;
