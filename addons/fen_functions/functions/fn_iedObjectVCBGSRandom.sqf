/*

File: fn_iedObjectVCBGSRandom.sqf
Author: Fen

Description:
Seeds random VCG GS IEDs around the area passed.

Parameters:
_this select 0 : (Array) area position
_this select 1 : (Array) area size
_this select 2 : (Scalar) area direction
_this select 3 : (Boolean) area is recetangle
_this select 4 : (Scalar) number of IEDs
_this select 5 : (Side) side that will trigger IED
_this select 6 : (Array) min/max range for triggering IED
_this select 7 : (Array) min/max delay from trigger to explosion
_this select 8 : (Scalar) cluster chance
_this select 9 : (Array) min/max delay from trigger to explosion for clusters

*/

params [
  ["_areaPosition",[0,0],[[]],[2,3]],
  ["_areaSize",[100,100],[[]],[2]],
  ["_areaDirection",0,[0]],
  ["_areaIsRectangle",false,[false]],
  ["_numberOfIEDs",10,[0]],
  ["_triggeringSide",west,[sideLogic]],
  ["_triggeringRange",[0,5],[[]],[2]],
  ["_triggeringDelay",[0,5],[[]],[2]],
  ["_clusterChance",10,[0]],
  ["_clusterDelay",[0,120],[[]],[2]],
  ["_blackList",[],[[]]]
];

private _VCBGSClasses=[
  "VCB_IED_Mix_Large_Wire_Ammo",
  "VCB_IED_Mix_Mid_Wire_Ammo",
  "VCB_IED_Mix_Small_Wire_Ammo",
  "VCB_IED_Large_Ammo",
  "VCB_IED_Mid_Ammo",
  "VCB_IED_Small_Ammo",
  "VCB_IED_Large_Wire_Ammo",
  "VCB_IED_Mid_Wire_Ammo",
  "VCB_IED_Small_Wire_Ammo",
  "VCB_IED_Mix_Large_Ammo",
  "VCB_IED_Mix_Mid_Ammo",
  "VCB_IED_Mix_Small_Ammo",
  "VCB_IED_Sand_Large_Ammo",
  "VCB_IED_Sand_Mid_Ammo",
  "VCB_IED_Sand_Small_Ammo",
  "VCB_IED_Sand_Large_Wire_Ammo",
  "VCB_IED_Sand_Mid_Wire_Ammo",
  "VCB_IED_Sand_Small_Wire_Ammo"
];

private _VCBGSExplosionClasses=[
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_NLAW_AT_F",
  "M_Mo_82mm_AT",
  "M_Mo_82mm_AT",
  "M_Mo_82mm_AT",
  "M_Mo_82mm_AT",
  "Bo_Mk82"
];

private _depthRange=[0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.10];

private _trigger=createTrigger["EmptyDetector",_areaPosition];
_trigger setTriggerArea[(_areaSize select 0),(_areaSize select 1),_areaDirection,_areaIsRectangle,50];

private _iedsCreated=0;
while {_iedsCreated<_numberOfIEDS} do {

  private _positionOk=false;
  private _attempts=0;
  private _iedPosition=[0,0,0];
  while {_attempts<100 and not (_positionOk)} do {
    _attempts=_attempts+1;
    _iedPosition=[_trigger] call bis_fnc_randomPosTrigger;
    _positionOk=true;
    {
      if (_iedPosition inArea _x) then {
        _positionOk=false;
      };
    } forEach _blackList;
    if (_positionOk) then {
      _iedPosition=[_iedPosition,0,10,5,0,1,0,[],[]] call BIS_fnc_findSafePos;
    };
  };

  if (_positionOk) then {

    private _limit=1;
    private _daisyChainId="";

    if (([0,100] call BIS_fnc_randomInt)<=_clusterChance) then {
      _doDCCluster=true;
      private _daisyChainNumber=missionNamespace getVariable["fen_iedObjectVCBGSRandomDaisyChainNumber",0];
      _daisyChainNumber=_daisyChainNumber+1;
      missionNamespace setVariable["fen_iedObjectVCBGSRandomDaisyChainNumber",_daisyChainNumber];
      _daisyChainId= format["fn_randomVCBGS_%1",_daisyChainNumber];
      _limit=[3,8] call BIS_fnc_randomInt;
    };

    for "_idx" from 1 to _limit do {

      private _safePosition=_iedPosition;
      if (_limit>1) then {
        _safePosition=[_iedPosition,5,25,5,0,1,0,[],[]] call BIS_fnc_findSafePos;
      };

      private _iedClass=selectRandom _VCBGSClasses;
      private _iedObject=createVehicle [_iedClass,_safePosition,[],0,"CAN_COLLIDE"];
      _iedObject setDir ([0,360] call BIS_fnc_randomInt);
      _iedObject setVectorUp surfaceNormal position _iedObject;
      _iedObject setPos [(getPos _iedObject select 0),(getPos _iedObject select 1),((getPos _iedObject select 2)-(selectRandom _depthRange))];
      private _delay=_triggeringDelay;
      if(_limit>1) then {
        _delay=_clusterDelay;
      };
      [_iedObject,(selectRandom _VCBGSExplosionClasses),_triggeringRange,_delay,_triggeringSide,_daisyChainId] spawn fen_fnc_IEDObjectVCBGSAdd;
    };
  };

  _iedsCreated=_iedsCreated+1;

};

deleteVehicle _trigger;
