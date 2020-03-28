/*

File: fn_VIRInContact.sqf
Author: Fen

Description:
Handles a VIR group in contact

Parameters:
_this select 0 : group
_this select 1 : proximity

*/

params [
  ["_group",grpNull,[grpNull]],
  ["_proximity",500,[0]]
];

private _vehicle=_group getVariable["fen_VIRVehicle",objNull];

[_group] call fen_fnc_groupDoStop;

private _groupCurrentWaypoint=currentWaypoint _group;
private _groupWaypoints=[_group] call fen_fnc_groupGetWaypoints;

[_group] call fen_fnc_groupDeleteWaypoints;

[_group] call fen_fnc_groupDisembark;

_waypoint=_group addWaypoint [position leader _group,100];
_waypoint setWaypointType "GUARD";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointFormation "LINE";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointBehaviour "AWARE";

waitUntil {
  sleep 60;
  (count([leader _group,_proximity] call fen_fnc_neartargets)==0);
};

[_group] call fen_fnc_groupDeleteWaypoints;

[_group,"YELLOW","SAFE"] call fen_fnc_groupSetCombatModeBehaviour;

waitUntil {
  sleep 60;
  ([_group,"SAFE"] call fen_fnc_groupIsBehaviour);
};

if (canMove _vehicle) then {
  [_group] call fen_fnc_groupEmbark;
  waitUntil {
    sleep 15;
    ([_group] call fen_fnc_groupEmbarked);
  };
};

[_group] call fen_fnc_groupDeleteWaypoints;

[_group,_groupCurrentWaypoint,_groupWaypoints] call fen_fnc_groupAddWaypoints;

if ([_group] call fen_fnc_groupAlive) then {
  if (canMove _vehicle) then {
    [_group,(_group getVariable["fen_VIRCrewDisembark",true]),_proximity] call fen_fnc_VIRQueueAdd;
  };
};
