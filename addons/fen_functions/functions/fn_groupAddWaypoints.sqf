/*

File: fn_groupAddWaypoints.sqf
Author: Fen

Description:
Adds waypoints to group from passed data

Parameters:
_this select 0 : group
_this select 1 : current waypoint
_this select 2 : waypoint data

*/

params [
  ["_group",grpNull,[grpNull]],
  ["_groupCurrentWaypoint",0,[0]],
  ["_groupWaypoints",[],[[]]]
];

for "_i" from _groupCurrentWaypoint to ((count _groupWaypoints)-1) do {
  private _waypointEntry=_groupWaypoints select _i;
  _waypoint=_group addWaypoint [_waypointEntry select 0,0];
  _waypoint setWaypointType (_waypointEntry select 1);
  _waypoint setWaypointCombatMode (_waypointEntry select 2);
  _waypoint setWaypointFormation (_waypointEntry select 3);
  _waypoint setWaypointSpeed (_waypointEntry select 4);
  _waypoint setWaypointBehaviour (_waypointEntry select 5);
  _waypoint setWaypointCompletionRadius (_waypointEntry select 6);
  _waypoint setWaypointTimeout (_waypointEntry select 7);
  _waypoint setWaypointStatements (_waypointEntry select 8);
};
