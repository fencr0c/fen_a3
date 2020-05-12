/*

File: fn_moduleCivThrowGrenade.sqf
Author: Fen

Description:
Function for module civThrowGrenade

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};


private _sideToEngage=[_logic getVariable ["sideToEngage",west]] call BIS_fnc_parseNumber;
if (typeName _sideToEngage!="SIDE") then {
	_sideToEngage=west;
};
private _proximity=_logic getVariable["proximity",80];
private _evasionProximity=_logic getVariable["evasionProximity",100];
private _evasionMove=_logic getVariable["evasionMove",200];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
	if (_includeAIS) then {
		private _grpOptions=["exec:"];

    if (str _sideToEngage=="GUER") then {
      _sideToEngage="independent";
    };

		private _parameters="[leader %1," +
			format["%1,",_sideToEngage] +
			str _proximity + "," +
			str _evasionProximity + "," +
			str _evasionMove +
			"] spawn fen_fnc_civThrowGrenade;";

		_grpOptions pushBack _parameters;

		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_sideToEngage,_proximity,_evasionProximity,_evasionMove] spawn fen_fnc_civThrowGrenade;
	};
} forEach _localunits;
