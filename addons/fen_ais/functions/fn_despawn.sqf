/*

File: ais_despawn.sqf
Author: Fen 

Description:
Despawn an AIS location

Parameters:
_this select 0 : AIS location

*/

private ["_aisLoc","_aisRad","_aisEnm","_trgBAI","_aisTrg","_idx","_despawn","_noPlayers","_noVehicles","_noGroups"];

_aisLoc=_this select 0;

if (isNil "fen_debug") then {
	fen_debug=false;
};

_aisRad=_aisLoc getVariable "fen_ais_location";
_aisEnm=_aisLoc getVariable ["fen_ais_enemy",[west]];

_trgBAI=false;
if (typeName(_aisLoc getVariable ["fen_ais_triggeredByAI","STRING"])=="BOOL") then {
	_trgBAI=_aisLoc getVariable "fen_ais_triggeredByAI";
};

_aisTrg=createTrigger ["EmptyDetector",position _aisLoc];
_aisTrg setTriggerArea [_aisRad,_aisRad,0,false];
_aisTrg setTriggerActivation ["ANY","PRESENT",false];

_despawn=false;
while {not _despawn} do {
    sleep 300;
	if (_trgBAI) then {
		if ({alive _x and side _x in _aisEnm} count (list _aisTrg)==0) then {
			_despawn=true;
		};
	} else {
		_noplayers=true;
		_noVehicles=true;
		_noGroups=true;
		if ({alive _x and side _x in _aisEnm and isPlayer _x} count (list _aisTrg)>0) then {
			_noPlayers=false;
		};
		{
			if not(_x isKindOf "Man") then {
				{
					if (isPlayer _x) exitWith {
						_noVehicles=false;
					};
				} forEach (crew (vehicle _x));
			};
		} forEach (list _aisTrg);
	};
/*	
	for [{_idx=0},{_idx<count (_aisLoc getVariable ["fen_ais_groups",[]])},{_idx=_idx+1}] do {
		if ({alive _x} count units (_aisLoc getVariable ["fen_ais_groups",[]] select _idx)>0) then {
			_noGroups=false;
		};
	};
*/
	if (_noPlayers and _noVehicles and _noGroups) then {
		_despawn=true;
	};

};

_aisLoc setVariable ["fen_ais_groupArray",nil];
_aisLoc setVariable ["fen_ais_vehicleArray",nil];
_aisLoc setVariable ["fen_ais_unitCount",nil];
_aisLoc setVariable ["fen_ais_locationTriggered",nil];

{
	if (([_x,(position _aisLoc)] call fenAIS_fnc_groupDistance)<=_aisRad) then {
		[_x] call fenAIS_fnc_sentryQueueRemove;
		[_x,_aisLoc] call fenAIS_fnc_addGroup;
		sleep 0.03;
	};
} forEach (_aisLoc getVariable ["fen_ais_groups",[]]);

{
	if (_x distance _aisLoc<_aisRad) then {
		[_x,_aisLoc] call fenAIS_fnc_addVehicle;
		sleep 0.03;
	};
} forEach (_aisLoc getVariable ["fen_ais_vehicles",[]]);

_aisLoc setVariable ["fen_ais_groups",nil];
_aisLoc setVariable ["fen_ais_vehicles",nil];

if (count (_aisLoc getVariable ["fen_ais_groupArray",[]])>0 or count (_aisLoc getVariable ["fen_ais_vehicleArray",[]])>0) then {
	[_aisLoc] spawn fenAIS_fnc_location;
};

_aisLoc setVariable ["fen_ais_locationTriggered",false];

deleteVehicle _aisTrg;

if (fen_debug) then {
[_aisLoc] call fenAIS_fnc_reportVehicles;
[_aisLoc] call fenAIS_fnc_reportGroups;
};