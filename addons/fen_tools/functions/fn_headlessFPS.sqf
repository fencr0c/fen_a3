/*

File: fn_headlessFPS.sqf
Author: Fen 

Description:
Updates public variable fen_headlessFPS with current FPS every 10 seconds.

Parameters:
none

*/

if (isServer or hasInterface) exitWith {};

while {true} do {
	sleep 10;
	fen_headlessFPS=diag_fps;
	publicVariable "fen_headlessFPS";
};
