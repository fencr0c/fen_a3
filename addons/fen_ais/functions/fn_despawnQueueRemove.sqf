/*

File: fn_despawnQueueRemove.sqf
Author: Fen 

Description:
Remove location to the despawn queue

Parameters:
_this select 0 : location

*/



params [
	["_location",objNull,[ObjNull]]
];

if (isNil "fen_ais_despawnQueue") exitWith {};

fen_ais_despawnQueue=fen_ais_despawnQueue-[_location];

private _trigger=_location getVariable "fen_ais_despawnQueueTrigger";
deleteVehicle _trigger;
