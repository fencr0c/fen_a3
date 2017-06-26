/*

File: fn_moduleHiddenEnemy.sqf
Author: Fen 

Description:
Function for module HiddenEnemy

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _armFaction=_logic getVariable ["armFaction",""];
private _armWeapons=[_logic getVariable ["armWeapons",[]]] call BIS_fnc_parseNumber;
if (typeName _armWeapons!="ARRAY") then {
	_armWeapons=[];
};
private _armFrom=[_logic getVariable ["armFrom",[]]] call BIS_fnc_parseNumber;
if (typeName _armFrom!="ARRAY") then {
	_armFrom=[];
};
private _armDistance=_logic getVariable ["armDistance",200];
private _wanderRadius=_logic getVariable ["wanderRadius",300];
private _proximity=_logic getVariable ["proximity",100];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

_armData="";
if (count _armWeapons==0) then {
	if (_armFaction=="") then {
		_armData="OPF_F";
	} else {
		_armData=_armFaction;
	};
} else {
	_armData=_armWeapons;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1,";
		if (typeName _armData=="STRING") then {
			_parameters=_parameters + "'" + _armData + "'" + ",";
		} else {
			_parameters=_parameters + format["%1",_armData] + ",";
		};
		_parameters=_parameters + 
					format["%1",_armFrom] + "," +
					str _armDistance + "," +
					str _wanderRadius + "," + 
					str _proximity + 
					"] spawn fen_fnc_hiddenEnemy;";
		
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[group _x,_armData,_armFrom,_armDistance,_wanderRadius,_proximity] spawn fen_fnc_hiddenEnemy;
	};
} forEach _localunits;

	