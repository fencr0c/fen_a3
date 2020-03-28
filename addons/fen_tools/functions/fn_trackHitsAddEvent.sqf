/*

File: fn_trackHitsAddEvent.sqf
Author: Fen 

Description:
Function for adding event handler to object

*/

params [
    ["_object",objNull,[ObjNull]]
];

if not(hasInterface) exitWith {};

_object addEventHandler ["HitPart", {[_this] spawn fenTools_fnc_trackHitsEvent}];
_object setVariable ["fen_trackHit",true];