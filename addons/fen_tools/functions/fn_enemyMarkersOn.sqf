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

fen_tools_enemyMarkersOn=true;
[] spawn fenTools_fnc_enemymarkers;
hint "Turning enemy markers on.";
sleep 10;

player addAction ["<t color='#FFBF00'>Enemy Markers OFF</t>",fenTools_fnc_EnemyMarkersOff,[],0,false,false,""];