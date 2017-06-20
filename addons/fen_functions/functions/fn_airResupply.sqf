/*

File: fn_airResupply.sqf
Author: Fen

Description:
Drops supplies by parachute

Parameters:
_this select 0 : (Side) side of transport aircraft
_this select 1 : (String) transport aircraft class name
_this select 2 : (Array) array of class names to drop
_this select 3 : (Array) start position of transport aircraft
_this select 4 : (Array) array of WP positions
_this select 5 : (Scalar) wp # to start drop
_this select 6 : (Object) trigger starting air resupply
_this select 7 : (Scalar) flying hieght 
_this select 8 : (String) class name for chute


*/

if not(isServer) exitWith {};

params [
	["_aircraftSide",west,[sideLogic]],
	["_aircraftClass","B_T_VTOL_01_vehicle_F",[""]],
	["_dropClasses",["Box_NATO_AmmoVeh_F"],[[]]],
	["_startPosition",[0,0,0],[[]]],
	["_waypoints",[],[[]]],
	["_dropWp",0,[0]],
	["_trigger",objNull,[objNull]],
	["_flyHieght",150,[0]],
	["_chuteClass","B_Parachute_02_F",[""]]
];

if (count _waypoints==0) exitWith {
	diag_log format["fn_airResupply: no waypoints for aircraft"];
};
if ((count _waypoints)-1<_dropWp) exitWith {
	diag_log format["fn_airResupply: dropWP greater than waypoints"];
};
if (isNull _trigger) exitWith {
	diag_log format["fn_airResupply: trigger not defined"];
};

waitUntil {
	sleep 3;
	triggerActivated _trigger;
};

_startPosition set[2,(_startPosition select 2) max 250];
private _spawnedData=[_aircraftSide,_startPosition,0,_startPosition getDir (_waypoints select 0),false,true,_aircraftClass] call fen_fnc_spawnVehicle;
{
	_x allowFleeing 0;
} forEach units (_spawnedData select 1);

(_spawnedData select 0) flyInHeight _flyHieght;

(_spawnedData select 1) setVariable ["fn_airResupply_dropClasses",_dropClasses];
(_spawnedData select 1) setVariable ["fn_airResupply_chuteClass",_chuteClass];

for [{_idx=0},{_idx < count _waypoints},{_idx=_idx+1}] do {

	(_spawnedData select 1) addWaypoint [_waypoints select _idx,0];
	[(_spawnedData select 1),_idx+1] setWayPointType "MOVE";
	if (_idx==_dropWp) then {
		[(_spawnedData select 1),_idx+1] setWaypointStatements ["true", "n0 = [this] spawn fen_fnc_airResupply_drop"];
	};
	if (_idx==(count _waypoints)-1) then {
		[(_spawnedData select 1),_idx+1] setWaypointStatements ["true","[(group this)] call fen_fnc_dltGroup"];
	};
	
};
