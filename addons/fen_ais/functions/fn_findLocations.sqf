/*

File: fn_FindLocations.sqf
Author: Fen 

Description:
Finds all AIS locations i.e. game logic location area with ais_location set to scalar.

Returns:
_location

Parameters:
none:

*/

private ["_locations","_gameLogics","_idx"];

_locations=[];
//_gameLogics=allMissionObjects "LocationArea_F";
_gameLogics=allMissionObjects "Logic";
for [{_idx=0},{_idx<count _gameLogics},{_idx=_idx+1}] do {
	if (typeName ((_gameLogics select _idx) getVariable ["fen_ais_location",""])=="SCALAR") then {
		_locations pushBack (_gameLogics select _idx);
	};
};
_locations