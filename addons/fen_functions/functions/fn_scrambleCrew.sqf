/*

File: fn_scambleCrew.sqf
Author: Fen

Description:
Simulates crew of vehicle dismounted, when enemy detect they will mount vehicle and either fight or flee.

Parameter(s):
_this select 0 : (Object) vehicle
_this select 1 : (Side) vehicle side
_this select 2 : (Side) enemy side that will cause reaction
_this select 3 : (Scalar) react to enemies in radius
_this select 4 : (Boolean) fight or flee
_this select 5 : OPTIONAL (Array) additional classes to spawn as clutter
_this select 6 : OPTIONAL (Array) crew classes

Example:
[_vehicle,east,west,500,true,["box","tyres","barrels"],"soldier1"] spawn fen_fnc_scambleCrew

*/

private ["_clutterArray","_crewClass","_vehicle","_crewSide","_triggeringSide","_triggeringRange","_crewGroup","_triggerType","_triggeredBy","_scrambleTrigger","_clutterPosition","_fight"];

if not(local (_this select 0)) exitWith {};

_vehicle=param[0,objNull,[objNull]];
_crewSide=param[1,east,[sideLogic]];
_triggeringSide=param[2,west,[sideLogic]];
_triggeringRange=param[3,500,[0]];
_fight=param[4,true,[true]];
_clutterArray=param[5,[],[[]]];
_crewClass=param[6,"",[""]];


if (_crewClass=="") then {
    _crewClass=(configFile>>"CfgVehicles">>(typeOf _vehicle)>>"crew") call BIS_fnc_getCfgData;
};


if (isNil "fen_debug") then {
    fen_debug=false;
};

fen_fnc_scrambleCrew_scramble_clutter={

    private ["_safePosition","_x","_object","_vehicle","_clutterArray","_clutterObjects"];

    _vehicle=_this select 0;
    _clutterArray=_this select 1;

    _safePosition=[(position _vehicle),5,20,2,0,99,0] call BIS_fnc_findSafePos;
    if (_safePosition isEqualTo [0,0,0]) then {
        _safePosition=(position _vehicle);
    };
    if (count _clutterArray>0) then {

		if (typeName(_clutterArray select 0)=="ARRAY") then {
			_clutterObjects=_clutterArray select (floor(random (count _clutterArray)));
		} else {
			_clutterObjects=_clutterArray;
		};

		for [{_x=0},{_x<(count _clutterObjects)},{_x=_x+1}] do {
			_object=createVehicle[(_clutterObjects select _x),_safePosition,[],0,"NONE"];
			_object setDir ([0,360] call BIS_fnc_randomInt);
		};
	};

	_safePosition
};

fen_fnc_scrambleCrew_scramble_crew={

	private ["_vehicle","_crewClass","_crewGroup","_crewSide","_crewPosition","_x","_safePosition"];

	_vehicle=_this select 0;
	_crewClass=_this select 1;
	_crewSide=_this select 2;
	_safePosition=_this select 3;

	_crewGroup=createGroup _crewSide;
	_crewPosition=[_vehicle,_crewGroup,true,(typeOf _vehicle)] call BIS_fnc_spawnCrew;
	for [{_x=0},{_x<(count _crewPosition)},{_x=_x+1}] do {
		if ((_crewPosition select _x)==1) then {
			private _crewUnit=_crewGroup createUnit[_crewClass,_safePosition,[],5,"NONE"];
            [_crewUnit] joinSilent _crewGroup;
		};
	};

	sleep 0.5;
	_crewGroup setBehaviour "SAFE";

	for [{_x=0},{_x<(count (units _crewGroup))},{_x=_x+1}] do {
		((units _crewGroup) select _x) setDir ([((units _crewGroup) select _x),_safePosition] call BIS_fnc_relativeDirTo);
	};

	_crewGroup
};

fen_fnc_scrambleCrew_scramble={

	private ["_vehicle","_crewGroup","_clearLocation","_waypointRadius","_fight"];

	_vehicle=_this select 0;
	_crewGroup=_this select 1;
	_fight=_this select 2;

	if (canMove _vehicle) then {

		_crewGroup addWaypoint [(position _vehicle),0];
		[_crewGroup,1] setWaypointBehaviour "AWARE";
		[_crewGroup,1] setWaypointSpeed "FULL";
		[_crewGroup,1] setWaypointCombatMode "GREEN";
		[_crewGroup,1] setWaypointType "GETIN NEAREST";

		if (_fight) then {

			_crewGroup addWaypoint [(position _vehicle),1000];
			[_crewGroup,2] setWaypointBehaviour "COMBAT";
			[_crewGroup,2] setWaypointSpeed "FULL";
			[_crewGroup,2] setWaypointCombatMode "RED";
			[_crewGroup,2] setWaypointType "MOVE";

		} else {

			_clearLocation=[(position _vehicle),4000,[side _crewGroup],2000,10] call fen_fnc_fndclearloc;
			if (count _clearLocation==0) then {
				_clearLocation=(position _vehicle);
				_waypointRadius=4000;
			} else {
				_waypointRadius=100;
			};

			_crewGroup addWaypoint [_clearLocation,_waypointRadius];
			[_crewGroup,2] setWaypointBehaviour "AWARE";
			[_crewGroup,2] setWaypointSpeed "FULL";
			[_crewGroup,2] setWaypointCombatMode "GREEN";
			[_crewGroup,2] setWaypointType "GETOUT";
		};

	} else {

		_crewGroup addWaypoint [(position _vehicle),300];
		[_crewGroup,2] setWaypointBehaviour "COMBAT";
		[_crewGroup,2] setWaypointSpeed "FULL";
		[_crewGroup,2] setWaypointCombatMode "GREEN";
		[_crewGroup,2] setWaypointType "MOVE";
	};

};

_clutterPosition=[_vehicle,_clutterArray] call fen_fnc_scrambleCrew_scramble_clutter;

_crewGroup=[_vehicle,_crewClass,_crewSide,_clutterPosition] call fen_fnc_scrambleCrew_scramble_crew;

_crewGroup addVehicle _vehicle;

switch (_triggeringSide) do {
	case east : {_triggeredBy="EAST"};
	case west : {_triggeredBy="WEST"};
	case resistance : {_triggeredBy="GUER"};
};

switch (_crewSide) do {
	case east : {_triggerType="EAST D"};
	case west : {_triggerType="WEST D"};
	case resistance : {_triggerType="GUER D"};
};

_scrambleTrigger=createTrigger["EmptyDetector",(position _vehicle)];
_scrambleTrigger setTriggerArea[_triggeringRange,_triggeringRange,0,false];
_scrambleTrigger setTriggerActivation[_triggeredBy,_triggerType,false];
_scrambleTrigger setTriggerStatements["this","",""]; //https://feedback.bistudio.com/T124846

while {true} do {

	sleep 5;

    if (({alive _x} count (units _crewGroup))==0) exitWith {};

	if (triggerActivated _scrambleTrigger) exitWith {

		if (fen_debug) then {
			player sideChat format["scramble crew triggered for group %1",_crewGroup];
		};

		[_vehicle,_crewGroup,_fight] call fen_fnc_scrambleCrew_scramble;
	};
};

deleteVehicle _scrambleTrigger;
