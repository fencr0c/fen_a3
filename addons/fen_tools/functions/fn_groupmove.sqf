/*

File: fn_groupMove.sqf
Author: Fen 

Description:
Use to reverse disableAI "MOVE" on units in the players group.

Parameters:
none

*/

{
	_x enableAI "Move";
} forEach (units group player);