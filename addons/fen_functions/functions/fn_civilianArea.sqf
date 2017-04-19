/*

File: fn_civilianarea.sqf
Author: Fen 

Description:
Spawns a number of civilians in an area.
Civilians will wander around the area, if buildings are accessible they will move into buildings.
Civilians will continue to spawn/despawn based on players proximity
If array of random conversations is passed, 25% chance of being able to speak with civilian.
Civilians will only spawn in if player of side is within radius.

Parameters:
_this select 0 : (Array) area location
_this select 1 : (Scalar) area radius, default is 300
_this select 2 : (Scalar) max number of civilians, default is 10
_this select 3 : (Array) activated by sides, default is [west]
_this select 4 : (Scalar) activation range, default is 1500
_this select 5 : (Array/String) civilian classes array or faction, default is "CIV_F"
_this select 6 : (Scalar) FPS limit, default is 20
_this select 7 : OPTIONAL (Array) random assigned conversation
_this select 8 : OPTIONAL (Array) Building classes to exclude

Example:
[[1000,1000],300,10,[west],1500,"CIV_F",10,[["Hello","I see your a soldier"],["Go away","I dont want to speak to you"]]] spawn fen_fnc_civilianArea

*/

private ["_araLoc","_araRad","_maxCiv","_actSid","_actRng","_civArr","_fpsLmt","_civTrg","_civGrp","_idx","_civTyp","_spnLoc","_civUnt","_bldPos","_civOpt","_config","_tlkArr","_excBld"];

_araLoc=param[0,[0,0],[[]],[2,3]];
_araRad=param[1,300];
_maxCiv=param[2,10];
_actSid=param[3,[west],[[]]];
_actRng=param[4,1500];
_civOpt=param[5,"CIV_F"];
_fpsLmt=param[6,20];
_tlkArr=param[7,[]];
_excBld=param[8,[],[[]]];

fen_fnc_civilianArea_group={

	private ["_civGrp","_civUnt","_araLoc","_araRad","_movLoc","_bldPos"];
                
    _civGrp=_this select 0;
    _araLoc=_this select 1;
    _araRad=_this select 2;
    _bldPos=_this select 3;
	
	while {{alive _x} count units _civGrp>0} do {
		
		{
			if (alive _x and unitReady _x) then {
				_civUnt=_x;
				group _civUnt setCombatMode "GREEN";
				group _civUnt setBehaviour "SAFE";
				group _civUnt setSpeedMode "LIMITED";
				_civUnt allowFleeing 1;
				doStop _civUnt; 
					
				if not(fleeing _civUnt) then {
					_civUnt forceSpeed 1.4;
					if (count _bldPos<30) then {
						_movLoc=[_araLoc,50,_araRad,4,0,1,0] call BIS_fnc_findSafePos;
					} else {
						_movLoc=_bldPos select floor(random count _bldPos);
					};
					_civUnt domove _movLoc;
				} else {
					_civUnt forceSpeed -1;
					group _civUnt setCombatMode "GREEN";
					group _civUnt setBehaviour "SAFE";
					group _civUnt setSpeedMode "LIMITED";
				};
			};
		} forEach units _civGrp;
		sleep 30;
	};
};

private _excludeClasses=[
	"C_Driver_1_F",
	"C_Driver_2_F",
	"C_Driver_3_F",
	"C_Driver_4_F",
	"C_journalist_F",
	"C_Marshal_F",
	"C_man_pilot_F",
	"C_scientist_F",
	"C_Soldier_VR_F"
];

if (typename _civOpt=="ARRAY") then {
    _civArr=_civOpt;
} else {
	if (isNil "fen_civilianAreaFactionClasses") then {
		_civArr=[];
		_config=configFile>>"CfgVehicles";
		for [{_idx=0},{_idx<count _config},{_idx=_idx+1}] do {
	
			if (isClass (_config select _idx)) then {
				if (configname(_config select _idx) isKindOf "Man" and tolower ([(_config select _idx),"faction","none"] call BIS_fnc_returnConfigEntry)==tolower _civOpt and not(_config select _idx in _excludeClasses)) then {
					_civArr pushBack configName (_config select _idx);
				};
			};
		};
	} else {
		_civArr=fen_civilianAreaFactionClasses;
	};
};

_bldPos=[_araLoc,_araRad,_excBld] call fen_fnc_rtnbuildingpos;
_civTrg=createTrigger["EmptyDetector",_araLoc];
_civTrg setTriggerArea[_actRng,_actRng,0,false];
_civTrg setTriggerActivation["ANY","PRESENT",false];
sleep 1;

while {true} do {
    
    waitUntil {
        sleep 1;
        {alive _x and side _x in _actSid and isPlayer _x} count list _civTrg>0;
    };
    
	_civGrp=createGroup civilian;
	civilian setFriend [west,1];
	civilian setFriend [east,1];
	civilian setFriend [resistance,1];
  
    for [{_idx=1},{_idx<=_maxCiv},{_idx=_idx+1}] do {
        
        sleep 0.03;
        
        if (diag_fps>_fpsLmt) then {
           
            _civTyp=_civArr select floor(random count _civArr);
            _spnLoc=[_araLoc,0,(_araRad/2),1,0,2,0] call BIS_fnc_findSafePos;
            _civUnt=_civGrp createUnit[_civTyp,_spnLoc,[],0,"NONE"];
            removeAllWeapons _civUnt;
            removeAllItems _civUnt;
			
			_civUnt setVariable ["NOAI",1,false];
			_civUnt setVariable ["VCOM_NOPATHING_Unit",1,false];
			_civUnt setVariable ["asr_ai_exclude",true];
			
			if (count _tlkArr>0) then {
				if (ceil(random 100)<=50) then {
					[_civUnt,(selectRandom _tlkArr)] call fen_fnc_civTalk_addConversation;
				};
			};
        };
    };
	
	[_civGrp,_araLoc,_araRad,_bldPos] spawn	fen_fnc_civilianArea_group;
    
    waitUntil {
        sleep 120;
        {alive _x and side _x in _actSid and isPlayer _x} count list _civTrg==0;
    };
    
    {
        if not(_x getVariable ["gbl_arrested",false]) then {
            deleteVehicle _x;
        };
	} forEach units _civGrp;
	
	if (typeName _civGrp=="GROUP") then {
		if ({alive _x} count units _civGrp==0) then {
			deleteGroup _civGrp;
		};
	};
};
