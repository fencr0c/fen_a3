/*

File: fn_hiddenEnemy.sqf
Author: Fen

Description:
Turns groups into unarmed civilians that will wait until enemy spotted and then arm themselves at nearest ammo crate and switch sides.

Parameters:
_this select 0 : (Group) group
_this select 1 : (Array or String) equip with weapons from classes (Array) or faction (String)
_this select 2 : (Array) of objects group will rearm from
_this select 3 : (Scalar) distance units will travel to rearm objects
_this select 4 : (Scalar) max distance units will wander from initial location
_this select 5 : (Scalar) distance from unit to player to cause rearm

Example:
[group,"RDS_RUS",["ACE_AMMO_CRATE"],200,300,100] spawn fen_fnc_hiddenEnemy

*/

private ["_enmGrp","_rarCls","_rarRad","_civGrp","_strLoc","_strSid","_maxMov","_actRad","_armOpt","_clsArr","_idx","_config"];

_enmGrp=param[0,grpNull,[grpNull]];
_armOpt=param[1,[],[[],""]];
_rarCls=param[2,[],[[]]];
_rarRad=param[3,200,[0]];
_maxMov=param[4,300,[0]];
_actRad=param[5,100,[0]];

if not(local (leader _enmGrp)) exitWith{};

if (isNil "fen_debug") then {
    fen_debug=false;
};

if (typeName _armOpt=="ARRAY") then {
    _clsArr=_armOpt;
} else {
    _clsArr=[];
    _config=configFile>>"CfgVehicles";
    for [{_idx=0},{_idx<count _config},{_idx=_idx+1}] do {
        
        if (isClass (_config select _idx)) then {
            if (configname(_config select _idx) isKindOf "Man" and tolower ([(_config select _idx),"faction","none"] call BIS_fnc_returnConfigEntry)==tolower _armOpt) then {
                //_clsArr set[count _clsArr,configName (_config select _idx)];
				_clsArr pushBack configName (_config select _idx);
            };
        };
    };
};

