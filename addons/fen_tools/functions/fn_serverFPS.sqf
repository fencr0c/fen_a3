/*

File: fn_serverFPS.sqf
Author: Fen 

Description:
Updates public variable fen_serverFPS with current FPS every 10 seconds.

Parameters:
none

*/

if not(isServer) exitWith {};

while {true} do {
	sleep 10;
	fen_serverFPS=diag_fps;
	publicVariable "fen_serverFPS";
};
