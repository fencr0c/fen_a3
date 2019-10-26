/*

File: fn_moduleScrambleCrew.sqf
Author: Fen 

Description:
Function for module ScrambleCrew

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _crewSide=[_logic getVariable ["crewSide",east]] call BIS_fnc_parseNumber;
if (typeName _crewSide!="SIDE") then {
	_crewSide=east;
};
private _triggerSide=[_logic getVariable ["triggerSide",west]] call BIS_fnc_parseNumber;
if (typeName _triggerSide!="SIDE") then {
	_triggerSide=west;
};
private _range=_logic getVariable ["range",500];
private _fight=_logic getVariable ["fight",true];
private _clutter=[_logic getVariable ["clutter",[]]] call BIS_fnc_parseNumber;
if (typeName _clutter!="ARRAY") then {
	_clutter=[];
};
private _crew=_logic getVariable ["crew",""];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
     
        if (str _crewSide=="GUER") then {
            _crewSide="independent";
        };
        if (str  _triggerSide=="GUER") then {
            _triggerSide="independent";
        };
		private _grpOptions=["exec:"];
		private _parameters="[%1," + 
				format["%1",_crewSide] + "," +
                format["%1",_triggerSide] + "," +
				str _range + "," +
				format["%1",_fight] + "," +
				format["%1",_clutter] + "," +
                "'" + format["%1",_crew] + "'" +
				"] spawn fen_fnc_scrambleCrew;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_vehicle;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_vehicle;
		};
	} else {
		[_x,_crewSide,_triggerSide,_range,_fight,_clutter,_crew] spawn fen_fnc_scrambleCrew;
	};
} forEach _localunits;

	