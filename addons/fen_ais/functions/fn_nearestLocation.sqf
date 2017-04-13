/*

File: fn_nearestLocation.sqf
Author: Fen 

Description:
Finds nearest AIS location for a object

Parameters:
_this select 0 :  object (unit or vehicle)

*/

private ["_idx","_fndLoc","_objIdn"];
    
_objIdn=_this select 0;
    
for [{_idx=0},{_idx<(count fen_ais_locations)},{_idx=_idx+1}] do {
	if (isNil "_fndLoc") then {
		_fndLoc=(fen_ais_locations select _idx);
	} else {
		if ((_objIdn distance (fen_ais_locations select _idx))<(_objIdn distance _fndLoc)) then {
			_fndLoc=(fen_ais_locations select _idx);
		};
	};
};
_fndLoc