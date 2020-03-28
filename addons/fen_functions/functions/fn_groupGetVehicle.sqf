/*

File: fn_groupGetVehicle.sqf
Author: Fen

Description:
Returns groups assigned vehicle

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

private _groupVehicle=[];

{
  _groupVehicle pushBackUnique (assignedVehicle  _x);
} forEach units _group;

_groupVehicle select 0
