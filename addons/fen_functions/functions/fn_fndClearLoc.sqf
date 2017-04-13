/*

File: fn_fndClearLoc.sqf
Author: Fen 

Description:
Returns location that is clear of buildings, trees, etc and of units for specified side.
Use if you want to randomly spawn enemy units away from players.

Parameters:
_this select 0 = (Array) initial location
_this select 1 = (Scalar) maximum raduis from initial location to search, default is 500
_this select 2 = (Array) units of sides which must not be near location, default is [west]
_this select 3 = (Scalar) no units of above sides within x of location, default is 1500
_this select 4 = (Scalar) distance from buildings trees etc, default is 5

Returns:
location
Be warned if location cannot be found location returned will have zero elements
count _location==0

Example:
_location=[[1000,1000],500,[west],1500,5] call fen_fnc_fndClearLoc;

*/

private ["_intLoc","_maxRad","_clrSid","_clrRad","_rtnLoc","_chkLoc","_bldDst"];

_intLoc=param[0,[0,0,0],[[]],[2,3]];
_maxRad=param[1,500,[0]];
_clrSid=param[2,[west],[[]]];
_clrRad=param[3,1500,[0]];
_bldDst=param[4,5,[0]];

fen_fnc_fndClearLoc_unitsClear={
    
    private ["_clrunt","_chkLoc","_clrSid","_clrRad"];

    _chkLoc=_this select 0;
    _clrSid=_this select 1;
    _clrRad=_this select 2;
    
    if ({side _x in _clrSid and (_x distance _chkLoc)<_clrRad} count allUnits==0) then {
        _clrUnt=true;
    } else {
        _clrUnt=false;
    };
    _clrUnt
};

_chkLoc=_intLoc;
_rtnLoc=[];
while {true} do {
    scopeName "clearLoc";
    
    if ([_chkLoc,_clrSid,_clrRad] call fen_fnc_fndClearLoc_unitsClear) then {
        _rtnLoc=_chkLoc;
        breakout "clearLoc";
    };
    
    _chkLoc=[_chkLoc,0,_maxRad,_bldDst,0,1,0] call BIS_fnc_findSafePos;
};

if (_rtnLoc distance _intLoc>_maxRad) then {
    _rtnLoc=[];
};
_rtnLoc;