/*

File: fn_iedObjectTriggered.sqf
Author: Fen

Description:
Handles ied object triggered

Parameters:
_this select 0 : (Object) triggger

*/

params [
  ["_trigger",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _allParameters=_trigger getVariable ["fen_iedObject_allParameters",[]];
private _iedObject=_allParameters select 0;

if not(alive _iedObject) exitWith {
  deleteVehicle _trigger;
};

[[position _iedObject,"click"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
sleep (_allParameters select 4 call BIS_fnc_randomNum);

_explosionObject=createVehicle[(_allParameters select 2),position _trigger,[],0,"CAN_COLLIDE"];
_iedObject setDamage 1;

if (_allParameters select 1) then {
	deleteVehicle _iedObject;
} else {
	_iedObject setVelocity[0,0,20];
};
deleteVehicle _trigger;

private _daisyChainId=_trigger getVariable ["fen_iedObject_daisyChainID",""];
if not(_daisyChainID=="") then {
	[_iedObject,_daisyChainID] spawn {
		{
			if not(_x==(_this select 0)) then {
				if ((_x getVariable["fen_iedObject_daisyChainID",""])==(_this select 1)) then {
					_x setVariable["fen_iedObject_hasTriggeredRemotely",true];
				};
			};
		} forEach ((_this select 0) nearObjects["EmptyDetector",500] select {(_x getVariable["fen_iedObject_daisyChainID",""])==(_this select 1)});
	};
};

sleep 10;
deleteVehicle _explosionObject;
