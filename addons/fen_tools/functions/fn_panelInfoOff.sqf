/*

File: fn_panelInforOff.sqf
Author: Fen 

Description:
Used from addAction to turn off debug panel.

Parameters:
as per addAction

*/

_actionId=param[2];

if not(hasInterface) exitWith {};

player removeAction _actionId;

fen_tools_panelOn=false;

player addAction ["<t color='#FFBF00'>Debug Panel ON</t>",fenTools_fnc_panelInfoOn];

hint "Debug Panel turning OFF";