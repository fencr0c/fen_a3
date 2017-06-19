/*

File: fn_moduleArtilleryLine.sqf
Author: Fen 

Description:
Function for module ArtilleryLine

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _numberShells=_logic getVariable ["numberShells",5];
private _shellSpace=_logic getVariable ["shellSpace",10];
private _shellDelay=_logic getVariable ["shellDelay",1];
private _shellClass=_logic getVariable ["shellClass","Sh_82mm_AMOS"];

[position _logic,direction _logic,_numberShells,_shellSpace,_shellDelay,_shellClass] spawn fen_fnc_artilleryLine;
