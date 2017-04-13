/*

File: fn_addGroup.sqf
Author: Fen 

Description:
Adds group to AIS locations

Parameters:
_this select 0 : group
_this select 1 : AIS location

*/

private ["_untPos","_untDir","_untCls","_untStn","_grpIdn","_aisLoc","_untLst","_vehLst","_idx","_wayPos","_wayTyp","_wayMod","_wayFrm","_waySpd","_wayBeh","_wayCmp","_wayStm","_wayLst","_untSid","_grpOpt","_locGrp","_wayTim","_wayCur","_lodOut"];
    
_grpIdn=_this select 0;
_aisLoc=_this select 1;

_grpOpt=[];
if (typeName (_grpIdn getVariable ["fen_ais_group",""])=="ARRAY") then {
	{
		_grpOpt pushBack _x;
	} forEach (_grpIdn getVariable "fen_ais_group");
};

_untLst=[];
_vehLst=[];
{
	if (alive _x) then {
		if ((vehicle _x)==_x) then {
			_untSid=[_x] call fenAIS_fnc_factionSides;
			_untPos=getPosASL _x;
			_untDir=getDir _x;
			_untCls=typeOf _x;
			_untStn=unitPos _x;
			_lodOut=[];
			if ("loadout:" in _grpOpt) then {
				_lodOut=getUnitLoadOut _x;
			};
			_untLst pushBack [_untSid,_untPos,_untDir,_untCls,_untStn,_lodOut];

			_aisLoc setVariable ["fen_ais_unitCount",(_aisLoc getVariable ["fen_ais_unitCount",0])+1];
		} else {
			if not((vehicle _x) in _vehLst) then {
				if (typeName (vehicle _x getVariable ["fen_ais_vehicle",""])=="STRING") then {
					_untSid=[_x] call fenAIS_fnc_factionSides;
					_untPos=getPosAsl (vehicle _x);
					_untDir=getDir (vehicle _x);
					_untCls=typeOf (vehicle _x);
					_untLst pushBack [_untSid,_untPos,_untDir,_untCls];
					_vehLst pushBack (vehicle _x);
				} else {
					_untSid=[_x] call fenAIS_fnc_factionSides;
					_untPos=getPosASL _x;
					_untDir=getDir _x;
					_untCls=typeOf _x;
					_untStn=unitPos _x;
					_lodOut=[];
					if ("loadout:" in _grpOpt) then {
						_lodOut=getUnitLoadOut _x;
					};
					_untLst pushBack [_untSid,_untPos,_untDir,_untCls,_untStn,_lodOut];
					_aisLoc setVariable ["fen_ais_unitCount",(_aisLoc getVariable ["fen_ais_unitCount",0])+1];
				};
			};
		};
    };
} forEach (units _grpIdn);
    
_wayLst=[];
for [{_idx=1},{_idx<count(waypoints _grpIdn)},{_idx=_idx+1}] do {
    _wayPos=waypointPosition [_grpIdn,_idx];
    _wayTyp=waypointType [_grpIdn,_idx];
    _wayMod=waypointCombatMode [_grpIdn,_idx];
    _wayFrm=waypointFormation [_grpIdn,_idx];        
    _waySpd=waypointSpeed [_grpIdn,_idx];
    _wayBeh=waypointBehaviour [_grpIdn,_idx];
    _wayCmp=waypointCompletionRadius [_grpIdn,_idx];
    _wayTim=waypointTimeout [_grpIdn,_idx];
    _wayStm=waypointStatements [_grpIdn,_idx];
	_wayCur=currentWaypoint _grpIdn;
	_wayLst pushBack [_wayPos,_wayTyp,_wayMod,_wayFrm,_waySpd,_wayBeh,_wayCmp,_wayTim,_wayStm,_wayCur];
};
  
_locGrp=_aisLoc getVariable ["fen_ais_groupArray",[]];
_locGrp pushBack [_untLst,_wayLst,_grpOpt];
_aisLoc setVariable ["fen_ais_groupArray",_locGrp];
   
{
	if ((vehicle _x)!=_x) then {
		deleteVehicle (vehicle _x);
	};
	deleteVehicle _x;
	if (({alive _x} count (units _grpIdn))==0) then {
		deleteGroup _grpIdn;
	};
} forEach (units _grpIdn);