/*

File: fn_VIRQueueAdd.sqf
Author: Fen

Description:
Adds group to the VIR Queue

Parameters:
_this select 0 : group
_this select 1 : crew disembark (boolean)
_this select 2 : proximity
_this select 3 : packet number

*/

params [
  ["_group",grpNull,[grpNull]],
  ["_crewDisembark",true,[true]],
  ["_proximity",750,[0]],
  ["_packet",1,[1]]
];

if not(local (leader _group)) exitWith {};

_group setVariable["fen_VIRProximity",_proximity];
_group setVariable["fen_VIRCrewDisembark",_crewDisembark];
_group setVariable["fen_VIRVehicle",([_group] call fen_fnc_groupGetVehicle)];
_group setVariable["fen_VIRPacket",_packet];

if (isNil "fen_VIRQueue") then {
  fen_VIRQueue=[];
};

fen_VIRQueue pushBackUnique _group;

if (isNil "fen_VIRQueueRunning") then {
  fen_VIRQueueRunning=false;
};

if not(fen_VIRQueueRunning) then {
  fen_VIRQueueRunning=true;
  [] spawn fen_fnc_VIRQueueHandler;
};
