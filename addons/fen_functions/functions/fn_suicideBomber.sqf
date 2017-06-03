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

private ["_knwAbt","_knwRat","_knwUnt","_bmbShl","_bmbNo1","_bmbNo2","_bmbNo3","_bmbJkt","_suiUnt"];

_suiUnt=param[0,objNull,[objNull]];
_bmbJkt=param[1,false,[true]];

if not(local _suiUnt) exitWith{};

if (isNil "fen_debug") then {
    fen_debug=false;
};

_suiUnt allowFleeing 0;
_suiUnt setCombatMode "GREEN";
_suiUnt setBehaviour "CARELESS";

if (_bmbJkt) then {
    _bmbNo1="ModuleExplosive_DemoCharge_F" createVehicle position (_suiUnt);
    _bmbNo1 attachTo [(_suiUnt),[0,0.15,0.15],"Pelvis"]; 
    _bmbNo1 setVectorDirAndUp [[1,0,0],[0,1,0]];
    _bmbNo2="ModuleExplosive_DemoCharge_F" createVehicle position (_suiUnt);
    _bmbNo2 attachTo [(_suiUnt),[-0.1,0.1,0.15],"Pelvis"];  
    _bmbNo2 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];   
    _bmbNo3="ModuleExplosive_DemoCharge_F" createVehicle position (_suiUnt);
    _bmbNo3 attachTo [(_suiUnt),[0.1,0.1,0.15],"Pelvis"];  
    _bmbNo3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];
};


while {true} do {
    scopeName "suicideControl";
    
    sleep 3;
    if not(alive _suiUnt) then {
        breakOut "suicideControl";
    };
    
    _knwRat=0;
    _knwUnt="";
    {
//        _knwAbt=leader _suiGrp knowsAbout vehicle _x;
//        if (vehicle _x!=_x) then {
//            if not(vehicle _x isKindOf "Air") then {
//                _knwAbt=leader _suiGrp knowsAbout vehicle _x;
//            };
//        };
		if (_suiUnt distance _x<400) then {
			if not(vehicle _x isKindOf "Air") then {
				_knwAbt=_suiUnt knowsAbout vehicle _x;
				if (_knwAbt>0) then {
					if (alive _x and _knwAbt>_knwRat and _knwAbt>0) then {
						_knwRat=4;
						_knwUnt=_x;
					};
				} else {
					if ([objNull,"VIEW",_suiUnt] checkVisibility [(eyePos _suiUnt),(eyePos _x)]>0) then {
						_knwRat=4;
						_knwUnt=_x;
					};
				};
			};
        };
    } forEach ([] call BIS_fnc_listPlayers);

    if (_knwRat>0) then {
        
        while {true} do {
            scopeName "suicideMove";
            
            if (_suiUnt distance _knwUnt<10 and (alive _suiUnt)) then {
                if (vehicle (_suiUnt)==_suiUnt) then {
                    _bmbShl=createVehicle["Sh_82mm_AMOS",position _suiUnt,[],0,"CAN_COLLIDE"];
                } else {
                    _bmbShl=createVehicle["Bo_MK82",position _suiUnt,[],0,"CAN_COLLIDE"];
                };
				_bmbShl setvelocity [0,0,-30];
                sleep 5;
                deleteVehicle _bmbShl;
                breakOut "suicideMove";
            };
           
            if not(alive _suiUnt) then {
                breakOut "suicideMove";
            };
            
            if not(alive _knwUnt) then {
                breakOut "suicideMove";
            };
            
            if (_suiUnt distance _knwUnt>300) then {
                breakOut "suicideMove";
            };
            
            _suiUnt doMove position _knwUnt;
            waitUntil{
                sleep 1;
                unitReady _suiUnt or not(alive _suiUnt) or (_suiUnt distance _knwUnt<15)
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