/*

File: fn_say3d
Author: Fen 

Description:
Runs Say3D on players within 500m of a position

Parameter(s):
_this select 0 : (Array) position for sound 
_this select 1 : (String) sound to say 

Example:
[[1000,1000],"Mortar"] spawn fen_fnc_say3d;

*/

private ["_sayPos","_saySnd","_dumVeh"];

_sayPos=_this select 0;
_saySnd=_this select 1;

_sayPos=param[0,[0,0,0]];
_saySnd=param[1,"",[""]];

if not(local player) exitWith{};

if (player distance _sayPos>500) exitWith{};

_dumVeh="Land_HelipadEmpty_F" createVehicleLocal _sayPos;
_dumVeh say _saySnd;
sleep 5;
deleteVehicle _dumVeh;
