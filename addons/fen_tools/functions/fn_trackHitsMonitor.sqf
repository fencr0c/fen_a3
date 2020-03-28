/*

File: fn_trackHitsMonitor.sqf
Author: Fen 

Description:
Function for adding track hits event to all misson objects;

*/

params [
    ["_frequency",5,[0]]
];

if not(hasInterface) exitWith {};

while {true} do {

    {
        if not((_x getVariable ["fen_trackHit",false])) then {
            [_x] spawn fenTools_fnc_trackHitsAddEvent;
        };
    } forEach allMissionObjects "";
    
    sleep _frequency;
};