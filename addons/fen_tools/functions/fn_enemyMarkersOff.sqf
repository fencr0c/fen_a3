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
fen_tools_enemyMarkersOn=false;
hint "Turning enemy markers off.";
sleep 10;

player addAction ["<t color='#FFBF00'>Enemy Markers ON</t>",fenTools_fnc_enemyMarkersOn,[],0,false,false,""];