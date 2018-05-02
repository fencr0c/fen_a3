/*

File: fn_moduleShareTargets.sqf
Author: Fen 

Description:
Function for module shareTargets

*/

params [
	["_logic",objNull,[objNull]]
];

// only server
if not(isServer) exitWith {};

private _processWest=_logic getVariable ["processWest",false];
private _processEast=_logic getVariable ["processEast",true];
private _processGuer=_logic getVariable ["processGuer",false];
private _processCiv=_logic getVariable ["processCiv",false];
private _frequency=_logic getVariable ["frequency",60];
private _shareDisance=_logic getVariable ["shareDistance",250];
private _visibleRange=_logic getVariable ["visibleRange",600];


private _processSides=[];
if (_processWest) then {
	_processSides pushBack west;
};
if (_processEast) then {
	_processSides pushBack east;
};
if (_processGuer) then {
	_processSides pushBack independent;
};
if (_processCiv) then {
	_processSides pushBack civilian;
};

[_processSides,_frequency,_shareDisance,_visibleRange] spawn fen_fnc_shareTargets;
