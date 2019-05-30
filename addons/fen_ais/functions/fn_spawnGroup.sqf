/*

File: fn_spawnGroup.sqf
Author: Fen 

Description:
Spawns AIS Group

Parameters:
_this select 0 : group data array
_this select 1 : AIS location

*/

private ["_grpDta","_aisLoc","_grpMet","_grpWay","_grpOpt","_spnGrp","_spnUnt","_lokDir","_locGrp","_idx","_spnDta"];
    
_grpDta=_this select 0;
_aisLoc=_this select 1;
    
_grpMet=_grpDta select 0;
_grpWay=_grpDta select 1;
_grpOpt=_grpDta select 2;

if ((count _grpMet)==0) exitWith {};
   
if (not("nobalance:" in _grpOpt) and ([_aisLoc] call fenAIS_fnc_balanced)) exitWith{};
  
{
	if (isNil "_spnGrp") then {
		_spnGrp=createGroup (_x select 0);
	};
		
	if (_x select 3 isKindOf "Man") then {

		_spnUnt=_spnGrp createUnit [(_x select 3),[(_x select 1) select 0,(_x select 1) select 1],[],0,"NONE"];
		[_spnUnt] joinSilent _spnGrp;
		//sleep 0.03;
		//waitUntil {unitReady _spnUnt};
		if (isNil "fen_ai_aimacc") then {fen_ai_aimacc=0.2};
        _spnUnt setSkill ["aimingAccuracy",fen_ai_aimacc];
        if ("stop:" in _grpOpt) then {
			doStop _spnUnt;
		};
		_spnUnt setDir (_x select 2);
		_spnUnt setPosASL (_x select 1);
		_lokDir=[position _spnUnt,1000,(_x select 2)] call BIS_fnc_relPos;
		_spnUnt doWatch _lokDir;
		_spnUnt setUnitPos (_x select 4);
		if ("sentry:" in _grpOpt) then {
			//_spnUnt forceSpeed 0;
			_spnUnt disableAI "PATH";
		};
		if not(isNil "fen_removeMagazines") then {
			{
				if (_x in fen_removeMagazines) then {
					_spnUnt removeMagazine _x;
				};
			} forEach (magazines _spnUnt);
		};
		
		if (count (_x select 5)>0) then {
			_spnUnt setUnitLoadOut (_x select 5);
		};
	} else {
    
        private _flying="CAN_COLLIDE";
        if (count _grpWay>0 and (_x select 3) isKindOf "Air") then {
            _flying="FLY";
        };
        private _spnVeh=createVehicle[_x select 3,[((_x select 1) select 0),((_x select 1) select 1)],[],0,_flying];
        _spnVeh setDir (_x select 2);
        _spnVeh setPosASL (_x select 1);
        _spnGrp addVehicle _spnVeh;
        private _spnPos=[((_x select 1) select 0),((_x select 1) select 1)];
        {
            _spnUnt=_spnGrp createUnit[_x select 0,_spnPos,[],0,"NONE"];
            if (count (_x select 4)>0) then {
                _spnUnt setUnitLoadOut (_x select 4);
            };
            switch (_x select 1) do {
                case "driver" : {_spnUnt moveInDriver _spnVeh};
                case "commander" : {_spnUnt moveInCommander _spnVeh};
                case "gunner" : {_spnUnt moveInTurret [_spnVeh,_x select 3]};
                case "turret" : {_spnUnt moveInTurret [_spnVeh,_x select 3]};
                case "cargo" : {_spnUnt moveInCargo [_spnVeh,_x select 2]};
            };
        } forEach (_x select 6);

		if ((count _grpWay)==0) then {
            doStop (commander _spnVeh);
		};

		_lokDir=[position _spnVeh,1000,(_x select 2)] call BIS_fnc_relPos;
		(gunner _spnVeh) doWatch _lokDir;
		
		{
			if ("sentry:" in _grpOpt) then {
				_x disableAI "PATH";
			};
		} forEach (units _spnGrp);
	};

} forEach _grpMet;
    
_spnGrp setVariable ["fen_ownedBy",(str _aisLoc)];
_locGrp=_aisLoc getVariable ["fen_ais_groups",[]];
_locGrp pushBack _spnGrp;
_aisLoc setVariable ["fen_ais_groups",_locGrp];
  
_idx=0;
while {_idx<count _grpOpt} do {
	switch (toLower (_grpOpt select _idx)) do {
		case "exec:" : {
			_idx=_idx+1;
			call compile format[(_grpOpt select _idx),"_spnGrp"];
		};
		case "sentry:" : {
			_idx=_idx+1;
			[_spnGrp,(_grpOpt select _idx)] call fenAIS_fnc_sentryQueueAdd;
		};
		case "combatmode:" : {
			_idx=_idx+1;
			_spnGrp setCombatMode (_grpOpt select _idx);
		};
		case "behaviour:" : {
			_idx=_idx+1;
			_spnGrp setBehaviour (_grpOpt select _idx);
		};
        case "vcom_off:" : {
            _spnGrp setVariable["Vcm_Disable",true,true];
        };
        case "vcom_nopath:" : {
            _spnGrp setVariable["VCM_NORESCUE",true,true];
        };
	};
	_idx=_idx+1;
};

_idx=0;
{
	_idx=_idx+1;
	_spnGrp addWaypoint [(_x select 0),(_x select 6)];
	[_spnGrp,_idx] setWaypointType (_x select 1);
	[_spnGrp,_idx] setWaypointCombatMode (_x select 2);
	[_spnGrp,_idx] setWaypointFormation (_x select 3);
	[_spnGrp,_idx] setWaypointSpeed (_x select 4);
	[_spnGrp,_idx] setWaypointBehaviour (_x select 5);
	[_spnGrp,_idx] setWaypointCompletionRadius (_x select 6);
	[_spnGrp,_idx] setWaypointTimeout (_x select 7);
	[_spnGrp,_idx] setWaypointStatements (_x select 8);
	
	if (count (waypoints _spnGrp)==(_x select 9)) then {
		_spnGrp setCurrentWaypoint [_spnGrp,_idx];
	};
        
} forEach _grpWay;
//if ((count _grpWay)>0) then {
//	_spnGrp setCurrentWaypoint [_spnGrp,1];
//};
    

	
if ((_aisLoc getVariable ["fen_ais_allowDespawn",false])) then {
	if (count _grpOpt==0) then {
		_spnGrp setVariable ["fen_ais_group",true];
	} else {
		_spnGrp setVariable ["fen_ais_group",_grpOpt];
	};
};