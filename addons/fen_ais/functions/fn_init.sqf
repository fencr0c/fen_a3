/*

File: fn_init.sqf
Author: Fen

Description:
Starts AIS.

Parameters:
none

*/

params [
	["_fromModule",false,[true]]
];

if (isNil "fen_debug") then {
	fen_debug=false;
};

if not(_fromModule) then {
	call fenAIS_fnc_stopUnits;
};

fen_ais_locations=call fenAIS_fnc_findLocations;
if (count fen_ais_locations==0) exitWith {
	diag_log "fenAIS_fnc_init: No AIS Locations Found, AIS Ending";
};

call fenAIS_fnc_getVehicles;

call fenAIS_fnc_getGroups;

if (fen_debug) then {
	{
		[_x] call fenAIS_fnc_reportVehicles;
		[_x] call fenAIS_fnc_reportGroups;
	} forEach fen_ais_locations;
};

{
	[_x] call fenAIS_fnc_locationQueueAdd;
} forEach fen_ais_locations;

fen_ais_controlSession=true;

if (fen_debug) then {
	if (isNil "fen_ais_environment") then {
		fen_ais_environment="oops";
		switch true do {
		case (isServer and hasInterface) : {fen_ais_environment="Editor"};
		case not(isServer or hasInterface) : {fen_ais_environment="Headless Client"};
		case (isServer) : {fen_ais_environment="Server"};
		};
		publicVariable "fen_ais_environment";
	} else {
		fen_ais_environment="Multi Session Error";
		publicVariable "fen_ais_environment";
	};
};
