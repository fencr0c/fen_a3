/*

File: fn_reportVehicles.sqf
Author: Fen 

Description:
Writes locations vehicles to rpt

Parameters:
_this select 0 : AIS Location

*/

private ["_aisLoc"];
    
_aisLoc=_this select 0;

diag_log "##################################################################";
diag_log format[" Start AIS Report Vehicles for %1",str _aisLoc];
diag_log "##################################################################";
    
{
	diag_log format["Vehicle Data %1",_x select 0];
	diag_log format["  Optional Data %1",_x select 1];
} forEach (_aisLoc getVariable ["fen_ais_vehicleArray",[]]);
    
diag_log "##################################################################";
diag_log format[" End AIS Report Vehicle for %1",str _aisLoc];
diag_log "##################################################################";
    