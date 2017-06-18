/*

File: fn_moduleAirResupply.sqf
Author: Fen 

Description:
Function for module airResupply

*/

params [
	["_logic",objNull,[objNull]],
	["_syncd",[],[[]]]
];

diag_log format["fn_moduleAirResupply started"];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _dropWP=_logic getVariable ["dropWP",0];
private _flyHeight=_logic getVariable ["flyHeight",150];
private _chuteCLass=_logic getVariable ["chuteClass","B_Parachute_02_F"];

diag_log format["fn_moduleAirResupply: syncd air units %1",(synchronizedObjects _logic) select {vehicle _x isKindof "Air"}];
diag_log format["fn_moduleAirResupply: syncd triggers %1",(synchronizedObjects _logic) select {vehicle _x isKindof "EmptyDetector"}];

{

	diag_log format["fn_moduleAirResupply: check point 1"];
	private _aircraftSide=side _x;
	private _aircraftClass=typeOf vehicle _x;
	private _dropClasses=[];
	private _startPosition=position _x;
	diag_log format["fn_moduleAirResupply: check point 2"];
	{
		_dropClasses pushBack (typeOf _x);
		deleteVehicle _x;
	} forEach (synchronizedObjects _x select {not(_x isKindOf "fen_moduleAirResupply")});

	diag_log format["fn_moduleAirResupply: check point 3 dropclasses %1",_dropClasses];

	private _waypoints=[];
	for [{_idx=1},{_idx<count(waypoints (group _x))},{_idx=_idx+1}] do {
		_waypoints pushBack (waypointPosition [group _x,_idx]);
	};
	diag_log format["fn_moduleAirResupply: check point 4 waypoints %1",_waypoints];
	diag_log format["fn_moduleAirResupply: check point 5 trigger %1",(synchronizedObjects _logic) select {vehicle _x isKindof "EmptyDetector"}];
	{
		diag_log format["fn_moduleAirResupply: check point 5"];
		diag_log format["fn_moduleAirResupply: params side %1,class %2, drop %3, start %4, wp %5, wp# %6, trigger %7",_aircraftSide,_aircraftClass,_dropClasses,_startPosition,_waypoints,_dropWP,_x];
		[_aircraftSide,_aircraftClass,_dropClasses,_startPosition,_waypoints,_dropWP,_x,_flyHeight,_chuteClass] spawn fen_fnc_airResupply;
	} forEach ((synchronizedObjects _logic) select {vehicle _x isKindof "EmptyDetector"});
	
	[group _x] call fen_fnc_dltGroup;
	
} forEach ((synchronizedObjects _logic) select {vehicle _x isKindof "Air"});

/*
below will get type
typeOf vehicle(synchronizedObjects module1 select 0)
will get if air craft
typeOf vehicle(synchronizedObjects module1 select 0) isKindOf "Air"
will detect if trigger
typeOf vehicle(synchronizedObjects module1 select 1) isKindOf "EmptyDetector"
will return aircraft
(synchronizedObjects module1) select {vehicle _x isKindof "Air"}
will return triggers
(synchronizedObjects module1) select {vehicle _x isKindof "EmptyDetector"}
*/