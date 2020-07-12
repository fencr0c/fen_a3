/*

File: fn_groupHasTargets.sqf
Author: Fen

Description:
Deletes all waypoints for a group

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

while {count (waypoints _group)>0} do {
  deleteWaypoint ((waypoints _group) select 0);
};
