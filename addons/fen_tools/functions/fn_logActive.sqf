/*

File: fn_logActive.sqf
Author: Fen 

Description:
Reports all active SQF scripts to the rpt file every 10 seconds.

Parameters:
none

*/

private ["_actSqf"];

while {true} do {
	
	_actSqf=diag_activeSQFScripts;
	diag_log format["logactive: Active Sqf %1",count _actSqf];
	{
		diag_log format["logactive: %1",_x];
	} foreach _actSqf;
	
	sleep 10;
	
};