/*

File: fn_spawnVehicle.sqf
Author: Fen 

Description:
Spawns vehicles, can be empty or crewed

Parameters:
_this select 0 : (Side) side of vehicle
_this select 1 : (Array) location to spawn
_this select 2 : (Scalar) spawn radius
_this select 3 : (Scalar) direction 
_this select 4 : (Boolean) locked
_this select 5 : (Boolean) crewed
_this select 6 : (String) vehicle class
_this select 7 : OPTIONAL (String) owned by value

Returns
Array [vehicle id,group id]

Example:
[east,[1000,1000],0,0,false,true,"Tank"] call fen_fnc_spawnVehicle
*/

private ["_spnDta","_spnVeh","_vehLoc","_vehDir","_vehLck","_vehCrw","_vehCls","_vehSid","_ownVal","_vehRad","_spnLoc","_spnGrp"];

_vehSid=param[0,east,[sideLogic]];
_vehLoc=param[1,[0,0,0],[[]],[2,3]];
_vehRad=param[2,0,[0]];
_vehDir=param[3,0,[0]];
_vehLck=param[4,true,[true]];
_vehCrw=param[5,false,[true]];
_vehCls=param[6,"",[""]];
_ownVal=param[7,"",[""]];

if (isNil "fen_debug") then {
    fen_debug=false;
};

_spnLoc=[_vehloc select 0,_vehLoc select 1];

if (_vehCrw) then {
    _spnDta=[_spnLoc,_vehDir,_vehCls,_vehSid] call BIS_fnc_spawnVehicle;
    _spnVeh=_spnDta select 0;
    _spnGrp=_spnDta select 2;
	_spnGrp setFormDir _vehDir;
	_spnVeh setDir _vehDir;
    if (count _this>7) then {
        _spnGrp setVariable ["fen_ownedBy",_ownVal];
    };
} else {
    _spnGrp="";
    _spnVeh=createVehicle [_vehCls,_spnLoc,[],_vehRad,"CAN_COLLIDE"];
	_spnVeh setDir _vehDir;
    _spnVeh setPosASL _vehLoc;
};

if (count _this>7) then {
    _spnVeh setVariable ["fen_ownedBy",_ownVal];
};
_spnVeh lock _vehLck;

[_spnVeh,_spnGrp]

