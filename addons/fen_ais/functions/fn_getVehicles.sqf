/*

File: fn_getVehicles
Author: Fen 

Description:
Collects AIS vehicles

Parameters:
none

*/

private ["_lstVeh","_idx","_assLoc"];
    
_lstVeh=allMissionObjects "";
    
for [{_idx=0},{_idx<count _lstVeh},{_idx=_idx+1}] do {
	if (not((_lstVeh select _idx) isKindOf "Man") and (count (crew (_lstVeh select _idx))==0)) then {
		if (typeName ((_lstVeh select _idx) getVariable ["fen_ais_vehicle",""])!="STRING") then {
			if (damage (_lstVeh select _idx)==0) then {
				if (typeName ((_lstVeh select _idx) getVariable ["fen_ais_vehicleOwnedBy",false])!="OBJECT") then {
					_assLoc=[(_lstVeh select _idx)] call fenAIS_fnc_nearestLocation;
				} else {
					if (((_lstVeh select _idx) getVariable "fen_ais_vehicleOwnedBy") in fen_ais_locations) then {
						_assLoc=((_lstVeh select _idx) getVariable "fen_ais_vehicleOwnedBy");
					} else {
						_assLoc=[(_lstVeh select _idx)] call fenAIS_fnc_nearestLocation;
					};
				};
			};
			if not(isNil "_assLoc") then {
				[(_lstVeh select _idx),_assLoc] call fenAIS_fnc_addVehicle;
			};
		};
	};
};