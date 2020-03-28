/*

File: fn_VIRQueueRemove.sqf
Author: Fen

Description:
Removes group to the VIR Queue

Parameters:
_this select 0 : group

*/
params [
  ["_group",grpNull,[grpNull]]
];

if (isNil "fen_VIRQueue") exitWith {};

fen_VIRQueue=fen_VIRQueue-[_group];
