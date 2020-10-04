/*

File: fn_moduleIEDObjectVCBGSRandom.sqf
Author: Fen

Description:
Function for module IEDObjectVCBGSRandom

*/

params[
  ["_logic",objNull,[objNull]]
];

if (hasInterface and not isServer) exitwith {};

private _iedAreas=synchronizedObjects _logic select {typeOf _x=="ModuleCoverMap_F" or typeOf _x=="EmptyDetector"};

private _numberOfIEDS=_logic getVariable ["numberOfIEDs",100];
private _trgSide=[_logic getVariable ["trgSide",west]] call BIS_fnc_parseNumber;
if (typeName _trgSide!="SIDE") then {
  _trgSide=west;
};
private _minRange=_logic getVariable ["minRange",0];
private _maxRange=_logic getVariable ["maxRange",8];
private _minDelay=_logic getVariable ["minDelay",0];
private _maxDelay=_logic getVariable ["maxDelay",5];
private _clusterChance=_logic getVariable ["clusterChance",10];
private _clusterMinDelay=_logic getVariable ["clusterMinDelay",0];
private _clusterMaxDelay=_logic getVariable ["clusterMaxDelay",5];
private _blackList=[_logic getVariable ["blackList",[]]] call BIS_fnc_parseNumber;
if (typeName _blackList!="ARRAY") then {
  _blackList=[];
};

{
  private _areaPosition=[];
  private _areaSizeA=0;
  private _areaSizeB=0;
  private _areaDirection=0;
  private _areaIsRectangle=true;

  if (typeOf _x=="ModuleCoverMap_F") then {
    _areaPosition=getPos _x;
    private _coverMapObjectArea=_x getVariable ["objectArea",[]];
    _areaSizeA=_coverMapObjectArea select 0;
    _areaSizeB=_coverMapObjectArea select 1;
    _areaDirection=_coverMapObjectArea select 2;
    _areaIsRectangle=true;
  };

  if (typeOf _x=="EmptyDetector") then {
    _areaPosition=getPos _x;
    _areaSizeA=triggerArea _x select 0;
    _areaSizeB=triggerArea _x select 1;
    _areaDirection=triggerArea _x select 2;
    _areaIsRectangle=triggerArea _x select 3;
    deleteVehicle _x;
  };

  if (count _areaPosition>0) then {
    [_areaPosition,[_areaSizeA,_areaSizeB],_areaDirection,_areaIsRectangle,_numberOfIEDS,_trgSide,[_minRange,_maxRange],[_minDelay,_maxDelay],_clusterChance,[_clusterMinDelay,_clusterMaxDelay],_blackList] spawn fen_fnc_iedObjectVCBGSRandom;
  };
} forEach _iedAreas;
