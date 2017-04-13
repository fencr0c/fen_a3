/*

File: fn_spawnGroup.sqf
Author: Fen 

Description:
Spawn infantry group.

Parameters:
_this select 0 : (Side) side 
_this select 1 : (Array) location to spawn
_this select 2 : (Scalar) direction to spawn
_this select 3 : (Array) classes in group
_this select 4 : OPTIONAL (String) owned by value

Returns:
Group id

Example:
[east,[1000,1000],0,["soldier1","soldier2"]] call fen_fnc_spawnGroup

*/

private ["_grpSid","_grpLoc","_grpDir","_grpCls","_ownVal","_spnGrp","_l","_vector","_relPos"];

_grpSid=param[0,east,[sideLogic]];
_grpLoc=param[1,[0,0,0],[[]],[2,3]];
_grpDir=param[2,0,[0]];
_grpCls=param[3,[],[[]]];
_ownVal=param[4,"",[""]];

if (isNil "fen_ai_skill") then {
    fen_ai_skill=0.1;
};

_vector=[sin _grpDir, cos _grpDir];
_relPos=[];
for [{_l=0},{_l<count _grpCls},{_l=_l+1}] do {
    //_relPos set[count _relPos,[_vector,10*_l] call BIS_fnc_vectorMultiply];
    _relPos pushBack ([_vector,10*_l] call BIS_fnc_vectorMultiply);
};

_spnGrp=[_grpLoc,_grpSid,_grpCls,_relPos] call BIS_fnc_spawnGroup;
_spnGrp setFormDir _grpDir;
{
    if (vehicle _x==_x) then {
        _x setDir _grpDir;
        _x setPos getPos _x;
    };
    _x setSkill fen_ai_skill;
} forEach units _spnGrp;

if (count _this>4) then {
    _spnGrp setVariable ["fen_ownedBy",_ownVal];
};

_spnGrp;