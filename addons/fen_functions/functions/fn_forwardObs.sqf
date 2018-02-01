/*

File: fn_forwardObs.sqf
Author: Fen 

Description:
Allows nominated unit to act as a Forward Observer (Artillery), employing defensive fire plans (DFP) and free target engagement.
In DFP, the FO will employ 3 guns, firing 3 rounds each, when the DFP trigger activates, so long as there are no units friendly to the FO within the trigger.
The FO will only fire once on a DFP trigger.
In free engagement the FO will engage the know target with the highest threat. Once a target as been fixed the FO will start bracketing the target position using 1 gun.
Repeating bracketing will occur until the shell lands near the target position, once the target position has been fixed the FO will issue fire for effect, firing 3 guns 3 rounds each.

Parameters:
_this select 0 : (Unit) defines unit to act as FO
_this select 1 : (Scalar) defines maximum range at which FO will engage targets, default is 1500
_this select 2 : (Array) defines types of artillery FO can used, default is ["O_Mortar_01_F"]
_this select 3 : (Scalar) artillery within this range can be used by FO, default is 2500
_this select 4 : (Scalar) delay between fire missions, default is 120
_this select 4 : (Array) defines array of DFP triggers, default is []
_this select 5 : (Scalar) defines skill level of FO (1,2,3) where 3 is high, default is 2

Example:
[this,2000,["B_Mortar_01_F"],2500,120,[],3] spawn fen_fnc_fowardObs;

*/


params [
	["_foUnit",objNull,[objNull]],
	["_engageRange",1500,[0]],
	["_artilleryTypes",["O_Mortar_01_F"],[[]]],
	["_callingRange",5000,[0]],
	["_delayFireMission",120,[0]],
	["_dfpTriggers",[],[[]]],
	["_skillLevel",2,[0]]
];

if not(local _foUnit) exitWith {};

if (isNil "fen_debug") then {
    fen_debug=false;
};

if (fen_debug) then {
    diag_log format["fn_forwardObs: FO %1 starting",_foUnit];
};
 

fen_fnc_forwardObs_availArtillery={
	
	params ["_foUnit","_artilleryTypes","_callingRange"];
		
	private _availArtillery=[];
	{
		if (count crew _x!=0) then {
            if (unitReady _x) then {
                _availArtillery pushBack _x;
            };
        };
	} forEach ((position _foUnit) nearEntities[_artilleryTypes,_callingRange]);
	
	_availArtillery
};

fen_fnc_forwardObs_dfpClear= {
    
    params ["_foUnit","_target"];
    
    private _clear=false;
    if (count (allUnits select {(position _x inArea _target) and ([side _foUnit, side _x] call BIS_fnc_sideIsFriendly)})==0) then {
        _clear=true;
    };
    
    if (fen_debug) then {
        diag_log format["fn_forwardObs: FO %1 DFP %2 clear %3",_foUnit,_target,_clear];
    };    
    
    _clear
};

fen_fnc_forwardObs_dfpProcess={

	params ["_foUnit","_dfpTriggers","_availArtillery"];
	
	private _dfpUsed=false;
	{
		if (triggerActivated _x and ([_foUnit,_x] call fen_fnc_forwardObs_dfpClear)) exitWith {
            private _target=_x;
            private _fired=0;
			{
                if (unitReady _x) then {
                    _x setVehicleAmmo 1;
                    if ((position _target) inRangeOfArtillery [[_x],(getArtilleryAmmo [_x] select 0)]) then {
                        private _combatMode=combatMode _x;
                        _x setCombatMode "YELLOW";
                        _x doArtilleryFire [(_target call BIS_fnc_randomPosTrigger),(getArtilleryAmmo [_x] select 0),3];
                        _x setCombatMode _combatMode;
                        if (fen_debug) then {
                            diag_log format["fn_forwardObs: FO %1 gun %2 fired at DFP %3",_foUnit,_x,_target];
                        };
                        _fired=_fired+1;
                    } else {
                        if (fen_debug) then {
                            diag_log format["fn_forwardObs: FO %1 gun %2 out of range DFP %3",_foUnit,_x,_target];
                        };
                    };
                };
                if (_fired==3) exitWith {};
			} forEach _availArtillery;
            if (_fired!=0) then {
                _dfpTriggers=_dfpTriggers-[_target];
                deleteVehicle _target;
                _dfpUsed=true;
            };
		};
    } forEach _dfpTriggers;
	
	_dfpUsed
};

