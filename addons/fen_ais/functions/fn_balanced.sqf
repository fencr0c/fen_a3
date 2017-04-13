/*

File: fn_balanced.sqf
Author: Fen 

Description:
Balance AI spawned dependant on players connected when location activates.

Parameters:
_this select 0 : AIS location

*/
private ["_aisLoc","_maxPly","_curPly","_tgtUnt","_balncd"];
    
_aisLoc=_this select 0;
    
   
if not(_aisLoc getVariable ["fen_ais_balance",true]) exitWith{};
    
_maxPly=_aisLoc getVariable ["fen_ais_maxPlayers",0];
if (_maxPly==0) then {
	_maxPly=getNumber (missionConfigFile >> "header" >> "maxPlayers");
};

if	(_maxPly==0) then {
	if (isDedicated or (not(isServer) and not(hasInterface))) then {
		_maxPly=count(playableUnits);
	} else {
		_maxPly=count(switchableUnits);
	};
};
  
if (fen_debug) then {
	_curPly=_maxPly;
} else {
	if (isDedicated or (not(isServer) and not(hasInterface))) then {
		_curPly=count(playableUnits);
	} else {
		_curPly=count(switchableUnits);
	};
};
_tgtUnt=(_curPly/_maxPly)*(_aisLoc getVariable ["fen_ais_unitCount",1]);

if ([_aisLoc] call fenAIS_fnc_countUnits>=_tgtUnt) then {
	_balncd=true;
} else {
	_balncd=false;
};
    
_balncd