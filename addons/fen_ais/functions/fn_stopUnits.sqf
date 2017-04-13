/*

File: fn_stopUnits.sqf
Author: Fen 

Description:
Starts AIS.

Parameters:
none

Pre-requisites:

*/

if (isNil "fen_debug") then {
	fen_debug=false;
};

{
	if (typeName (group _x getVariable ["fen_ais_group",""])!="STRING") then {
		doStop _x;
	};
} forEach allUnits;


