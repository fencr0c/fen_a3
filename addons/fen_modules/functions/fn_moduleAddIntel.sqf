/*

File: fn_moduleAddIntel.sqf
Author: Fen 

Description:
Function for module AddIntel

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _intel=_logic getVariable ["intel",""];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				"'" + _intel + "'" +
				"] spawn fen_fnc_intel_addIntel;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_vehicle;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_vehicle;
		};
	} else {
		[_x,_intel] spawn fen_fnc_intel_addIntel;
	};
} forEach _localunits;

	