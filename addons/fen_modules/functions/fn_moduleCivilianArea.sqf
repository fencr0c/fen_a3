/*

File: fn_moduleCivilianArea.sqf
Author: Fen 

Description:
Function for module Civilianarea

*/

params [
	["_logic",objNull,[objNull]]
];

// only server
if not(isServer) exitWith {};

private _radius=_logic getVariable ["radius",300];
private _maxCivilians=_logic getVariable ["maxCivilians",10];
private _triggerByWest=_logic getVariable ["triggerByWest",false];
private _triggerByEast=_logic getVariable ["triggerByEast",false];
private _triggerByGuer=_logic getVariable ["triggerByGuer",false];
private _triggerByCiv=_logic getVariable ["triggerByCiv",false];
private _triggerRange=_logic getVariable ["triggerRange",1500];
private _civFaction=_logic getVariable ["civFaction",""];
private _civClasses=[_logic getVariable ["civClasses",[]]] call BIS_fnc_parseNumber;
if (typeName _civClasses!="ARRAY") then {
	_civClasses=[];
};
private _fpsLimiter=_logic getVariable ["fpsLimiter",20];
private _conversations=[_logic getVariable ["conversations",[]]] call BIS_fnc_parseNumber;
if (typeName _conversations!="ARRAY") then {
	_conversations=[];
};
private _excludeBuildings=[_logic getVariable ["excludeBuildings",[]]] call BIS_fnc_parseNumber;
if (typeName _excludeBuildings!="ARRAY") then {
	_excludeBuildings=[];
};

private _triggeredBy=[];
if (_triggerByWest) then {
	_triggeredBy pushBack west;
};
if (_triggerByEast) then {
	_triggeredBy pushBack east;
};
if (_triggerByGuer) then {
	_triggeredBy pushBack independent;
};
if (_triggerByCiv) then {
	_triggeredBy pushBack civilian;
};

private _civData="";
if (count _civClasses==0) then {
	if (_civFaction=="") then {
		_civData="CIV_F";
	} else {
		_civData=_civFaction;
	};
} else {
	_civData=_civClasses;
};

[position _logic,_radius,_maxCivilians,_triggeredBy,_triggerRange,_civData,_fpsLimiter,_conversations,_excludeBuildings] spawn fen_fnc_civilianArea;

	