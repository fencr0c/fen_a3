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

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _dropWP=_logic getVariable ["dropWP",0];
private _flyHeight=_logic getVariable ["flyHeight",150];
private _chuteCLass=_logic getVariable ["chuteClass","B_Parachute_02_F"];

{

	private _aircraftSide=side _x;
	private _aircraftClass=typeOf vehicle _x;
	private _dropClasses=[];
	private _startPosition=position _x;
	{
		_dropClasses pushBack (typeOf _x);
		deleteVehicle _x;
	} forEach (synchronizedObjects _x select {not(_x isKindOf "fen_moduleAirResupply")});

	private _waypoints=[];
	for [{_idx=1},{_idx<count(waypoints (group _x))},{_idx=_idx+1}] do {
		_waypoints pushBack (waypointPosition [group _x,_idx]);
	};
	{
		[_aircraftSide,_aircraftClass,_dropClasses,_startPosition,_waypoints,_dropWP,_x,_flyHeight,_chuteClass] spawn fen_fnc_airResupply;
	} forEach ((synchronizedObjects _logic) select {vehicle _x isKindof "EmptyDetector"});
	
	[group _x] call fen_fnc_dltGroup;
	
} forEach ((synchronizedObjects _logic) select {vehicle _x isKindof "Air"});

