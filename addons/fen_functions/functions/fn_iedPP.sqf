/*

File: fn_iedPP.sqf
Author: Fen

Description:
Server side script that finds all BIS IED objects placed on map and turns into pressure plate IED's.

Parameters:
_this select 0 : (String) side triggering ied e.g. "WEST" as in trigger activation statement
_this select 1 : (Array) min/max range for triggering ied
_this select 2 : (Array) min/max delay from trigger to explosion

Example:
[west,[0,10],[0,5]] call fen_fnc_iedPP;

*/

private ["_iedArr","_iedObj","_trgSid","_rngArr","_dlyArr"];

_trgSid=param[0,"WEST",[""]];
_rngArr=param[1,[0,10],[[]]];
_dlyArr=param[2,[0,5],[[]]];

if not(isServer) exitWith{};

_iedObj=["IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo"];

_iedArr=[];
{
    _iedArr=_iedArr+([0,0,0] nearObjects [_x,999999]);
} forEach _iedObj;

if (count _iedArr==0) exitWith{};


fen_iedpp_ied={
    
    private ["_iedObj","_trgSid","_rngArr","_dlyArr","_trgRng","_trgDly","_iedTrg","_rndShl"];
    
    _iedObj=_this select 0;
    _trgSid=_this select 1;
    _rngArr=_this select 2;
    _dlyArr=_this select 3;
    
    _trgRng=_rngArr call BIS_fnc_randomNum;
    _trgDly=_dlyArr call BIS_fnc_randomNum;
    
    _iedTrg=createTrigger["EmptyDetector",(position _iedObj)];
    _iedTrg setTriggerArea[_trgRng,_trgRng,0,false];
    _iedTrg setTriggerActivation[_trgSid,"PRESENT",false];
    
    sleep 5;
    waitUntil {
        sleep 0.01;
        triggerActivated _iedTrg;
    };
    
    [[position _iedObj,"click"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
    sleep _trgDly;
    
    _rndShl=createVehicle["Sh_82mm_AMOS",position _iedObj,[],0,"CAN_COLLIDE"];
    _rndShl setvelocity [0,0,-30];
    
    
    deletevehicle _iedObj;
    deleteVehicle _iedTrg;
    sleep 10;
    deleteVehicle _rndShl;
};


{
    [_x,_trgSid,_rngArr,_dlyArr] spawn fen_iedpp_ied;
} forEach _iedArr;

