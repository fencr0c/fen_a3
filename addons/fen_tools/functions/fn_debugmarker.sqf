/*

File: fn_debugMarker.sqf
Author: Fen 

Description:
Used for debugging purposes to simply create a dot type marker.

Parameters:
_this select 0 : (Array) marker position
_this select 1 : (String) marker text

*/

private ["_mrkLoc","_mrkTxt","_mrkNam"];

_mrkLoc=param[0,[0,0,0],[[]],[2,3]];
_mrkTxt=param[1,"",[""]];

if (isNil "fen_debug_mrk") then {
    fen_debug_mrk=1;
};

_mrkNam=format["fen_debug_mrk_%1",fen_debug_mrk];

createMarker [_mrkNam,_mrkLoc];
_mrkNam setMarkerType "mil_dot";
_mrkNam setMarkerColor "ColorYellow";
_mrkNam setMarkerText _mrkTxt;

fen_debug_mrk=fen_debug_mrk+1;
