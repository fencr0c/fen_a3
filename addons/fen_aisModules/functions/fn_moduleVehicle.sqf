/*

File: fn_moduleVehicle.sqf
Author: Fen 

Description:
Function for module Vehicle

*/


params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// server only
if not(isServer) exitWith{};

private _command=_logic getVariable ["command",""];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

private _options=[];
if (_command!="") then {
	_options pushBack "exec:";
	_options pushBack _command;
};

{
	if (_owningLocation isEqualTo objNull) then {
		[_x,_options] call fenAIS_fnc_vehicle;
	} else {
		[_x,_options,_owningLocation] call fenAIS_fnc_vehicle;
	};
} forEach _units;
