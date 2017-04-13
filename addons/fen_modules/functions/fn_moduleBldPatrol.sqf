/*

File: fn_moduleBldPatrol.sqf
Author: Fen 

Description:
Function for module BldPatrol

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

diag_log format["fn_moduleBldPatrol: units %1",_units]; //debug delete me 

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

diag_log format["fn_moduleBldPatrol: localunits %1",_localunits]; //debug delete me 

private _patrolRadius=_logic getVariable ["patrolRadius",300];
private _excludeBuildings=[_logic getVariable ["excludeBuildings",[]]] call BIS_fnc_parseNumber;
if (typeName _excludeBuildings!="ARRAY") then {
	_excludeBuildings=[];
};
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				str _patrolRadius + "," + 
				format["%1",_excludeBuildings] + 
				"] spawn fen_fnc_bldPatrol;";
		
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[group _x,_patrolRadius,_excludeBuildings] spawn fen_fnc_bldPatrol;
	};
} forEach _localunits;

	