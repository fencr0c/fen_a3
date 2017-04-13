/*

File: fn_airAssault.sqf
Author: Fen 

Description:
Inserts AI group by helicopter.

A transport helicopter is spawned with crew, the infantry group is spawned and moved into the helicopter.
The helicopter follows the inbound waypoints and lands at the landing location, where the infantry group will disembark.
Once infantry group is disembarked their script will be execVM'd, the group parameter is passed as a parameter.
The helicopter will then take off, fly outbound waypoints to the end location where is will despawn.

Parameters:
_this select 0 : (Side) side for air insert
_this select 1 : (String) tranport chopper class
_this select 2 : (Array) spawn location for transport chopper
_this select 3 : (Array) infantry classes in Group (Array)
_this select 4 : (Array) spawn location for infantry group (Array)
_this select 5 : (Array) landing location (Array)
_this select 6 : (Array) end location for transport chopper (Array)
_this select 7 : (Array) waypoints for chopper to landing location (Array)
_this select 8 : (Array) waypoints for chopper to despawn (Array)
_this select 9 : (String) script to call upon infantry group disembarked, infantry group is passed as parameter (Text)
_this select 10: OPTIONAL (String) owned by value

Example:
[east,"helicopter",[1000,1000],["solder1","soldier2"],[1050,1050],[3000,3000],[1000,1000],[[1500,1000],[2000,1000]],[[2000,1000],[1500,1000]],"myfolder\myscript.sqf",] call fen_fnc_airAssault

*/

private ["_ownVal","_aiiSid","_trnHel","_trnStr","_infCls","_infStr","_trnLnd","_trnEnd","_infScr","_trnGrp","_infGrp","_trnDta","_trnVeh","_lndPad","_idxWps","_trnWPI","_trnWPO"];

_aiiSid=param[0,east,[sideLogic]];
_trnHel=param[1,"",[""]];
_trnStr=param[2,[0,0,0],[[]],[2,3]];
_infCls=param[3,[""]];
_infStr=param[4,[0,0,0],[[]],[2,3]];
_trnLnd=param[5,[0,0,0],[[]],[2,3]];
_trnEnd=param[6,[0,0,0],[[]],[2,3]];
_trnWPI=param[7,[],[[]]];
_trnWPO=param[8,[],[[]]];
_infScr=param[9,""];
_ownVal=param[10,""];

if (isNil "fen_debug") then {
    fen_debug=false;
};

// spawn transport helicopter
_trnDta=[_aiiSid,_trnStr,0,0,false,true,_trnHel,_ownVal] call fen_fnc_spawnvehicle;
_trnVeh=_trnDta select 0;
_trnGrp=_trnDta select 1;

// spawn infantry group 
_infGrp=[_aiiSid,_infStr,0,_infCls,_ownVal] call fen_fnc_spawngroup;

// move infantry group into transport helicopter
{
    _x assignAsCargo _trnVeh;
    _x moveInCargo _trnVeh;
} forEach units _infGrp;

// assign waypoints to transport helicopter inbound to landing location
_idxWps=0;
if (count _trnWPI==0) then {
    _idxWps=_idxWps+1;
    _trnGrp addWaypoint [_trnLnd,0];
    [_trnGrp,_idxWps] setWaypointType "MOVE";
} else {
    {       
        _idxWps=_idxWps+1;
        _trnGrp addWaypoint [_x,0];
        [_trnGrp,_idxWps] setWaypointType "MOVE";
    } forEach _trnWPI;
};

// assign waypoint to land helicopter
_lndPad=createVehicle ["Land_HelipadEmpty_F",_trnLnd,[],0,"CAN_COLLIDE"];
_idxWps=_idxWps+1;
_trnGrp addWaypoint [_trnLnd,0];
[_trnGrp,_idxWps] setWaypointType "TR UNLOAD";
[_trnGrp,_idxWps] setWaypointBehaviour "CARELESS";
if (count _trnWPI==0) then {
    [_trnGrp,_idxWps] setWaypointSpeed "LIMITED";
};

// assign waypoint for helicopter outbound to despawn location
if (count _trnWPO>0) then {
    {
        _idxWps=_idxWps+1;
        _trnGrp addWaypoint [_x,0];
        [_trnGrp,_idxWps] setWaypointType "MOVE";
    } forEach _trnWPO;
};

// assign waypoint for helicopter end 
_idxWps=_idxWps+1;
_trnGrp addWaypoint [_trnEnd,0];
[_trnGrp,_idxWps] setWaypointType "MOVE";
[_trnGrp,_idxWps] setWaypointSpeed "FULL";
[_trnGrp,_idxWps] setWaypointStatements ["true","[group this] call fen_fnc_dltGroup"];

// spawn infantry disembarked handler
[_infGrp,_infScr,_lndPad] spawn {
    
    private ["_infGrp","_infScr","_lndPad"];
    
    _infGrp=_this select 0;
    _infScr=_this select 1;
    _lndPad=_this select 2;
    
	// wait until troops disemark or no more units left in infantry group
    waitUntil{
        sleep 3;
        vehicle leader _infGrp==leader _infGrp or
        count units _infGrp==0;
    };
	
	// unassign infantry group from helicopter
    {
        {unassignVehicle _x} forEach units _infGrp;
    } forEach units _infGrp;

	// delete landing pad
    deleteVehicle _lndPad;	
	
	// run script for infantry group
	if (_infScr!="") then {
		[_infGrp] execVM _infScr;
	};

};


