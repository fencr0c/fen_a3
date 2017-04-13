/*

File: fn_cntOwnedUnts.sqf
Author: Fen 

Description:
Returns number of units owned by passed string
Note AIS, and fen_fnc_spawnGroup both can be used to record the owned by value. 
This function can be used to return the number of units owned by a value still alive.

Parameters:
_this select 0 : (Array) owned values to search for units
_this select 1 : OPTIONAL (Array) consisting of position and radius from position to search

Returns:
Number of units alive.

Example:
_cntUnits=[["LOC1","LOC2"],[[1000,1000],500]] call fen_fnc_cntOwnedUnts

*/

private ["_untCnt","_ownVal","_ownVls","_cntByL","_cntDta","_cntLoc","_cntDst"];

_ownVls=param[0,[],[[]]];
_cntDta=param[1,[],[[]]];

if (count _cntDta>0) then {
    _cntByL=true;
    _cntDta=_this select 1;
    _cntLoc=_cntDta select 0;
    _cntDst=_cntDta select 1;
} else {
	_cntByL=false;
};

_untCnt=0;
{
    _ownVal=_x;
    {
        if (_cntByL) then {
            if (group _x getVariable "fen_ownedBy"==_ownVal and _x distance _cntLoc<=_cntDst) then {
                _untCnt=_untCnt+1;
            };
        } else {
            if (group _x getVariable "fen_ownedBy"==_ownVal) then {
                _untCnt=_untCnt+1;
            };
        };
    } forEach allUnits;
} forEach _ownVls;

_untCnt;