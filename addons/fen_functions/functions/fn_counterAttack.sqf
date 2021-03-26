/*

File: fn_counterAttack.sqf
Author: Fen

Description:
Generates balannced counter attack on a specified position.
Number of enemy counterattacking is calculated by outnumberment faction i.e. 2 would result in 2 attacker for each defender in the area to be counter attacked.
If no waypoints are defined groups will head directly to counterattack area. If waypoints are defined, last waypoint should be in counterattack area.

Parameters:
_this select 0 : area to be counterattacked (Array) [[x,y],radius]
_this select 1 : counterattack name (String)
_this select 2 : outnumberment factor (Scalar)
_this select 3 : side triggering counter attack (Side)
_this select 4 : spawn area for counterattacking groups (Array) [[x,y,radius]
_this select 5 : reserves pool (Array) [side,[unit classes in group],number of groups]
_this select 6 : waypoints to place to be counterattacked (Array) [[wp position,wp radius,wp type, wp formation,wp combat mode, wp behaviour, wp speed,[condition,statement]]]
_this select 7 : stop spawing if triggering side within x of spawn location
_this select 8 : exclude groups from VCOM_AI (Boolean)

Example Usage:
	if (isServer) then {
		[[[12796.1,16708.9],200],
		"bridge",
		2,
		west,
		[getMarkerPos "mrk_bridge_spawn",500];
		[
			[east,["O_Soldier_SL_F","O_Soldier_F","O_Soldier_LAT_F","O_soldier_M_F","O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_A_F","O_medic_F"],1],
			[east,["O_MBT_02_cannon_F"],1],
			[east,["O_Soldier_SL_F","O_Soldier_F","O_Soldier_LAT_F","O_soldier_M_F","O_Soldier_TL_F","O_Soldier_AR_F","O_Soldier_A_F","O_medic_F"],10]
		],
		[
			[getMarkerPos "mrk_wp1",500,"MOVE","LINE","RED","AWARE","FULL"],
			[getMarkerPos "mrk_wp2",300,"MOVE","LINE","RED","AWARE","FULL"],
			[getMarkerPos "mrk_wp3",300,"MOVE","LINE","RED","COMBAT","FULL"],
			[getMarkerPos "mrk_wp4",200,"HOLD","LINE","RED","COMBAT","FULL"]
		],
		500] spawn fen_fnc_counterAttack;
	};

*/

params[
	["_counterAttackArea",[[0,0],300],[[]]],
	["_counterAttackName","",[""]],
	["_outnumberment",1,[0]],
	["_triggeringSide",west,[sideLogic]],
	["_spawnArea",[[0,0],300],[[]]],
	["_reservesPool",[],[[]]],
	["_wayPointData",[],[[]]],
	["_stopSpawnProximity",1500,[0]],
	["_noVCOM",false,[true]]
];

if (isNil "fen_debug") then {
	fen_debug=false;
};

if (fen_debug) then {

	if (isNil "fen_counterAttack_debugCounter") then {
		fen_counterAttack_debugCounter=0;
	};

	fen_counterAttack_debugCounter=fen_counterAttack_debugCounter+1;
	private _markerName=_counterAttackName+str fen_counterAttack_debugCounter;
	createMarker [_markerName,_counterAttackArea select 0];
	_markerName setMarkerShape "ELLIPSE";
	_markerName setMarkerSize [_counterAttackArea select 1,_counterAttackArea select 1];
	_markerName setMarkerColor "ColorYellow";

	fen_counterAttack_debugCounter=fen_counterAttack_debugCounter+1;
	_markerName=_counterAttackName+"spawn"+str fen_counterAttack_debugCounter;
	createMarker [_markerName,_spawnArea select 0];
	_markerName setMarkerShape "ELLIPSE";
	_markerName setMarkerSize [_spawnArea select 1,_spawnArea select 1];
	_markerName setMarkerColor "ColorOrange";

	private _wpCounter=0;
	{
		fen_counterAttack_debugCounter=fen_counterAttack_debugCounter+1;
		_wpCounter=_wpCounter+1;
		_markerName=_counterAttackName+"wp"+str fen_counterAttack_debugCounter;
		createMarker [_markerName,_x select 0];
		_markerName setMarkerType "mil_dot";
		_markerName setMarkerColor "ColorYellow";
		_markerName setMarkerText (_counterAttackName+" WP"+str _wpCounter);
	} forEach _wayPointData;
};

