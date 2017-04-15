/*

File: fn_moduleCreateLocation.sqf
Author: Fen 

Description:
Function for module Create Location

*/


params [
	["_logic",objNull,[objNull]]
];

// server only
if not(isServer) exitWith {};

private _radius=_logic getVariable ["radius",1500];
private _script=_logic getVariable ["script",""];
private _trigger=[_logic getVariable ["trigger",""]] call BIS_fnc_parseNumber;
private _despawn=_logic getVariable ["despawn",false];
private _triggerByAIWest=_logic getVariable ["triggerByAIWest",false];
private _triggerByAIEast=_logic getVariable ["triggerByAIEast",false];
private _triggerByAIGuer=_logic getVariable ["triggerByAIGuer",false];
private _triggerBuyAICiv=_logic getVariable ["triggerByAICiv",false];

private _balance=_logic getVariable ["balance",false];
private _maxPlayers=_logic getVariable ["maxPlayers",0];

private _parameters=[];

_parameters pushBack _logic;
_parameters pushBack _radius;

if (_script!="") then {
	_parameters pushBack "script:";
	_parameters pushBack _script;
};
if (typeName _trigger=="OBJECT") then {
	_parameters pushBack "trigger:";
	_parameters pushBack _trigger;
};
if (_despawn) then {
	_parameters pushBack "despawn:";
	_parameters pushBack true;
};

if (_triggerByAIWest or _triggerByAIEast or _triggerByAIGuer or _triggerBuyAICiv) then {
	
	_parameters pushBack "ai:";
	_parameters pushBack true;

	private _sides=[];
	if (_triggerByAIWest) then {
		_sides pushBack west;
	};
	if (_triggerByAIEast) then {
		_sides pushBack east;
	};
	if (_triggerByAIGuer) then {
		_sides pushBack independent;
	};
	if (_triggerBuyAICiv) then {
		_sides pushBack civilian;
	};
	_parameters pushBack "sides:";
	_parameters pushBack _sides;
};
if (_balance) then {
	_parameters pushBack "balance:";
	_parameters pushBack true;
};
if (_maxPlayers!=0) then {
	_parameters pushBack "maxplayers:";
	_parameters pushBack _maxPlayers;
};

_parameters call fenAIS_fnc_createLocation;
