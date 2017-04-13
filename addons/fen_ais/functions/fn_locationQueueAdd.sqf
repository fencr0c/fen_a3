/*

File: fn_locationQueueAdd.sqf
Author: Fen 

Description:
Adds AIS location to the locations queue for processing

Parameters:
_this select 0 : location

*/



params [
	["_location",objNull,[ObjNull]]
];

if (isNil "fen_debug") then {
	fen_debug=false;
};

if (isNil "fen_ais_locationQueue") then {
	fen_ais_locationQueue=[];
};

private _radius=_location getVariable "fen_ais_location";

_trigger=createTrigger ["EmptyDetector",position _location];
_trigger setTriggerArea [_radius,_radius,0,false];
_trigger setTriggerActivation ["ANY","PRESENT",false];

_location setVariable ["fen_ais_locationQueueTrigger",_trigger];

if (fen_debug) then {
	private _dbgMrk=createMarker[str _location,position _location];
	_dbgMrk setMarkerSize[_radius,_radius];
	_dbgMrk setMarkerShape "ELLIPSE";
	_dbgMrk setMarkerColor "ColorRed";
	_dbgMrk setMarkerBrush "Border";
	private _dbgLoc=createMarker[str _location+"_Centre",position _location];
	_dbgLoc setMarkerType "mil_dot";
	_dbgLoc setMarkerText format["%1 radius %2",str _location,_radius];
	_dbgLoc setMarkerColor "ColorRed";
};

fen_ais_locationQueue pushBackUnique _location;

if (isNil "fen_ais_locationQueueHandlerRunning") then {
	fen_ais_locationQueueHandlerRunning=false;
};

if not(fen_ais_locationQueueHandlerRunning) then {
	fen_ais_locationQueueHandlerRunning=true;
	[] spawn fenAIS_fnc_locationQueueHandler;
};
