/*

File: fn_locationQueueHandler.sqf
Author: Fen

Description:
Processes locations in location queue

Parameters:
none

*/

while {fen_ais_locationQueueHandlerRunning} do {

	//sleep 2;
	sleep (missionNamespace getVariable["fen_ais_locationSpawnFrequency",2]);
	{

		private _location=_x;
		private _locationTriggered=false;

		private _triggeredByAI=_location getVariable ["fen_ais_byAI",false];

		private _locationQueueTrigger=_location getVariable "fen_ais_locationQueueTrigger";

		if (_triggeredByAI) then {
			private _enemySides=_location getVariable ["fen_ais_enemy",[west]];
			if ({alive _x and side _x in _enemySides} count (list _locationQueueTrigger)>0) then {
				_locationTriggered=true;
			};
		} else {
			if ({alive _x and isPlayer _x} count (list _locationQueueTrigger)>0) then {
				_locationTriggered=true;
			};
		};

		if not(_locationTriggered) then {
			{
				if not (_x isKindOf "Man") then {
					{
						if (isPlayer _x) exitWith {
							_locationTriggered=true;
						};
					} forEach (crew (vehicle _x));
				};
			} forEach (list _locationQueueTrigger);
		};

		if not (_locationTriggered) then {
				if not(typeName (_location getVariable ["fen_ais_trigger",""])=="STRING") then {
					if (triggerActivated (_location getVariable "fen_ais_trigger")) then {
						_locationTriggered=true;
					};
				};
		};

		if (_locationTriggered) then {

			{
				[_x,_location] call fenAIS_fnc_spawnVehicle;
				sleep (missionNamespace getVariable["fen_ais_smoothSpawnVehicles",0.03]);
			} forEach (_location getVariable ["fen_ais_vehicleArray",[]]);

			{
				[_x,_location] call fenAIS_fnc_spawnGroup;
				sleep (missionNamespace getVariable["fen_ais_smoothSpawnGroups",0.03]);
			} forEach (_location getVariable ["fen_ais_groupArray",[]]);

			if (_location getVariable ["fen_ais_script",""]!="") then {
				[_location] execVM (_location getVariable "fen_ais_script");
			};

			_location setVariable ["fen_ais_locationTriggered",true];
			_location setVariable ["fen_ais_skipLocationBalancing",true];

			deleteVehicle _locationQueueTrigger;

			[_location] call fenAIS_fnc_locationQueueRemove;

			if ((_location getVariable ["fen_ais_allowDespawn",false])) then {
				[_location] spawn fenAIS_fnc_despawnQueueAdd;
			};
		};
	} forEach fen_ais_locationQueue;

	if (count fen_ais_locationQueue==0) then {
		fen_ais_locationQueueHandlerRunning=false;
	};
};
