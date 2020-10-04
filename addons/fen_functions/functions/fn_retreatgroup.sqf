/*

File: fn_retreatgroup.sqf
Author: Fen

Description:
Retreat all units in group to a location based on proximity of players or causalities.
Upon reaching retreat location group can be deleted or go into group defend via grpdefend.sqf

Parameters:
_this select 0 : (Group) group
_this select 1 : (Array) proximity array [[side],distance] retreat when units of other side are within distance
_this select 2 : (Scalar) retreat when this % causalities sustained, 0 means never retreat due to causalities
_this select 3 : (Array) retreat to this location
_this select 4 : (Boolean) delete group on reaching retreat location [true] or take up defensive positions [false]

Example:
[_group,[[west],300],10,[1000,1000],false] spawn fen_fnc_retreatGroup

*/

private ["_retGrp","_retPrx","_retCas","_retLoc","_retRmv","_RetYON","_retSid","_retRng","_intNum","_wayIdx"];

_retGrp=param[0,grpNull,[grpNull]];
_retPrx=param[1,[[west],300],[[]],[2]];
_retCas=param[2,50,[0]];
_retLoc=param[3,[0,0,0],[[]],[2,3]];
_retRmv=param[4,false,[true]];

if not(local (leader _retGrp)) exitWith{};

if (isNil "fen_debug") then {
    fen_debug=false;
};

// store initial number of units
_intNum={alive _x} count (units _retGrp);

while {true} do {
    scopeName "retLoop";

    sleep 10;

    _retYON=false;

    // all units in group dead, quit
    if (({alive _x} count units _retGrp)==0) then {
        breakOut "retLoop";
    };
      
    //_retYON=false;

    // proximity check
    if (count _retPrx>0) then {

        _retSid=_retPrx select 0;
        _retRng=_retPrx select 1;

		if (count([leader _retGrp,_retRng] call fen_fnc_neartargets)>0) then {
			_retYON=true;
			breakOut "retLoop";
        };
    };

	// casualty check
    if (_retCas!=0) then {
        if (_intNum-(ceil(_intNum*(_retCas/100)))>={alive _x} count units _retGrp) then {
            _retYon=true;
            breakOut "retLoop";
        };
    };
};

// if group is to retreat
if (_RetYON) then {

    if (fen_debug) then {
        player sideChat format["retreatgroup: %1 are in retreat",_retGrp];
    };

    // dismount any static
    {
        if ((vehicle _x) isKindOf "StaticWeapon") then {
            {unassignVehicle _x} forEach crew (vehicle _x);
            {_x action ["eject",(vehicle _x)]} forEach crew (vehicle _x);
            _retGrp leaveVehicle (vehicle _x);
            deleteVehicle (vehicle _x);
        };
    } forEach units _retGrp;

	// delete current waypoints
	while {(count (waypoints _retGrp))>0} do {
		deleteWaypoint ((waypoints _retGrp) select 0);
	};

    // assign retreat waypoint
    _wayIdx=(count (waypoints _retGrp));
    _retGrp addWaypoint [_retLoc,0];
    [_retGrp,_wayIdx] setWaypointBehaviour "AWARE";
    [_retGrp,_wayIdx] setWaypointCombatMode "GREEN";
    [_retGrp,_wayIdx] setWaypointType "MOVE";
    [_retGrp,_wayIdx] setWaypointSpeed "FULL";
    if (_retRmv) then {
        [_retGrp,_wayIdx] setWaypointStatements ["true","[(group this)] call fen_fnc_dltGroup"];
    } else {
        [_retGrp,_wayIdx] setWaypointStatements ["true","[(group this),200] call fen_fnc_grpDefend"];
    };
    _retGrp setCurrentWaypoint [_retGrp,_wayIdx];
};
