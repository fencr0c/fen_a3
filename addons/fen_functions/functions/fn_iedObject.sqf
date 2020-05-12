/*

File: fn_iedobject.sqf
Author: Fen

Description:
Makes any object into a proximity based IED

Parameters:
_this select 0 : (Object) object
_this select 1 : (Boolean) delete ied object after trigger
_this select 2 : (String) explosion class
_this select 3 : (Array) min/max range for triggering IED
_this select 4 : (Array) min/max delay from trigger to explosion
_this select 5 : (Side) side that will trigger IED
_this select 6 : (String) daisy chain ID
*/

private ["_iedObj","_expCls","_trgSid","_trgRng","_trgDly","_iedTrg","_iedRng","_iedDly","_iedDlt","_expObj"];

_iedObj=param[0,objNull,[objNull]];
_iedDlt=param[1,false,[true]];
_expCls=param[2,"M_NLAW_AT_F",[""]];
_iedRng=param[3,[1,8],[[]],[2]];
_iedDly=param[4,[0,5],[[]],[2]];
_trgSid=param[5,west,[sidelogic]];
_daisyChainID=param[6,"",[""]];
_triggerManID=param[7,"",[""]];

if (isNull _iedObj) exitWith {};
if not(local _iedObj) exitWith {};

_trgRng=_iedRng call BIS_fnc_randomNum;
_trgDly=_iedDly call BIS_fnc_randomNum;

_iedTrg=createTrigger["EmptyDetector",(position _iedObj)];
_iedTrg setTriggerArea[_trgRng,_trgRng,0,false];
_iedTrg setTriggerActivation[str _trgSid,"PRESENT",false];
_iedTrg setTriggerStatements["this","",""]; // https://feedback.bistudio.com/T124846

_iedObj setVariable["fen_iedObject_daisyChainID",_daisyChainID,true];
_iedObj setVariable["fen_iedObject_triggerManID",_triggerManID,true];
_iedObj setVariable["fen_iedObject_hasTriggeredRemotely",false,true];

sleep 5;
waitUntil{
	sleep 0.03;
	triggerActivated _iedTrg or not(alive _iedObj) or (_iedObj getVariable["fen_iedObject_hasTriggeredRemotely",false]);
};

if not(alive _iedObj) exitWith {
    deleteVehicle _iedTrg;
};

[[position _iedObj,"click"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
sleep _trgDly;

_expObj=createVehicle[_expCls,position _iedObj,[],0,"CAN_COLLIDE"];

_iedObj setDamage 1;

if (_iedDlt) then {
	deleteVehicle _iedObj;
} else {
	_iedObj setVelocity[0,0,20];
};
deleteVehicle _iedTrg;

if not(_daisyChainID=="") then {
	[_iedObj,_daisyChainID] spawn {
		{
			if not(_x==(_this select 0)) then {
				if ((_x getVariable["fen_iedObject_daisyChainID",""])==(_this select 1)) then {
					_x setVariable["fen_iedObject_hasTriggeredRemotely",true];
				};
			};
		} forEach ((allmissionObjects "") select {(_x getVariable ["fen_iedObject_daisyChainID",""])==(_this select 1)});
	};
};

sleep 10;
deleteVehicle _expObj;
