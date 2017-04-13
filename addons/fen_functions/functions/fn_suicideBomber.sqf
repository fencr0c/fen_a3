/*

File: fn_suicideBomber.sqf
Author: Fen

Description:
Turns civilian unit into a sucide bomber.
They can be on foot or vehicle based.
The bomber can be assigned waypoints or remain static.
When bombe detect player they will move towards them and go boom.

Parameters:
_this select 0 : (Object) unit
_this select 1 : OPTIONAL (Boolean) wearing bomb jacket 

Example:
[_unit,true] spawn fen_fnc_suicideBomber

*/

private ["_suiGrp","_knwAbt","_knwRat","_knwUnt","_bmbShl","_bmbNo1","_bmbNo2","_bmbNo3","_bmbJkt","_suiUnt"];

_suiGrp=_this select 0;
if (count _this>1) then {
    _bmbJkt=_this select 1;
} else {
    _bmbJkt=false;
};

_suiUnt=param[0,objNull,[objNull]];
_bmbJkt=param[1,false,[true]];

if not(local _suiUnt) exitWith{};

if (isNil "fen_debug") then {
    fen_debug=false;
};

_suiGrp=group _suiUnt;
leader _suiGrp allowFleeing 0;
leader _suiGrp setCombatMode "GREEN";
leader _suiGrp setBehaviour "CARELESS";

if (_bmbJkt) then {
    _bmbNo1="ModuleExplosive_DemoCharge_F" createVehicle position (leader _suiGrp);
    _bmbNo1 attachTo [(leader _suiGrp),[0,0.15,0.15],"Pelvis"]; 
    _bmbNo1 setVectorDirAndUp [[1,0,0],[0,1,0]];
    _bmbNo2="ModuleExplosive_DemoCharge_F" createVehicle position (leader _suiGrp);
    _bmbNo2 attachTo [(leader _suiGrp),[-0.1,0.1,0.15],"Pelvis"];  
    _bmbNo2 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];   
    _bmbNo3="ModuleExplosive_DemoCharge_F" createVehicle position (leader _suiGrp);
    _bmbNo3 attachTo [(leader _suiGrp),[0.1,0.1,0.15],"Pelvis"];  
    _bmbNo3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];
};


while {true} do {
    scopeName "suicideControl";
    
    sleep 3;
    if ({alive _x} count units _suiGrp==0) then {
        breakOut "suicideControl";
    };
    
    _knwRat=0;
    _knwUnt="";
    {
        _knwAbt=leader _suiGrp knowsAbout vehicle _x;
        if (vehicle _x!=_x) then {
            if not(vehicle _x isKindOf "Air") then {
                _knwAbt=leader _suiGrp knowsAbout vehicle _x;
            };
        };
        
        if (alive _x and _knwAbt>_knwRat and _knwAbt>0) then {
            _knwRat=_knwAbt;
            _knwUnt=_x;
        };
    } forEach ([] call BIS_fnc_listPlayers);

    if (_knwRat>0) then {
        
        while {true} do {
            scopeName "suicideMove";
            
            if (leader _suiGrp distance _knwUnt<10 and (alive leader _suiGrp)) then {
                if (vehicle (leader _suiGrp)==leader _suiGrp) then {
                    _bmbShl=createVehicle["Sh_82mm_AMOS",position leader _suiGrp,[],0,"CAN_COLLIDE"];
                } else {
                    _bmbShl=createVehicle["Bo_MK82",position leader _suiGrp,[],0,"CAN_COLLIDE"];
                };
				_bmbShl setvelocity [0,0,-30];
                sleep 5;
                deleteVehicle _bmbShl;
                breakOut "suicideMove";
            };
           
            if ({alive _x} count units _suiGrp==0) then {
                breakOut "suicideMove";
            };
            
            if not(alive _knwUnt) then {
                breakOut "suicideMove";
            };
            
            if (leader _suiGrp distance _knwUnt>300) then {
                breakOut "suicideMove";
            };
            
            leader _suiGrp doMove position _knwUnt;
            waitUntil{
                sleep 1;
                unitReady leader _suiGrp or ({alive _x} count units _suiGrp==0 or leader _suiGrp distance _knwUnt<15)
            };
        };
    };
};

if (_bmbJkt) then {
    detach _bmbNo1;
    deleteVehicle _bmbNo1;
    detach _bmbNo2;
    deleteVehicle _bmbNo2;
    detach _bmbNo3;
    deleteVehicle _bmbNo3;
};