fen_fnc_forwardObs_frfProcess={

    params ["_foUnit","_availArtillery","_engageRange","_skillLevel"];
    
    private _observedTarget=[];
    _observedTarget=[_foUnit,_availArtillery,_engageRange] call fen_fnc_forwardObs_frfTarget;

   if (count _observedTarget==0) exitWith {
        if (fen_debug) then {
            diag_log format["fn_forwardObs: FO %1 no FRF targets to engage",_foUnit];
        };
    };
    
    private _distanceOffset=([([75,25,0] select (_skillLevel-1)),([150,50,0] select (_skillLevel-1))] call BIS_fnc_randomInt);
    if not(alive _foUnit) exitWith {};
    private _directionOffset=_foUnit getDir _observedTarget;
    _directionOffset=_directionOffset+([-90,90] call BIS_fnc_randomInt);
    if (_directionOffset<0) then {_directionOffset=_directionOffset+360};
    if (_directionOffset>360) then {_directionOffset=_directionOffset-360};
    _observedTarget=[_observedTarget,_distanceOffset,_directionOffset] call BIS_fnc_relPos;
    
    if (fen_debug) then {
        _debugTargetId=_foUnit getVariable["fen_debugTargetId",0];
        _debugTargetId=_debugTargetId+1;
        [_observedTarget,format["T%1",_debugTargetId]] call fenTools_fnc_debugMarker;
        _foUnit setVariable ["fen_debugTargetId",_debugTargetId];
    };
    
    private _directionOffset=_foUnit getDir _observedTarget;
    _directionOffset=_directionOffset+([-90,90] call BIS_fnc_randomInt);
    if (_directionOffset<0) then {_directionOffset=_directionOffset+360};
    if (_directionOffset>360) then {_directionOffset=_directionOffset-360};
    private _bracketOffset=(([[400,800],[200,400],[150,200]] select (_skillLevel-1)) call BIS_fnc_randomInt);
    _bracketTarget=[_observedTarget,_bracketOffset,_directionOffset] call BIS_fnc_relPos;

    if (fen_debug) then {
        diag_log format["fn_forwardObs: FO %1 FRF observed target %2, first bracket %3 difference %4",_foUnit,_observedTarget,_bracketTarget,_observedTarget distance _bracketTarget];
        _foUnit setVariable["fen_debugBracketId",0];
    };

    private _bracketSuccess=false;
    while {not _bracketSuccess} do {
    
        private _bracketGun="";

        if not(alive _foUnit) exitWith {};
        {
            _x setVehicleAmmo 1;
            if (unitReady _x) then {
                if (_bracketTarget inRangeOfArtillery [[_x],(getArtilleryAmmo [_x] select 0)]) exitWith {
                    _bracketGun=_x;
                };
            };
        } forEach _availArtillery;
        
        if (typeName _bracketGun=="STRING") exitWith {
           if (fen_debug) then {
                diag_log format["fn_forwardObs: FO %1 FRF no bracketing gun for observed target %2",_foUnit,_observedTarget];
            };
        };
        
        _bracketGun setVehicleAmmo 1;
        _bracketGun doArtilleryFire [_bracketTarget,(getArtilleryAmmo [_bracketGun] select 0),1];
        if (fen_debug) then {
            diag_log format["fn_forwardObs: FO %1 FRF bracketing success %2 fired by %3",_foUnit,_bracketSuccess,_bracketGun];
            _debugTargetId=_foUnit getVariable["fen_debugTargetId",0];
            _debugBracketId=_foUnit getVariable["fen_debugBracketId",0];
            _debugBracketId=_debugBracketId+1;
            [_bracketTarget,format["T%1B%2",_debugTargetId,_debugBracketId]] call fenTools_fnc_debugMarker;
            _foUnit setVariable["fen_debugBracketId",_debugBracketId];
        };
       
        sleep (_bracketGun getArtilleryETA [_bracketTarget,(getArtilleryAmmo [_bracketGun] select 0)]);
        if not (alive _foUnit) exitWith {};
        if (_bracketTarget distance _observedTarget<=75) exitWith {
            _bracketSuccess=true;
            if (fen_debug) then {
                diag_log format["fn_forwardObs: FO %1 FRF success bracketing target %2 gun %3",_foUnit,_bracketTarget,_bracketGun];
            };
        };
        sleep ([30,20,10] select (_skillLevel-1));
        if not (alive _foUnit) exitWith {};
        private _directionOffset=_foUnit getDir _observedTarget;
        _directionOffset=_directionOffset+([-90,90] call BIS_fnc_randomInt);
        if (_directionOffset<0) then {_directionOffset=_directionOffset+360};
        if (_directionOffset>360) then {_directionOffset=_directionOffset-360};

        _bracketTarget=[_observedTarget,((_bracketTarget distance _observedTarget)/2),_directionOffset] call BIS_fnc_relPos;
        if (fen_debug) then {
            diag_log format["fn_forwardObs: FO %1 FRF observed target %2 new bracketing target %3",_foUnit,_observedTarget,_bracketTarget];
        };
    };
    if (_bracketSuccess) then {
        
        private _fired=0;
        {   
            if (unitReady _x) then {
                _x setVehicleAmmo 1;
                if (_observedTarget inRangeOfArtillery [[_x],(getArtilleryAmmo [_x] select 0)]) then {
                    _fired=_fired+1;
                    private _frfTarget=[_observedTarget,(random 30),(random 360)] call BIS_fnc_relPos;
                    _x doArtilleryFire [_frfTarget,(getArtilleryAmmo [_x] select 0),3];
                    if (fen_debug) then {
                        diag_log format["fn_forwardObs: FO %1 FRF fired gun %2 at observed target %3 shell target %4 distance %5",_foUnit,_x,_observedTarget,_frfTarget,_observedTarget distance _frfTarget];
                    };
                    sleep 0.5;
                };
            };
            if (_fired==3) exitWith {};
        } forEach _availArtillery;
    };
};

