/*

File: fn_groupDisembark.sqf
Author: Fen

Description:
Orders group to disembark current vehicles.
Variable against each unit defines original vehicle.

Parameters:
_this select 0 : group

*/

params [
  ["_group",grpNull,[grpNull]]
];

private _crewDisembark=_group getVariable["fen_VIRCrewDisembark",true];
private _vehicle=_group getVariable["fen_VIRVehicle",objNull];

private _stayEmbarked=[];
if not(_crewDisembark) then {
  {
    if (_x==driver _vehicle) then {
      _stayEmbarked pushBackUnique _x;
    };
    if (_x==commander _vehicle) then {
      _stayEmbarked pushBackUnique _x;
    };
    if (_x==gunner _vehicle) then {
      _stayEmbarked pushBackUnique _x;
    };
  } forEach crew _vehicle;
};

{
  if not(_x in _stayEmbarked) then {
    unassignVehicle _x;
    doGetOut _x;
    [_x] allowGetIn false;
  };
} forEach units _group;
