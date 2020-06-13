/*

File: fn_moduleIEDObjectVCBGS.sqf
Author: Fen

Description:
Function for module IEDObjectVCBGS

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _explosionClass=_logic getVariable ["explosionClass","M_NLAW_AT_F"];
private _minRange=_logic getVariable ["minRange",0];
private _maxRange=_logic getVariable ["maxRange",8];
private _minDelay=_logic getVariable ["minDelay",0];
private _maxDelay=_logic getVariable ["maxDelay",5];
private _trgSide=[_logic getVariable ["trgSide",west]] call BIS_fnc_parseNumber;
if (typeName _trgSide!="SIDE") then {
	_trgSide=west;
};
private _daisyChainID=_logic getVariable["daisyChainID",""];
private _triggerManID=_logic getVariable["triggerManID",""];

{
  [_x,_explosionClass,[_minRange,_maxRange],[_minDelay,_maxDelay],_trgSide,_daisyChainID,_triggerManID] spawn fen_fnc_IEDObjectVCBGSAdd;
} forEach _localunits;
