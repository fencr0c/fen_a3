/*

File: fn_grpStaticPos.sqf
Author: Fen 

Description:
Places units of group into defensive positions

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

private ["_defRad","_grpUnt","_grpLdr","_gunArr","_bldArr","_assWpn","_posArr","_movPos","_idx","_posFnd","_grpDir","_grpPos","_defGrp","_ldrPos","_excBld"];

_defGrp=param[0,grpNull,[grpNull]];
_defRad=param[1,100,[0]];
_excBld=param[2,[],[[]]];

_grpLdr=leader _defGrp;

if not(local _grpLdr) exitWith{};

if not(isnull (_grpLdr findNearestEnemy _grpLdr)) exitWith {};    
if (_grpLdr distance (_grpLdr findNearestEnemy _grpLdr)<_defRad) exitWith{};

_gunArr=nearestObjects[position _grpLdr,["StaticWeapon"],_defRad];
_bldArr=[position _grpLdr,_defRad,_excBld] call fen_fnc_rtnbuildingpos;

_ldrPos=position _grpLdr;
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
            _grpUnt setPos _movPos;    
            doStop _grpUnt;
			
			_grpDir=[_ldrPos,_grpUnt] call BIS_fnc_dirTo;
			_grpPos=[_grpUnt,1000,_grpDir] call BIS_fnc_relPos;
			_grpUnt setDir _grpDir;
			_grpUnt doWatch _grpPos;
            _grpUnt setUnitPos "UP";
			
        };
    };
    
} forEach units _defGrp;