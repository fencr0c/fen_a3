/*

File: fn_iedObjectVCBGSSpawn.sqf
Author: Fen

Description:
Spawns VCB Ground Sign IED Object

Parameters:
_this select 0 : (Array) IED Object VCB Ground Sign Data

*/

params [
    ["_VCBGSData",[],[[]]]
];

private _class=_VCBGSData select 0;
private _position=_VCBGSData select 1;
private _direction=_VCBGSData select 2;
private _pitchBank=_VCBGSData select 3;
private _explosionClass=_VCBGSData select 4;
private _proximityLimits=_VCBGSData select 5;
private _delayLimits=_VCBGSData select 6;
private _triggeringSide=_VCBGSData select 7;
private _daisyChainID=_VCBGSData select 8;
private _triggerManID=_VCBGSData select 9;

private _ied=createVehicle [_class,_position,[],0,"CAN_COLLIDE"];
_ied setPos _position;
_ied setDir _direction;
[_ied,_pitchBank select 0,_pitchBank select 1] call BIS_fnc_setPitchBank;

private _iedObjectVCBGSCache=missionNamespace getVariable ["fen_iedObjectVCBGSCache",[]];
_iedObjectVCBGSCache=_iedObjectVCBGSCache-[_VCBGSData];
missionNamespace setVariable["fen_iedObjectVCBGSCache",_iedObjectVCBGSCache];

private _proximity=_proximityLimits call BIS_fnc_randomNum;

private _allParameters=[
  _ied,
  true,
  _explosionClass,
  _proximityLimits,
  _delayLimits,
  _triggeringSide,
  _daisyChainID,
  _triggerManID
];

_trigger=createTrigger["EmptyDetector",_position];
_trigger setVariable["fen_iedObject_object",_ied,true];
_trigger setVariable["fen_iedObject_allParameters",_allParameters,true];
_trigger setVariable["fen_iedObject_daisyChainID",_daisyChainID,true];
_trigger setVariable["fen_iedObject_triggerManID",_triggerManID,true];
_trigger setVariable["fen_iedObject_hasTriggeredRemotely",false,true];
_trigger setTriggerArea[_proximity,_proximity,0,false,5];
_trigger setTriggerActivation[str _triggeringSide,"PRESENT",false];
_trigger setTriggerStatements["(this or not(alive (thisTrigger getVariable 'fen_iedObject_object')) or (thisTrigger getVariable 'fen_iedObject_hasTriggeredRemotely'))","[thisTrigger] spawn fen_fnc_iedObjectTriggered",""];
