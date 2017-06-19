/*

File: fn_artilleryFX.sqf
Author: Fen

Description:
Spawns artillery in area around a location, use distance parameter to for making non lethal to players, 75 appears to be safe.

Parameters:
_this select 0 : (Array) location
_this select 1 : (Scalar) minimum distance from location, default is 0
_this select 2 : (Scalar) maximum distance from location , default is 300
_this select 3 : (String) shell to spawn, default "Sh_82mm_AMOS"
_this select 4 : (Scalar) safe distance to spawn shell from units, default is 75
_this select 5 : (Scalar) frequency of fire missions in seconds, default is 60
_this select 6 : (Scalar) number of shells each fire mission, default is 5
_this select 7 : (Scalar) number of times to run, default is 10;

Example:
[[1000,1000],0,300,"Sh_82mm_AMOS",75,60,5,10] spawn fen_fnc_artilleryFX

*/

private ["_artLoc","_artMin","_artMax","_artShl","_artFrq","_artDst","_i","_artNum","_numRun","_cntRun"];

_artLoc=param[0,[0,0,0],[[]],[2,3]];
_artMin=param[1,0,[0]];
_artMax=param[2,300,[0]];
_artShl=param[3,"Sh_82mm_AMOS",[""]];
_artDst=param[4,75,[0]];
_artFrq=param[5,60,[0]];
_artNum=param[6,5,[0]];
_numRun=param[7,10,[0]];

if (isNil "fen_debug") then {
    fen_debug=false;
};

_cntRun=0;
while {_cntRun<=_numRun} do {
    
	_cntRun=_cntRun+1;
	
    for [{_i=1},{_i<_artNum},{_i=_i+1}] do {
        
        [_artLoc,_artMin,_artMax,_artShl,_artDst] spawn {
            
            private ["_l","_locFnd","_rndX","_rndY","_shlLoc","_rndShl","_artLoc","_artMin","_artMax","_artShl","_artDst"];

            _artLoc=_this select 0;
            _artMin=_this select 1;
            _artMax=_this select 2;
            _artShl=_this select 3;
            _artDst=_this select 4;
            
            sleep ([0.00,0.30] call BIS_fnc_randomNum);
            
            _locFnd=false;
            for [{_l=1},{_l<100},{_l=_l+1}] do {
                scopeName "shellLoc";
                _rndX=[(_artMax*-1),_artMax] call BIS_fnc_randomInt;
                _rndY=[(_artMax*-1),_artMax] call BIS_fnc_randomInt;
                _shlLoc=[(_artLoc select 0)+_rndX,(_artLoc select 1)+_rndY];
                if (_shlLoc distance _artLoc>_artMin and {_x distance _shlLoc<_artDst} count allUnits==0) then {
                    _locFnd=true;
                    breakOut "shellLoc";
                };
				sleep 0.3
            };
			
            if (_locFnd) then {
                
                if (ceil random 2>1) then {
                [[_shlLoc,"mortar1"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
                sleep 2;
                };
                
                //_rndShl=_artShl createVehicle _shlLoc;
                _rndShl=createVehicle[_artShl,_shlLoc,[],0,"NONE"];
                _rndShl setvelocity [0,0,-30];
				
                sleep 360;
                deleteVehicle _rndShl;
            };
        };
    };
	
    sleep _artFrq;
	
};
   
    