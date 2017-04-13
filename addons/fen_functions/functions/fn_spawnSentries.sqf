/*

File: fn_spawnSentries.sqf
Author: Fen 

Description:
Spawn AI groups captured by sentrygrabber, see fen_tools

Parameters:
_this select 0 : (Array) array of data captured by sentry grabber
_this select 1 : OPTIONAL (String) owned by value 

Example:
{
  [_x] call fen_fnc_spawnsentries;
} forEach [[
	[east,[11456.5,7530.87,221.001],33.6708,"LOP_US_Soldier_TL",true,true,"Down"],
	[east,[11487.4,7548.79,220.296],313.23,"LOP_US_Soldier_SL",false,true,"Middle"],
	[east,[11460.5,7568.61,221.001],115.15,"LOP_US_Soldier_Medic",false,true,"Middle"],
	[east,[11458.9,7479.73,229.452],269.846,"LOP_US_Soldier_AR",false,true,"Middle"]
]];

Returns:
array of groups spawned
*/

private ["_swtStn","_swtSid","_swtLoc","_swtDir","_swtCls","_newGrp","_swtArr","_swtGrp","_fstGrp","_typMan","_swtUnt","_swtWth","_rtnGps","_spnDta","_spnVeh","_gunWth","_gunUnt","_noMove"];

_swtArr=_this select 0;

if (isNil "fen_ai_skill") then {
    fen_ai_skill=0.1;
};

_fstGrp=true;
_rtnGps=[];
{
    _swtSid=_x select 0;
    _swtLoc=_x select 1;
    _swtDir=_x select 2;
    _swtCls=_x select 3;
    _newGrp=_x select 4;
    _noMove=_x select 5;
    if (count _x>=6) then {
        _swtStn=_x select 6;
    } else {
        _swtStn="Auto";
    };
    
    if (_newGrp or _fstGrp) then {
        _swtGrp=createGroup _swtSid;
        //_rtnGps set[count _rtnGps,_swtGrp];
		_rtnGps pushBack _swtGrp;
        _fstGrp=false;
        if (count _this>0) then {
            _swtGrp setVariable ["fen_ownedBy",_this select 1];
        };
        [_swtGrp,50] spawn fen_fnc_releasesentries;
    };
    
    if (getNumber(configFile >> "CfgVehicles" >> _swtCls >> "isMan")==1) then {
        _typMan=true;
    } else {
        _typMan=false;
    };
    
    if (_typMan) then {
//        _swtUnt=_swtGrp createUnit [_swtCls,_swtLoc,[],0,"NONE"];
		_swtUnt=_swtGrp createUnit [_swtCls,[(_swtLoc select 0),(_swtLoc select 1)],[],0,"NONE"];
		sleep 0.3;
        waitUntil {unitReady _swtUnt};
		_swtUnt setSkill fen_ai_skill;
        doStop _swtUnt;
        _swtUnt setPosAsl _swtLoc;
        _swtUnt setDir _swtDir;
        _swtWth=[position _swtUnt,1000,_swtDir] call BIS_fnc_relPos;
        _swtUnt doWatch _swtWth;
        _swtUnt setUnitPos _swtStn;
        if (_noMove) then {
            //_swtUnt disableAI "Move";
			//_swtUnt forceSpeed 0;
			_swtUnt disableAI "PATH";
        };
    } else {
        _spnDta=[[_swtLoc select 0,_swtLoc select 1],_swtDir,_swtCls,_swtGrp] call BIS_fnc_spawnVehicle;
        _spnVeh=_spnDta select 0 ;
        doStop commander _spnVeh; 
        _gunUnt=gunner _spnVeh;
        _gunWth=[position _swtUnt,1000,_swtDir] call BIS_fnc_relPos;
        _gunUnt doWatch _gunWth;
    };
        
    
} forEach _swtArr;

_rtnGps



