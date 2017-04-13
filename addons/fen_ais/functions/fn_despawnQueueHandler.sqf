/*

File: fn_locationsQueueHandler.sqf
Author: Fen 

Description:
Processes locations in location queue

Parameters:
none

*/

if (isNil "fen_debug") then {
	fen_debug=false;
};

while {fen_ais_despawnQueueHandlerRunning} do {

	sleep 300;
	{

		private _location=_x;
		private _locationDespawn=true;
		
		private	_triggeredByAI=_location getVariable ["fen_ais_triggeredByAI",false];

		private _despawnQueueTrigger=_location getVariable "fen_ais_despawnQueueTrigger";

		if (_triggeredByAI) then {
			private _enemySides=_location getVariable ["fen_ais_enemy",[west]];
			if ({alive _x and side _x in _enemySides} count (list _despawnQueueTrigger)>0) then {
				_locationDespawn=false;
			};
		} else {
			if ({alive _x and isPlayer _x} count (list _despawnQueueTrigger)>0) then {
				_locationDespawn=false;
			};
		};

		if (_locationDespawn) then {
			{
				if not (_x isKindOf "Man") then {
					{	
						if (isPlayer _x) exitWith {
							_locationDespawn=false;
						};
					} forEach (crew (vehicle _x));
				};
			} forEach (list _despawnQueueTrigger);
		};
	
		if (_locationDespawn) then {

			private _radius=_location getVariable "fen_ais_location";
			
			_location setVariable ["fen_ais_groupArray",nil];
			_location setVariable ["fen_ais_vehicleArray",nil];
			_location setVariable ["fen_ais_unitCount",nil];
			_location setVariable ["fen_ais_locationTriggered",nil];
	
			{
				if (([_x,(position _location)] call fenAIS_fnc_groupDistance)<=_radius) then {
					[_x] call fenAIS_fnc_sentryQueueRemove;
					[_x,_location] call fenAIS_fnc_addGroup;
					sleep 0.03;
				};
			} forEach (_location getVariable ["fen_ais_groups",[]]);
	
			{
				if (_x distance _location<_radius) then {
					[_x,_location] call fenAIS_fnc_addVehicle;
					sleep 0.03;
				};
			} forEach (_location getVariable ["fen_ais_vehicles",[]]);
	
			_location setVariable ["fen_ais_groups",nil];
			_location setVariable ["fen_ais_vehicles",nil];
	
			if (count (_location getVariable ["fen_ais_groupArray",[]])>0 or count (_location getVariable ["fen_ais_vehicleArray",[]])>0) then {
				[_location] call fenAIS_fnc_locationQueueAdd;
			};
	
			_location setVariable ["fen_ais_locationTriggered",false];
	
			if (fen_debug) then {
				[_location] call fenAIS_fnc_reportVehicles;
				[_location] call fenAIS_fnc_reportGroups;
			};

			[_location] call fenAIS_fnc_despawnQueueRemove;
		};
			
	} forEach fen_ais_despawnQueue;
	
	if (count fen_ais_despawnQueue==0) then {
		fen_ais_despawnQueueHandlerRunning=false;
	};
};



	