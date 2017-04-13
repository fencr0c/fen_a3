/*

File: fn_grpDefend.sqf
Author: Fen 

Description:
Assigns group to defensive positions if no known enemy.
Best used in waypoint i.e. move to a position and defend.

Order:
1. Get in empty static weapons
2. Get in nearby buildings

Parameters:
_this select 0 : (Group) group to go defensive
_this select 1 : OPTIONAL (Scalar) radius from group leader to search for statics weapons and buildings, default is 100
_this select 2 : OPTIONAL (Array building classes to exclude

Note:
In debug console, command below to find class of building.
	typeof (nearestBuilding player)

*/

private ["_defRad","_grpUnt","_grpLdr","_gunArr","_bldArr","_assWpn","_posArr","_movPos","_idx","_posFnd","_defGrp","_excBld"];

_defGrp=param[0,grpNull,[grpNull]];
_defRad=param[1,100,[0]];
_excBld=param[2,[],[[]]];

_grpLdr=leader _defGrp;

if not(local _grpLdr) exitWith{};

if not(isnull (_grpLdr findNearestEnemy _grpLdr)) exitWith {};    
if (_grpLdr distance (_grpLdr findNearestEnemy _grpLdr)<_defRad) exitWith{};

_gunArr=nearestObjects[position _grpLdr,["StaticWeapon"],_defRad];
_bldArr=[position _grpLdr,_defRad,_excBld] call fen_fnc_rtnbuildingpos;

{
    _grpUnt=_x;
    _assWpn=false;
    if (_grpUnt!=_grpLdr) then {

        {
            if ((count crew _x==0) and (damage _x <0.1) and not(_assWpn)) then {
                if not(_x getVariable ["fen_grpDefend_assignedCrew",false]) then {
                    _x setVariable ["fen_grpDefend_assignedCrew",true];
                    _grpUnt assignAsGunner _x;
                    [_grpUnt] orderGetIn true;
                    _assWpn=true;
                };
            };
        } forEach _gunArr;
        
    };
    
    if not(_assWpn) then {
        
        _posFnd=false;
        for [{_idx=0},{_idx<(count _bldArr)},{_idx=_idx+1}] do {
            scopeName "findPos";
            _movPos=_bldArr select floor(random (count _bldArr));
            if not(_movPos in (missionNamespace getVariable ["fen_grpDefend_bldPos",[]])) then {
                _posArr=missionNamespace getVariable ["fen_grpDefend_bldPos",[]];
                //_posArr set[(count _posArr),_movPos];
				_posArr pushBack _movPos;
                missionNamespace setVariable ["fen_grpDefend_bldPos",_posArr];
                _posFnd=true;
                breakOut "findPos";
            };
        };
        
        if (_posFnd) then {
            [_grpUnt,_movPos] spawn {
                
                private ["_grpUnt","_movPos"];
                
                _grpUnt=_this select 0;
                _movPos=_this select 1;
                
                doStop _grpUnt;
                _grpUnt doMove _movPos;
				waitUntil {unitReady _grpUnt or not(alive _grpUnt)};
                doStop _grpUnt;
            };
        };
    };
    
} forEach units _defGrp;