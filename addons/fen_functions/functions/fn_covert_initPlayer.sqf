/*

File: fn_covert_initPlayer.sqf
Author: Fen 

Description:
Used to initialise players when using fn_cover.

Parameters:
none

Instructions:
	add to init.sqf
	[] spawn fen_fnc_covert_initPlayer;
	
*/

if (hasInterface) then {
	[] call fen_fnc_covert_onPlayerRespawn;
};