private _endCounterAttack=false;
while {not _endCounterAttack} do {

	if (count (allUnits select {side _x==_triggeringSide and _x distance (_spawnArea select 0)<=(_spawnArea select 1)+_stopSpawnProximity})>0) exitWith {
		if (fen_debug) then {
			diag_log format["fn_counterAttack: %1 %2 Ending triggering side near spawn area",time,_counterAttackName];
		};
	};

	_reserveGroupsAvailable=0;
	{
		_reserveGroupsAvailable=_reserveGroupsAvailable+(_x select 2);
	} forEach _reservesPool;
	if (_reserveGroupsAvailable==0) exitWith {
		if (fen_debug) then {
			diag_log format["fn_counterAttack: %1 %2 All reserve groups committed",time,_counterAttackName];
		};
	};

	private _committedUnits=[[_counterAttackName]] call fen_fnc_cntOwnedUnts;
    private _enemyAtArea=count (allUnits select {side _x==_triggeringSide and _x distance (_counterAttackArea select 0)<=(_counterAttackArea select 1)});

	if (fen_debug) then {
		diag_log format["fn_counterAttack: %1 %2 commited %3 enemy in area %4",time,_counterAttackName,_committedUnits,_enemyAtArea];
	};

	if (_enemyAtArea>0) then {

		if (_committedUnits==0 or (_committedUnits/_enemyAtArea)<_outnumberment) then {

			for [{private _idx=0},{_idx<count _reservesPool},{_idx=_idx+1}] do {

				private _reservesData=_reservesPool select _idx;
				private _reservesSide=_reservesData select 0;
				private _reservesClasses=_reservesData select 1;
				private _reservesLeft=_reservesData select 2;

				//if (_reservesLeft>0) then {
				if (_reservesLeft>0) exitWith {

					private _spawnPosition=[(_spawnArea select 0),(_spawnArea select 1),[_triggeringSide],_stopSpawnProximity,10] call fen_fnc_fndClearLoc;
					if (count _spawnPosition>0) then {

            private _spawnPosition2d=[_spawnPosition select 0,_spawnPosition select 1];
						private _spawnedGroup=[_reservesSide,_spawnPosition2d,random(360),_reservesClasses,_counterAttackName] call fen_fnc_spawnGroup;
						if (fen_debug) then {
							diag_log format["fn_counterAttack: %1 %2 spawned group %3",time,_counterAttackName,_spawnedGroup];
						};

						if (_noVCOM) then {
							{
								_x setVariable ["NOAI",true,false];
							} forEach units _spawnedGroup;
						};

						_reservesPool set[_idx,[_reservesSide,_reservesClasses,_reservesLeft-1]];
						if (fen_debug) then {
							{
								diag_log format["fn_counterAttack: %1 %2 reservers pool %3",time,_counterAttackName,_x];
							} forEach _reservesPool;
						};


						if (count _wayPointData==0) then {
							_spawnedGroup addWaypoint [_counterAttackArea select 0, _counterAttackArea select 1];
							[_spawnedGroup,1] setWayPointType "MOVE";
							[_spawnedGroup,1] setWayPointFormation "LINE";
							[_spawnedGroup,1] setWayPointCombatMode "RED";
							[_spawnedGroup,1] setWayPointBehaviour "AWARE";
							[_spawnedGroup,1] setWaypointSpeed "NORMAL";
						} else {
							for [{private _wpIdx=0},{_wpIdx<count _wayPointData},{_wpIdx=_wpIdx+1}] do {
								private _wpData=_wayPointData select _wpIdx;
								_spawnedGroup addWaypoint [_wpData select 0, _wpData select 1];
								[_spawnedGroup,_wpIdx+1] setWayPointType (_wpData select 2);
								[_spawnedGroup,_wpIdx+1] setWayPointFormation (_wpData select 3);
								[_spawnedGroup,_wpIdx+1] setWayPointCombatMode (_wpData select 4);
								[_spawnedGroup,_wpIdx+1] setWayPointBehaviour (_wpData select 5);
								[_spawnedGroup,_wpIdx+1] setWaypointSpeed (_wpData select 6);
								if (count _wpData>=7) then {
									if (typeName (_wpData select 7)=="ARRAY") then {
										[_spawnedGroup,_wpIdx+1] setWaypointStatements [(_wpData select 7) select 0,(_wpData select 7) select 1];
									};
								};
							};
						};
					};
				};
			};
		};
	};
	sleep 20;
};

if (fen_debug) then {
	diag_log format["fn_counterAttack: %1 %2 Ended",time,_counterAttackName];
};
