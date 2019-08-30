/*

File: fn_isInsideBuidling.sqf
Author: Fen 

Description:
Tests if unit is inside a building.
Black list of buildings can be passed as a parameter or defined in missionNamespace variable fen_isInsideBuildingBlackList

Parameters:
_this select 0 : (unit) unit to check
_this select 1 : (array) black list of buildings to exclude

Example:
[_unit] call fen_fnc_isInsideBuilding.sqf

*/

params [
    ["_unit",objNull,[objNull]],
    ["_blackList",[],[[]]]
];

private _insideBuilding=false;

private _building=nearestObject[_unit,"HouseBase"];
if (count _blackList==0) then {
    _blackList=missionNamespace getVariable ["fen_isInsideBuildingBlackList",[]];
};

private _type=typeOf _building;
if not(_type in _blackList) then {
    private _relPos=_building worldToModel(getPosATL _unit);
    private _boundingBox=boundingBox _building;
    private _min=_boundingBox select 0;
    private _max=_boundingBox select 1;
    private _myX=_relPos select 0;
    private _myY=_relPos select 1;
    private _myZ=_relPos select 2;

    if ((_myX>(_min select 0))and(_myX<(_max select 0))) then {
        if ((_myY>(_min select 1)) and (_myY<(_max select 1))) then {
            if ((_myZ>(_min select 2)) and (_myZ<(_max select 2))) then {
            _insideBuilding=true;
            };
        };
    };
};
_insideBuilding