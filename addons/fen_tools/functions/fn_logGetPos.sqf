/*

File: fn_logGetPos.sqf
Author: Fen 

Description:
Logs players current position to the rpg file and clipboard

Parameters:
none

*/

private ["_cpyDta"];

if not(hasInterface) exitWith {};

_cpyDta=format["%1,%2",getPos player,getDir player];
copyToClipboard (str _cpyDta);
diag_log format["getPos %1",_cpyDta];


