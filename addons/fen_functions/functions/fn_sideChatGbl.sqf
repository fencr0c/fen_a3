/*

File: fn_sideChatGbl.sqf
Author: Fen 

Description:
To use from BIS_FNC_MP for global side chat.

Parameter(s):
_this select 0 : (String) chat text


*/

private ["_chtTxt"];

_chtTxt=param[0,"",[""]];

if (isNil "fen_debug") then {
    fen_debug=false;
};

if not (hasInterface) exitWith {};

player sideChat _chtTxt;
