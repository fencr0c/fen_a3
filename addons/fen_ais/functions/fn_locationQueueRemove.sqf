/*

File: fn_locationQueueRemove.sqf
Author: Fen 

Description:
Remove location to the locations queue 

Parameters:
_this select 0 : location

*/



params [
	["_location",objNull,[ObjNull]]
];

if (isNil "fen_ais_locationQueue") exitWith {};

fen_ais_locationQueue=fen_ais_locationQueue-[_location];

private _trigger=_location getVariable "fen_ais_locationQueueTrigger";
deleteVehicle _trigger;
