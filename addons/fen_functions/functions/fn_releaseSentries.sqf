/*

File: fn_releaseSentries.sqf
Author: Fen 

Description:
Used by fen_fnc_spawnSentries, but can be used to release and group from "disableAI "PATH"" when enemy are within range.

Parameters:
_this select 0 : (Group) Group
_this select 1 : (Scalar) Enemy Range

Example:
[_group,150] spawn fen_fnc_releaseSentries

*/

private ["_alwMov","_enmUnt","_relGrp","_tgtRng"];

_relGrp=param[0,grpNull,[grpNull]];
_tgtRng=param[1,50,[0]];

sleep 5;

_alwMov=false;
while {{alive _x} count units _relGrp>0 and not(_alwMov)} do {

    sleep 10;
    
    {
        _enmUnt=[_x,_tgtRng] call fen_fnc_neartargets;
		If ({not(_x isKindOf "Air")} count _enmUnt>0) then {
            _alwMov=true;
        };
    } forEach units _relGrp;

    if (_alwMov) then {
        {
            //_x enableAI "MOVE"
			//_x forceSpeed -1;
			_x enableAI "PATH";
        } forEach units _relGrp;
    };

};
