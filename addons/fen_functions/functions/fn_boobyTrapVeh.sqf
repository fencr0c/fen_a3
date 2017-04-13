/*

File: fn_BoobyTrapVeh.sqf
Author: Fen

Description:
Booby traps a vehicle, for a particular side

Parameters:
_this select 0 : (Object) object to boobytrap
_this select 1 : (Text) explosion class, default is "Sh_82mm_AMOS"
_this select 2 : (Array) min/max delay from trigger to explosion, default is [0,10]
_this select 3 : (Side) side that will trigger IED, default is west

*/

private ["_booObj","_expCls","_booDly","_trgSid","_trgDly","_expObj"];

_booObj=param[0,objNull,[objNull]];
_expCls=param[1,"Sh_82mm_AMOS",[""]];
_booDly=param[2,[0,10],[[]],[2]];
_trgSid=param[3,west,[sideLogic]];

if (isNull _booObj) exitWith {};
if not(local _booObj) exitWith {};

_trgDly=_booDly call BIS_fnc_randomNum;

while {alive _booObj} do {

	sleep 3;
	
	if ({side _x==_trgSid} count (crew _booObj)>0) then {
		
		[[position _booObj,"click"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
		sleep _trgDly;
		
		_expObj=createVehicle[_expCls,position _booObj,[],0,"CAN_COLLIDE"];
		_expObj setVelocity[0,0,-1];
		_booObj setDamage 1;
		
		sleep 10;
		deleteVehicle _expObj;
	};
};
