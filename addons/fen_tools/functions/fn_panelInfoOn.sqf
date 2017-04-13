/*

File: fn_panelInfoOn.sqf
Author: Fen 

Description:
Used from addAction to turn on debug panel.

Parameters:
as per addAction

*/

if not(hasInterface) exitWith{};

_actionId=param[2];

player removeAction _actionId;

fen_tools_panelOn=true;

player addAction ["<t color='#FFBF00'>Debug Panel OFF</t>",fenTools_fnc_panelInfoOff];

hint "Debug panel turning ON";
