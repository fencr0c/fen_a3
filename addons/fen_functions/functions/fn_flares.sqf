/*

File: fn_flares.sqf
Author: Fen 

Description:
Generates flares in the sky which float down.

Parameter(s):
_this select 0 : (Array) center location for flares/trigger
_this select 1 : (Scalar) max distance from center flares will be randomly generated, default is 300
_this select 2 : (Scalar) max number of simulatenous flares, default is 10
_this select 3 : (Scalar) frequency of flares, default is 30
_this select 4 : (Scalar) number of times to run, default is 10

Example:
[[1000,1000],300,10,30,10] spawn fen_fnc_flares

*/

private ["_cenLoc","_maxDst","_maxFlr","_flrRnd","_numFlr","_flrX","_flrY","_flrTyp","_frqFlr","_flrShl","_runLen","_cntRun"];

_cenLoc=_this select 0;
_maxDst=_this select 1;
_maxFlr=_this select 2;
_frqFlr=_this select 3;

_cenLoc=param[0,[0,0,0],[[]],[2,3]];
_maxDst=param[1,300,[0]];
_maxFlr=param[2,10,[0]];
_frqFlr=param[3,30,[0]];
_runLen=param[4,10,[0]];

_flrRnd=["F_40mm_White","F_40mm_Yellow","F_40mm_Green","F_40mm_Red"];

_cntRun=0;
while {_cntRun<=_runLen} do {
    
	_cntRun=_cntRun+1;
	
    // lanuch flares
    _numFlr=[(_maxFlr/2),_maxFlr] call BIS_fnc_randomInt;
    for "_idx" from 1 to _numFlr do {
        _flrX=[(_maxDst*-1),_maxDst] call BIS_fnc_randomInt;
        _flrY=[(_maxDst*-1),_maxDst] call BIS_fnc_randomInt;
        _flrTyp=_flrRnd select floor(random count _flrRnd);
        //_flrRnd=createVehicle [_flrTyp,[(_cenLoc select 0)+_flrX,(_cenLoc select 1)+_flrY,100],[],0,"NONE"];
        _flrShl=_flrTyp createVehicle [(_cenLoc select 0)+_flrx,(_cenLoc select 1)+_flrY,150];
        
        _flrShl setvelocity [0,0,-3];
        sleep ([0.3,5] call BIS_fnc_randomInt);
    };
    sleep _frqFlr;
};