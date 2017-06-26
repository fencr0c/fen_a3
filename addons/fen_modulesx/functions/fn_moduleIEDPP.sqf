/*

File: fn_moduleIEDPP.sqf
Author: Fen 

Description:
Function for module IEDPP

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// server only
if not(isServer) exitWith {};

private _localunits=_units select {local _x};

private _trgSide=_logic getVariable ["trgSide","WEST"];
private _minRange=_logic getVariable ["minRange",0];
private _maxRange=_logic getVariable ["maxRange",8];
private _minDelay=_logic getVariable ["minDelay",0];
private _maxDelay=_logic getVariable ["maxDelay",5];


[_trgSide,[_minRange,_maxRange],[_minDelay,_maxDelay]] spawn fen_fnc_iedPP;

	