/*

File: fn_civilianarea.sqf
Author: Fen 

Description:
Adds area to civilian area queue and starts queue processing if required.

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

private _excludeClasses=[
    "C_Driver_1_F",
    "C_Driver_2_F",
    "C_Driver_3_F",
    "C_Driver_4_F",
    "C_Driver_1_random_base_F",
    "C_Driver_1_black_F",
    "C_Driver_1_blue_F",
    "C_Driver_1_green_F",
    "C_Driver_1_red_F",
    "C_Driver_1_white_F",
    "C_Driver_1_yellow_F",
    "C_Driver_1_orange_F",
    "C_Marshal_F",
    "C_Paramedic_01_base_F",
    "C_Man_Paramedic_01_F",
    "C_Journalist_01_War_F",
    "C_Man_UAV_06_F",
    "C_Man_UAV_06_medical_F",
    "C_man_w_worker_F",
    "C_man_pilot_F",
    "C_scientist_F"
];

if (typename _civOpt=="ARRAY") then {
    _civArr=_civOpt;
} else {
	_civArr=[];
	_config=configFile>>"CfgVehicles";
	for [{_idx=0},{_idx<count _config},{_idx=_idx+1}] do {

		if (isClass (_config select _idx)) then {
			if (conFigName(_config select _idx) isKindOf "Man" and tolower ([(_config select _idx),"faction","none"] call BIS_fnc_returnConfigEntry)==tolower _civOpt and not(configName(_config select _idx) in _excludeClasses)) then {
                _civArr pushBack configName (_config select _idx);
			};
		};
	};
};

_bldPos=[_araLoc,_araRad,_excBld] call fen_fnc_rtnbuildingpos;
_civTrg=createTrigger["EmptyDetector",_araLoc];
_civTrg setTriggerArea[_actRng,_actRng,0,false];
_civTrg setTriggerActivation["ANY","PRESENT",false];
sleep 1;

_civTrg setVariable ["fen_civilianArea_araRad",_araRad];
_civTrg setVariable ["fen_civilianArea_maxCiv",_maxCiv];
_civTrg setVariable ["fen_civilianArea_actSid",_actSid];
_civTrg setVariable ["fen_civilianArea_fpsLmt",_fpsLmt];
_civTrg setVariable ["fen_civilianArea_tlkAra",_tlkArr];
_civTrg setVariable ["fen_civilianArea_bldPos",_bldPos];
_civTrg setVariable ["fen_civilianArea_civArr",_civArr];

if (isNil "fen_civilianAreaQueue") then {
    fen_civilianAreaQueue=[];
};


fen_civilianAreaQueue pushBackUnique _civTrg;

if (isNil "fen_civilianAreaQueueHandlerRunning") then {
    fen_civilianAreaQueueHandlerRunning=false;
};

if not(fen_civilianAreaQueueHandlerRunning) then {
    fen_civilianAreaQueueHandlerRunning=true;
    [] spawn fen_fnc_civilianAreaQueueHandler;
};

