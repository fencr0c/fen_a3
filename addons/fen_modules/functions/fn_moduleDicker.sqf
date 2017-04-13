/*

File: fn_moduledicker.sqf
Author: Fen 

Description:
Function for module Dicker

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _passIntel=_logic getVariable ["passIntel",75];
private _updateSides=[_logic getVariable ["updateSides",[west]]] call BIS_fnc_parseNumber;
if (typeName _updateSides!="ARRAY") then {
	_updateSides=[west];
};
private _updateRange=_logic getVariable ["updateRange",1000];
private _frequency=_logic getVariable ["frequency",10];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[leader %1," + 
				str _passIntel + "," +
				format["%1",_updateSides] + "," +
				str _updateRange + "," +
				str _frequency +
				"] spawn fen_fnc_dicker;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_passIntel,_updateSides,_updateRange,_frequency] spawn fen_fnc_dicker;
	};
} forEach _localunits;

	