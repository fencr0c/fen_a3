/*

File: fn_moduleIEDObjectTriggerMan.sqf
Author: Fen

Description:
Function for module IEDObjectTriggerMan

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};


private _trgSide=[_logic getVariable ["trgSide",west]] call BIS_fnc_parseNumber;
if (typeName _trgSide!="SIDE") then {
	_trgSide=west;
};
private _proximity=_logic getVariable["proximity",20];
private _triggerManID=_logic getVariable["triggerManID",""];
private _evasionProximity=_logic getVariable["evasionProximity",75];
private _evasionMove=_logic getVariable["evasionMove",100];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
	if (_includeAIS) then {
		private _grpOptions=["exec:"];

    if (str _trgSide=="GUER") then {
      _trgSide="independent";
    };

		private _parameters="[leader %1," +
			format["%1,",_trgSide] +
			str _proximity + "," +
			"'" + _triggerManID + "'," +
			str _evasionProximity + "," +
			str _evasionMove +
			"] spawn fen_fnc_iedObjectTriggerMan;";

		_grpOptions pushBack _parameters;

		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_trgSide,_proximity,_triggerManID,_evasionProximity,_evasionMove] spawn fen_fnc_iedObjectTriggerMan;
	};
} forEach _localunits;
