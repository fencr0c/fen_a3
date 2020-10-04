/*

File: fn_formatMapMarkers.sqf
Author: Fen

Description:
My lazy solution to putting coloured compound markers on the map.
Just add a bunch of markers on the compounds with default colour with the marker name formatted as prefix_colour_number.
No need to add text, so you can just copy and paste the markers.
The function will then colour and add text.

Example Marker name:
e.g. "fenCompound_red_1"

Example Usage (from init.sqf):
["fenCompound_"] spawn fenMIS_fnc_mapMarkers;

Parameters:
_this select 0 : (text) marker prefix

*/
params [
  ["_prefix","",[""]]
];

if not(isServer) exitWith {};

private _validColours=[
  "black",
  "grey",
  "red",
  "brown",
  "orange",
  "yellow",
  "khaki",
  "green",
  "blue",
  "pink",
  "white",
  "west",
  "east",
  "guer",
  "civ",
  "blufor",
  "opfor",
  "independent",
  "civilian"
];

{
  private _elements=_x splitString "_";
    if (typeName _elements=="ARRAY") then {
      if ((count _elements)==3) then {
        if ((_elements select 1) in _validColours) then {
          _x setMarkerAlpha 0;
          _x setMarkerColor ("color" + (_elements select 1));
          _x setMarkerText (_elements select 2);
          _x setMarkerSize [0.75,0.75];
          _x setMarkerAlpha 1;
        };
      };
    };
} foreach (allMapMarkers select {((_x find _prefix) >= 0)});
