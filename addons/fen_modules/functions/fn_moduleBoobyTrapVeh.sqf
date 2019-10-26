/*

File: fn_moduleBoobyTrapVeh.sqf
Author: Fen 

Description:
Function for module BoobyTrapVeh

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _explosionClass=_logic getVariable ["explosionClass","Sh_82mm_AMOS"];
private _minDelay=_logic getVariable ["minDelay",0];
private _maxDelay=_logic getVariable ["maxDelay",10];
private _trapSide=[_logic getVariable ["trapSide",west]] call BIS_fnc_parseNumber;
if (typeName _trapSide!="SIDE") then {
	_trapSide=west;
};
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
        
        if (str _trapSide=="GUER") then {
            _trapSide="independent";
        };
		
		private _parameters="[%1," + 
				"'" + _explosionClass + "'" + "," +
				"[" + str _minDelay + "," + str _maxDelay + "]," +
				format["%1",_trapSide] +
				"] spawn fen_fnc_boobyTrapVeh;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_vehicle;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_vehicle;
		};
	} else {
		[_x,_explosionClass,[_minDelay,_maxDelay],_trapSide] spawn fen_fnc_boobyTrapVeh;
	};
} forEach _localunits;

	