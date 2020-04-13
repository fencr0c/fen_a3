/*

File: fn_restartLocation.sqf
Author: Fen

Description:
Restart an AIS Location

Parameters:
_this select 0 : location


*/

private ["_aisLoc"];

_aisLoc=_this select 0;

if (isNil "fen_debug") then {
	fen_debug=false;
};

if isNil("fen_ais_controlSession") exitWith {};

fen_ais_deleteGroups={

	private ["_aisLoc"];

	_aisLoc=_this select 0;

	{
		if ((group _x getVariable ["fen_ownedBy",""]==(str _aisLoc))) then {
			if (vehicle _x!=_x) then {
				deleteVehicle (vehicle _x);
			};
			deleteVehicle _x;
		};
		if ({alive _x} count units _x==0) then {
			deleteGroup (group _x);
		};
	} forEach allUnits;
};

fen_ais_deleteVehicles={

	private ["_aisLoc"];

	_aisLoc=_this select 0;
	{
		if ((_x getVariable ["fen_ownedBy",""]==(str _aisLoc))) then {
			deleteVehicle _x;
		};
	} forEach vehicles;
};


[_aisLoc] call fen_ais_deleteGroups;
[_aisLoc] call fen_ais_deleteVehicles;

//[_aisLoc] execVM "fen_ais\ais_location.sqf";
[_aisLoc] call fenAIS_fnc_locationQueueAdd;
