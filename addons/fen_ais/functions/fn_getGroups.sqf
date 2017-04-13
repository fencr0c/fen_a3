/*

File: fn_getGroups.sqf
Author: Fen 

Description:
Collects AIS groups.

Parameters:
none

*/
	
private ["_assLoc"];
    
{
	if (typeName (_x getVariable ["fen_ais_group",""])!="STRING") then {
		if (typeName (_x getVariable ["fen_ais_groupOwnedBy",false])!="OBJECT") then {
			_assLoc=[(leader _x)] call fenAIS_fnc_nearestLocation;
		} else {
			if ((_x getVariable "fen_ais_groupOwnedBy") in fen_ais_locations) then {
				_assLoc=(_x getVariable "fen_ais_groupOwnedBy");
			} else {
				_assLoc=[(leader _x)] call fenAIS_fnc_nearestLocation;
			};
		};
		if not(isNil "_assLoc") then {
			[_x,_assLoc] call fenAIS_fnc_addGroup;
		};
	};
} forEach allGroups;