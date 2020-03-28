/*

File: fn_groupEmbark.sqf
Author: Fen

Description:
Orders group to embark on orginal vehicles if it can move.

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

{
  private _vehicle=_group getVariable ["fen_VIRVehicle",objNull];
  if (canMove _vehicle) then {
    _group addVehicle _vehicle;
    {
      [_x] allowGetIn true;
    } forEach units _group;

    private _waypoint=_group addWaypoint [position _Vehicle,0];
    _waypoint setWaypointType "GETIN NEAREST";
    _waypoint setWaypointBehaviour "SAFE";
    _waypoint setWaypointSpeed "NORMAL";
    _waypoint setWaypointCombatMode "YELLOW";
    _waypoint setWaypointFormation "COLUMN";
  };

} forEach (units _group);
