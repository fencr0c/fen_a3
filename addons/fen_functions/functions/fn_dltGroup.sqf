/*

File: fn_dltGroup.sqf
Author: Fen 

Description:
Immediately removes all units in group and vehicles regardless of units being alive or dead

Parameter(s):
_this select 0 : (Group) group to be deleted

Example:
[_group] call fen_fnc_dltGroup;

*/

private ["_vehIdn","_grpIdn"];

_grpIdn=param[0,grpNull,[grpNull]];

if not(local (leader _grpIdn)) exitWith{};

// delete all units in group
{
    if (vehicle _x!=_x) then {
        _vehIdn=vehicle _x;
        deleteVehicle _vehIdn;
    };
    deleteVehicle _x;
} forEach units _grpIdn;

// delete group
deleteGroup _grpIdn;