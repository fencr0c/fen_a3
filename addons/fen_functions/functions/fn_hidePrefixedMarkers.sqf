/*

File: fn_hidePrefixedMarkers.sqf
Author: Fen

Description:
Hides all markers with passed prefix.


Parameters:
_this select 0 : (text) marker prefix

Example Usage: (from init.sqf)
["fenBlacklist_"] spawn fen_fnc_hidePrefixedMarkers;

*/

params [
  ["_prefix","",[""]]
];

if not(isServer) exitWith {};

{
  _x setMarkerAlpha 0;
} foreach (allMapMarkers select {((_x find _prefix) >= 0)});