fen_fnc_forwardObs_frfTarget={

    params ["_foUnit","_availArtillery","_engageRange"];

    private _target=[];
    private _highestThreat=0;
    private _closestThreat=99999999;
    
    {
        _targetPos=_x select 0;
        _targetType=_x select 1;
        _targetSide=_x select 2;
        _targetThreat=_x select 3;
        if ([side _foUnit,_targetSide] call BIS_fnc_sideIsEnemy) then {
            if (fen_debug) then {
                diag_log format["fn_forwardObs: FO %1 FRF target %2",_foUnit,_x];
            };
            if not(_targetType isKindOf "Air") then {
            
                if (fen_debug) then {
                    diag_log format["fn_forwardObs: FO %1 FRF close check %2",_foUnit,(allUnits select {(_targetPos distance _x<=200) and ([side _foUnit,side _x] call BIS_fnc_sideIsFriendly)})];
                };
            
                if (count (allUnits select {(_targetPos distance _x<=200) and ([side _foUnit,side _x] call BIS_fnc_sideIsFriendly)})==0) then {
                    private _artilleryInRange=false;
                    {
                        if (unitReady _x) then {
                            _x setVehicleAmmo 1;
                            if (_targetPos inRangeOfArtillery [[_x],(getArtilleryAmmo [_x] select 0)]) exitWith {
                                _artilleryInRange=true;
                            };
                        };
                    } forEach _availArtillery;
                    if (_artilleryInRange) then {
                        if ((_targetThreat>=_highestThreat) and (((position _foUnit) distance _targetPos)<_closestThreat)) then {
                            _highestThreat=_targetThreat;
                            _target=_targetPos;
                            _closestThreat=(position _foUnit) distance _targetPos;
                        };
                    };
                } else {
                    if (fen_debug) then {
                        diag_log format["fn_forwardObs: FO %1 FRF target pos %2 not clear",_foUnit,_targetPos];
                    };
                };
            };
        };
    } forEach (_foUnit nearTargets _engageRange);

    _target
};

while {alive _foUnit} do {

    _availArtillery=[_foUnit,_artilleryTypes,_callingRange] call fen_fnc_forwardObs_availArtillery;
    
    if (fen_debug) then {
        diag_log format["fn_forwardObs: FO %1 availArtillery %2",_foUnit,_availArtillery];
    };
    
	if (count _availArtillery>0) then {
		private _dfpUsed=[_foUnit,_dfpTriggers,_availArtillery] call fen_fnc_forwardObs_dfpProcess;
		if not(_dfpUsed) then {
			[_foUnit,_availArtillery,_engageRange,_skillLevel] call fen_fnc_forwardObs_frfProcess;
		};
	};
	
	sleep _delayFireMission;
	
};

if (fen_debug) then {
    diag_log format["fn_forwardObs: FO %1 ending",_foUnit];
};
