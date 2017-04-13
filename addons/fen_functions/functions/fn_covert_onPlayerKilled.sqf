/*

File: fn_covert_onPlayerKilled.sqf
Author: Fen 

Description:
Used by fn_covert to handle player respawns

Parameters:
none
*/

if (hasInterface) then {
	player setVariable ["fen_covert_uniform",uniform player];
};