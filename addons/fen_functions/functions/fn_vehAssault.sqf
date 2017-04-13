/*

File: vehAssault.sqf
Author: Fen 

Description:
Insert AI group by ground vehicle (e.g. truck or APC).

The vehicle is spawned with crew, the infantry group is spawned and moved into the vehicle.
The vehicle follows the inbound waypoints stopping at the disembark location, where infantry group will get.
Once infantry group is disembarked their script wil be execVM'd, the groups id is passed as a parameter.
The vehicle will then move off following the outbound wayponts and despawn.

Parameters:
_this select 0 : (Side) side for vehicle insert
_this select 1 : (String) tranport vehicle class
_this select 2 : (Array) spawn location for transport vehicle
_this select 3 : (Array) infantry classes in Group 
_this select 4 : (Array) spawn location for infantry group 
_this select 5 : (Array) disembark location
_this select 6 : (Array) end location for transport vehicle
_this select 7 : (Array) waypoints for vehicle to disembark location
_this select 8 : (Array) waypoints for vehicle to despawn
_this select 8 : (String) script to call upon infantry group disembarked, Infary group is passed
_this select 9 : (String) owned by value

Example:
[east,"truck",[1000,1000],["solder1","soldier2"],[1050,1050],[3000,3000],[1000,1000],[[1500,1000],[2000,1000]],[[2000,1000],[1500,1000]],"myfolder\myscript.sqf",] call fen_fnc_vehAssault

*/

private ["_ownVal","_aiiSid","_trnVeh","_trnStr","_infCls","_infStr","_trnLnd","_trnEnd","_infScr","_trnGrp","_infGrp","_trnDta","_idxWps","_trnWPI","_trnWPO"];

_aiiSid=param[0,east,[sideLogic]];
_trnVeh=param[1,"",[""]];
_trnStr=param[2,[0,0,0],[[]],[2,3]];
_infCls=param[3,[""]];
_infStr=param[4,[0,0,0],[[]],[2,3]];
_trnLnd=_this select 5;
_trnLnd=param[5,[0,0,0],[[]],[2,3]];
_trnEnd=param[6,[0,0,0],[[]],[2,3]];
_trnWPI=param[7,[],[[]]];
_trnWPO=param[8,[],[[]]];
_infScr=param[9,""];
_ownVal=param[10,""];

if (isNil "fen_debug") then {
    fen_debug=false;
};

// spawn transport vehicle
_trnDta=[_aiiSid,_trnStr,0,0,false,true,_trnVeh,_ownVal] call fen_fnc_spawnvehicle;
_trnVeh=_trnDta select 0;
_trnGrp=_trnDta select 1;

// spawn infantry group 
_infGrp=[_aiiSid,_infStr,0,_infCls,_ownVal] call fen_fnc_spawngroup;

// move infantry group into transport vehicle
{
    _x assignAsCargo _trnVeh;
    _x moveInCargo _trnVeh;
} forEach units _infGrp;

// assign waypoints to transport vehicle inbound to disembark location
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

// assign waypoint to disembark location
_idxWps=_idxWps+1;
_trnGrp addWaypoint [_trnLnd,0];
[_trnGrp,_idxWps] setWaypointType "TR UNLOAD";
[_trnGrp,_idxWps] setWaypointBehaviour "CARELESS";
if (count _trnWPI==0) then {
    [_trnGrp,_idxWps] setWaypointSpeed "LIMITED";
};

// assign waypoint for vehicle outbound to despawn location
if (count _trnWPO>0) then {
    {
        _idxWps=_idxWps+1;
        _trnGrp addWaypoint [_x,0];
        [_trnGrp,_idxWps] setWaypointType "MOVE";
    } forEach _trnWPO;
};

// assign waypoint for vehicle end 
_idxWps=_idxWps+1;
_trnGrp addWaypoint [_trnEnd,0];
[_trnGrp,_idxWps] setWaypointType "MOVE";
[_trnGrp,_idxWps] setWaypointSpeed "FULL";
[_trnGrp,_idxWps] setWaypointStatements ["true","[group this] call fen_fnc_dltGroup"];

// spawn infantry disembarked handler
[_infGrp,_infScr] spawn {
    
    private ["_infGrp","_infScr"];
    
    _infGrp=_this select 0;
    _infScr=_this select 1;
    
	// wait until troops disemark or no more units left in infantry group
    waitUntil{
        sleep 3;
        vehicle leader _infGrp==leader _infGrp or
        count units _infGrp==0;
    };
	
	// unassign infantry group from vehicle
    {
        {unassignVehicle _x} forEach units _infGrp;
    } forEach units _infGrp;

	// run script for infantry group
	if (_infScr!="") then {
		[_infGrp]execVM _infScr;
	};

};


