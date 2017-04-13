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
if not(isServer) exitWith{};

private _radius=_logic getVariable ["radius",1500];
private _script=_logic getVariable ["script",""];
private _trigger=[_logic getVariable ["trigger",""]] call BIS_fnc_parseNumber;
private _despawn=_logic getVariable ["despawn",false];
private _ai=_logic getVariable ["ai",false];
private _sides=[_logic getVariable ["sides",""]] call BIS_fnc_parseNumber;

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
if (_ai) then {
	_parameters pushBack "ai:";
	_parameters pushBack true;
};
if (typeName _sides=="ARRAY") then {
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
