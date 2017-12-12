/*

File: fn_sentryQueueHandler.sqf
Author: Fen 

Description:
Processes groups in sentry queue

Parameters:
none
*/

while {fen_ais_sentryQueueHandlerRunning} do {

	{
		if ({alive _x} count units _x==0) then {
			[_x] call fenAIS_fnc_sentryQueueRemove;
		} else {
		
			private _release=false;
			private _groupData=_x getVariable ["fen_ais_sentryGroupData",[]];
			{
				private _targets=[_x,(_groupData select 0) select 0] call fenAIS_fnc_neartargets;
				If ({not(_x isKindOf "Air")} count _targets>0) then {
					_release=true;
				};
			} forEach units _x;
			
			if ((count units _x<_groupData select 1) and ((_groupData select 0) select 0>0)) then {
				_release=true;
			};
			
            private _releaseByTrigger=false;
            if ((count ((_groupData select 0) select 1)>0) and ((_groupData select 0) select 0>0)) then {  
                {
                    if (triggerActivated _x) then {
                        _release=true;
                        _releaseByTrigger=true;
                    };
                } forEach ((_groupData select 0) select 1);
            };
			if (_release) then {
				{
					_x enableAI "PATH";
					_x setUnitPos "Auto";
				} forEach units _x;
                
                if (_releaseByTrigger) then {
                    private _idx=count (waypoints _x);
                    _x addWaypoint [(position leader _x),0];
                    [_x,_idx] setWaypointType "GUARD";
                    [_x,_idx] setWaypointCombatMode "RED";
                    [_x,_idx] setWaypointSpeed "FULL";
                    [_x,_idx] setWaypointBehaviour "AWARE";
                };
				[_x] call fenAIS_fnc_sentryQueueRemove;
			};
		
		};
		
		sleep 5;
		
	} forEach fen_ais_sentryQueue;
	
	if (count fen_ais_sentryQueue==0) then {
		fen_ais_sentryQueueHandlerRunning=false;
	};
};



