/*

File: fn_despawnQueueAdd.sqf
Author: Fen 

Description:
Adds AIS location to the despawn queue for processing

Parameters:
_this select 0 : location

*/



params [
	["_location",objNull,[ObjNull]]
];

if (isNil "fen_ais_despawnQueue") then {
	fen_ais_despawnQueue=[];
};

private _radius=_location getVariable "fen_ais_location";

_trigger=createTrigger ["EmptyDetector",position _location];
_trigger setTriggerArea [_radius,_radius,0,false];
_trigger setTriggerActivation ["ANY","PRESENT",false];

_location setVariable ["fen_ais_despawnQueueTrigger",_trigger];

fen_ais_despawnQueue pushBackUnique _location;

if (isNil "fen_ais_despawnQueueHandlerRunning") then {
	fen_ais_despawnQueueHandlerRunning=false;
};

if not(fen_ais_despawnQueueHandlerRunning) then {
	fen_ais_despawnQueueHandlerRunning=true;
	[] spawn fenAIS_fnc_despawnQueueHandler;
};
