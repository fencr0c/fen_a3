/*

File: fn_trackRemoveMarker.sqf
Author: Fen 

Description:
Function for removing hit markers

*/

params [
    ["_hitPartMarker",objNull,[objNull]]
];


if not(isServer) exitWith{};

sleep (missionNamespace getVariable["fen_trackHitsLife",30]);
deleteVehicle _hitPartMarker;
