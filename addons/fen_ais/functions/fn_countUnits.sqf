/*

File: fn_countUnits.sqf
Author: Fen 

Description:
Returns number of alive units spawned for a location

Parameters:
_this select 0 : AIS Location

*/

private ["_numUnt","_aisLoc"];
    
_aisLoc=_this select 0;
    
_numUnt=0;
{
	if (alive _x and group _x getVariable "fen_ownedBy"==(str _aisLoc)) then {
	_numUnt=_numUnt+1;
	};
} forEach allUnits;
    
_numUnt