/*

File: fn_logGetPosASL.sqf
Author: Fen 

Description:
Reports players position ASL to rpt and clipboard. Marker is created where position was grabbed.

Parameters:

*/

private ["_cpyDta","_mrkTxt"];

if not(hasInterface) exitWith {};

if (isNil "fen_aslIdx") then {
    fen_aslIdx=0;
};

_cpyDta=format["%1,%2",getPosASL player,getDir player];
copyToClipboard (str _cpyDta);
diag_log format["getPosASL %1",_cpyDta];

_mrkTxt=format["A%1",fen_aslIdx];
[position Player,_mrkTxt] call fenTools_fnc_debugmarker;

fen_aslIdx=fen_aslIdx+1;