/*

File: fn_moduleRollingBarrage.sqf
Author: Fen 

Description:
Function for module RollingBarrage

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _xAxisShells=_logic getVariable ["xAxisShells",10];
private _xAxisSpace=_logic getVariable ["xAxisSpace",10];
private _xAxisDelay=_logic getVariable ["xAxisDelay",1];
private _yAxisShells=_logic getVariable ["yAxisShells",10];
private _yAxisSpace=_logic getVariable ["yAxisSpace",10];
private _yAxisDelay=_logic getVariable ["yAxisDelay",1];
private _shellClass=_logic getVariable ["shellClass","Sh_82mm_AMOS"];

[position _logic,direction _logic,_xAxisShells,_xAxisSpace,_xAxisDelay,_yAxisShells,_yAxisSpace,_yAxisDelay,_shellClass] spawn fen_fnc_rollingBarrage;

