/*

File: fn_groupGetWaypoints.sqf
Author: Fen

Description:
Returns all waypoints for a group in array

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

_groupWayPoints=[];
{
  _groupWayPoints pushBack [
    waypointPosition _x,
    waypointType _x,
    waypointCombatMode _x,
    waypointFormation _x,
    waypointSpeed _x,
    waypointBehaviour _x,
    waypointCompletionRadius _x,
    waypointTimeout _x,
    waypointStatements _x
  ];
} forEach (waypoints _group);

_groupWayPoints
