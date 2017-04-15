/*

File: fn_moduleIEDObject.sqf
Author: Fen 

Description:
Function for module IEDObject

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _removeIED=_logic getVariable ["removeIED",false];
private _explosionClass=_logic getVariable ["explosionClass","M_NLAW_AT_F"];
private _minRange=_logic getVariable ["minRange",0];
private _maxRange=_logic getVariable ["maxRange",8];
private _minDelay=_logic getVariable ["minDelay",0];
private _maxDelay=_logic getVariable ["maxDelay",5];
private _trgSide=[_logic getVariable ["trgSide",west]] call BIS_fnc_parseNumber;
if (typeName _trgSide!="SIDE") then {
	_trgSide=west;
};
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

diag_log format["fn_moduleIEDObject: explosion class is %1",_explosionClass]; // debug delete me 


{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				format["%1",_removeIED] + "," +
				"'" + _explosionClass + "'" + "," +
				"[" + str _minRange + "," + str _maxRange + "]," +
				"[" + str _minDelay + "," + str _maxDelay + "]," +
				str _trgSide +
				"] spawn fen_fnc_iedObject;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_vehicle;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_vehicle;
		};
	} else {
		[_x,_removeIED,_explosionClass,[_minRange,_maxRange],[_minDelay,_maxDelay],_trgSide] spawn fen_fnc_iedObject;
	};
} forEach _localunits;

	