fen_fnc_hiddenEnemyControl={
        
	private ["_civUnt","_rarCls","_rarRad","_knwPly","_movLoc","_strLoc","_rarLoc","_arrWpn","_arrMag","_clsObj","_enmGrp","_strSid","_civGrp","_endPrc","_maxMov","_priWpn","_muzzle","_actRad","_civCls","_clsArr","_idx","_armObj"];
      
    _civUnt=_this select 0;
    _rarCls=_this select 1;
    _rarRad=_this select 2;
    _maxMov=_this select 3;
    _strSid=_this select 4;
    _strLoc=_this select 5;
    _actRad=_this select 6;
    _clsArr=_this select 7;
        
    _civGrp=group _civUnt;
    _endPrc=false;
       
    while {alive _civUnt and not _endPrc} do {
        scopeName "civLoop";

        sleep 3;
            
        // if dead end 
        if (not alive _civUnt) then {
            breakOut "civLoop";
        };
            
        // check if unit knows about any players
        _knwPly=[];
        {
//			if (_civUnt knowsAbout vehicle _x>0 and vehicle _x isKindOf "Man" and _x distance _civUnt<=_actRad) then {
//			_knwPly pushBack _x;
//            };
			if (vehicle _x isKindOf "Man" and _x distance _civUnt<=_actRad) then {
				if (_civUnt knowsAbout vehicle _x>0) then {
					_knwPly pushBack _x;
				} else {
					if ([objNull,"VIEW",_civUnt] checkVisibility [(eyePos _civUnt),(eyePos _x)]>0) then {
						_knwPlay pushBack _x;
					};
				};
			};
        } forEach ([] call BIS_fnc_listPlayers);
            
        // if no known player generate another random move
        if (count _knwPly==0) then {
                
			_movLoc=[_strLoc,10,_maxMov,4,0,1,0] call BIS_fnc_findSafePos;
			_civUnt forceSpeed 1.4;
			_civUnt domove _movLoc;
			waitUntil {
				sleep 3;
                unitReady _civUnt or not(alive _civUnt);
            };
        } else {
                
            // find nearest places to rearm
            _clsObj=nearestObjects [position _civUnt,_rarCls,_rarRad];
			
            // strip out rearm places with players nearby (within 50m)
            _armObj=[];
            for [{_idx=0},{_idx<count _clsObj},{_idx=_idx+1}] do {
                if ({alive _x and (_x distance (_clsObj select _idx))<50} count ([] call BIS_fnc_listPlayers)==0) then {
					_armObj pushBack (_clsObj select _idx);
                };
            };
			
            // if place to rearm found
            if (count _armObj!=0) then {
                    
				// if dead end 
				if (not alive _civUnt) then {
					breakOut "civLoop";
                };
                    
                // move unit to rearm area
                _civUnt forceSpeed -1;
                _rarLoc=getPos (_armObj select 0);
                _civUnt doMove _rarLoc;
                    
                waitUntil {
                    sleep 3;
                    unitReady _civUnt or not(alive _civUnt);
                };
                    
                // if unit in rearm area
                if (count (nearestObjects [position _civUnt,_rarCls,8])>0) then {
                    
					// get unit to crouch and rearm
                    _civUnt setUnitPos "Middle";
                    dostop _civUnt;
                    sleep 3;
                        
                    // if dead end 
                    if (not alive _civUnt) then {
                        breakOut "civLoop";
                    };
                       
                    // create new enemy group or join existing group
                    if (typeName (group _civUnt getVariable ["fen_hiddenenemy_newgrp",false])=="BOOL") then {
                        _enmGrp=createGroup _strSid;
                        _enmGrp setVariable ["fen_ownedBy",((group _civUnt) getVariable ["fen_ownedBy",""])];
                        group _civUnt setVariable ["fen_hiddenenemy_newgrp",_enmGrp];
                    } else {
                        _enmGrp=group _civUnt getVariable "fen_hiddenenemy_newgrp";
                    };
                        
                    // if dead end 
                    if (not alive _civUnt) then {
                        breakOut "civLoop";
                    };
                        
                    [_civUnt] joinSilent _enmGrp;
                        
                    // delete original civilian group if no units
                    if ({alive _x} count units _civGrp==0) then {
                        deleteGroup _civGrp;
                    };
                        
                    // if dead end 
                    if (not alive _civUnt) then {
                        breakOut "civLoop";
                    };

					// arm unit with standard weapons and magazines
                    _civCls=_clsArr select floor(random (count _clsArr));
                    {
                        if (_x isKindOf "Vest_Base_F" or ("Vest_"+_x) in (getArray (configFile >> "CfgPatches" >> "A3_Weapons_F_Vests" >> "units"))) then {
                            _civUnt addVest _x;
                        };
                    } forEach (getArray(configFile>>"CfgVehicles">>_civCls>>"linkedItems"));
                    _arrWpn=getArray(configFile>>"CfgVehicles">>_civCls>>"weapons");
                    _arrMag=getArray(configFile>>"CfgVehicles">>_civCls>>"magazines");
                    {
                        _civUnt addMagazine _x;
                    } forEach _arrMag;
                    {                            
                        _civUnt addWeapon _x;
                    } forEach _arrWpn;
                        
                    sleep 1;
                    
                    // select weapon 
                    _priWpn=primaryWeapon _civUnt;
                    _civUnt selectweapon _priWpn;
                    _muzzle=getArray(configFile>>"cfgWeapons">>_priWpn>>"muzzles");
                    _civUnt selectWeapon (_muzzle select 0);
                       
                    // reset stance
                    _civUnt setUnitPos "Auto";
                    
                    // reveal known players 
                    {
                        _civUnt reveal [_x,3];
                    } forEach _knwPly;
                    
                    // set behaviour
                    _civUnt setBehaviour "AWARE";
                    _civUnt setCombatMode "RED";
                    if (isNil "fen_ai_aimacc") then {fen_ai_aimacc=0.2};
					_civUnt setSkill ["aimingAccuracy",fen_ai_aimacc];
                        
                    // end 
                    _endPrc=true;
                    sleep 3;
                };
            };
        };
    }; 
};

// save group side and leaders start location
_strSid=side leader _enmGrp;
_strLoc=getPos leader _enmGrp;

if (_strSid==civilian) then {
    _strSid=east;
};

// remove all weapons and items from group
{
    removeAllItems _x;
    removeAllWeapons _x;
    removeBackPack _x;
} forEach units _enmGrp;

// switch groups side to civilian
_civGrp=createGroup civilian;
{
    [_x] joinSilent _civGrp;
    doStop _x;
	_x allowFleeing 0;
} forEach units _enmGrp;
_civGrp setBehaviour "CARELESS";
_civGrp setVariable ["fen_ownedBy",(_enmGrp getVariable ["fen_ownedBy",""])];

// remove the original group
deleteGroup _enmGrp;

// for each unit 
{
    [_x,_rarCls,_rarRad,_maxMov,_strSid,_strLoc,_actRad,_clsArr] spawn fen_fnc_hiddenEnemyControl;
} forEach units _civGrp;

    





