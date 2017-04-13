/*

File: fn_reportGroups.sqf
Author: Fen 

Description:
Writes locations groups to rpt

Parameters:
_this select 0 : AIS Location

*/
    
private ["_aisLoc"];

_aisLoc=_this select 0;
  
diag_log "##################################################################";
diag_log format[" Start AIS Report Groups for %1",str _aisLoc];
diag_log "##################################################################";
    
{
	diag_log format["Group Data %1",_x select 0];
	diag_log format["  Waypoint Data %1",_x select 1];
	diag_log format["  Optional Data %1",_x select 2];
} forEach (_aisLoc getVariable ["fen_ais_groupArray",[]]);
    
diag_log "##################################################################";
diag_log format[" End AIS Report Groups for %1",str _aisLoc];
diag_log "##################################################################";   