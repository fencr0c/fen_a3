/*

File: fn_groupHasTargets.sqf
Author: Fen

Description:
Returs groups targets in array.
Element 0 boolean
Element 1 array of targets

Parameters:
_this select 0 : group
_this select 1 : proximity

*/

params [
  ["_group",grpNull,[grpNull]],
  ["_proximity",500,[0]]
];

private _returnArray=[];
private _targets=[leader _group,_proximity] call fen_fnc_nearTargets;

_returnArray set [0,(count _targets>0)];
_returnArray set [1,_targets];

_returnArray
