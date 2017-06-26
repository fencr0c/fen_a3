/*

File: fn_moduleGrpSurrender.sqf
Author: Fen 

Description:
Function for module GrpSurrender

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _condition=_logic getVariable ["condition",""];
private _command=_logic getVariable ["command",""];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				"'" + _condition + "'," + 
				"'" + _command + "'" + 
				"] spawn fen_fnc_grpSurrender;";
		
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[group _x,_condition,_command] spawn fen_fnc_grpSurrender;
	};
} forEach _localunits;

	