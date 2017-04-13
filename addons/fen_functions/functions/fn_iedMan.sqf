/*

File: iedman.sqf
Author: Fen

Description:
AI unit places IED object at a specific point.
Unit will move to a position where they can check IED location is clear of players.
If players in area, it will wait until clear.
Once clear unit will place first IED at the location and remaining IED's in inventory around area.

Parameters:
_this select 0 : (Object) Unit placing IED
_this select 1 : (Array) IED placement location
_this select 2 : (Array) IED classes to place
_this select 3 : OPTIONAL (Object) Trigger name to start man moving

Example:
[_unit,[1000,1000],["IEDLandBig_F","IEDLandBig_F"]] spawn fen_fnc_iedMan

*/

private ["_iedMan","_iedLoc","_iedCls","_trgNam"];

_iedMan=param[0,objNull,[objNull]];
_iedLoc=param[1,[0,0],[[]],[2,3]];
_iedCls=param[2,["IEDLandBig_F","IEDLandBig_F"],[[]]];
_trgNam=param[3,objNull,[objNull]];

if (isNull _iedMan) exitWith {};
if (not local _iedMan) exitWith {};

if (isNil "fen_debug") then {
	fen_debug=false;
};

fen_iedman_clrOfPlayers={

	private ["_clrLoc","_clrRng"];
	
	_clrLoc=param[0];
	_clrRng=param[1];
	
	({_x distance _clrLoc<_clrRng} count (call BIS_fnc_listPlayers)==0)
};

fen_iedman_doMove={

	private ["_iedMan","_movLoc"];
	
	_iedMan=param[0];
	_movLoc=param[1];
	
	_iedMan forceSpeed -1;
	_iedMan doMove _movLoc;
	waitUntil {
		sleep 3;
		(unitReady _iedMan or not(alive _iedMan));
	};
	_iedMan forceSpeed 0;
	_iedMan doWatch _movLoc;
};

fen_iedman_equip={

	private ["_iedMan","_iedCls"];
	
	_iedMan=param[0];
	_iedCls=param[1];
	
	removeAllWeapons _iedMan;
	removeAllItems _iedMan;
	removeAllAssignedItems _iedMan;
	removeVest _iedMan;
	removeBackpack _iedMan;
	removeGoggles _iedMan;

	_iedMan addBackpack "B_FieldPack_blk";
	{
		_iedMan addItemToBackpack ([_x] call fen_iedman_getDftMag);
	} forEach _iedCls;
	
	_iedMan setCombatMode "GREEN";
	_iedMan setBehaviour "CARELESS";
	_iedMan forceSpeed 0;
};

fen_iedman_fndObsvLoc={

	private ["_iedMan","_iedLoc","_tstLoc","_obsLoc"];
	
	_iedMan=param[0];
	_iedLoc=param[1];
	
	_obsLoc=[];
	while {count _obsLoc==0} do {
	
		_tstLoc=[[_iedLoc select 0, _iedLoc select 1,0],500,300] call BIS_fnc_findOverwatch;
		if ([_tstLoc,300] call fen_iedman_clrOfPlayers) exitWith {
			_obsLoc=_tstLoc;
		};
		sleep 0.3;
	};
	
	if (fen_debug) then {
	[_obsLoc,"IED Observe Loc"] call fenTools_fnc_debugmarker;
	};
	
	_obsLoc;
};

fen_iedman_getDftMag={

	private ["_clsIED","_clsAmo","_clsMag"];
	
	_clsIED=param[0];
	
	_clsAmo=(configFile>>"cfgVehicles">>_clsIED>>"Ammo") call BIS_fnc_getCfgData;
	_clsMag=(configFile>>"cfgAmmo">>_clsAmo>>"defaultMagazine") call BIS_fnc_getCfgData;
	
	_clsMag
};

fen_iedman_hasIed={

	private ["_iedMan","_iedCls","_clsMag","_hasIed"];
	
	_iedMan=param[0];
	_iedCls=param[1];
	
	_hasIed=false;
	{
		_clsMag=[_x] call fen_iedman_getDftMag;
		if (_clsMag in (magazines _iedMan)) exitWith {
			_hasIed=true;
		};
	} forEach _iedCls;
	
	_hasIed
};

fen_iedman_putIed={

	private ["_iedMan","_iedCls","_fstIed","_iedObj"];

	_iedMan=param[0];
	_iedCls=param[1];
	
	_fstIed=true;
	while {(alive _iedMan) and ([_iedMan,_iedCls] call fen_iedman_hasIed)} do {
		
		if not(_fstIed) then {
			_iedMan doMove ([position _iedMan,10,50,10,0,9,0] call BIS_fnc_findSafePos);
			waitUntil {
				sleep 3;
				unitReady _iedMan or not(alive _iedMan);
			};
		};
		if not(alive _iedMan) exitWith {};
		
		_iedMan forceSpeed 0;
		_iedMan setUnitPos "Middle";
		sleep 10;
		
		_iedObj=createVehicle[(_iedCls select 0),(position _iedMan),[],1,"CAN_COLLIDE"];
		[_iedObj,true] spawn fen_fnc_iedObject;
		_iedMan removeItemFromBackpack ([(_iedCls select 0)] call fen_iedman_getDftMag);
		_iedCls deleteRange[0,1];
		_iedMan forceSpeed -1;
		_iedMan setUnitPos "UP";
		_fstIed=false;
		
	};
};

fen_iedman_runAway={

	private ["_iedMan","_tstLoc"];
	
	_iedMan=param[0];
	
	while {alive _iedMan} do {
	
		[_iedMan,([position _iedMan,2000,5000,10,0,9,0] call BIS_fnc_findSafePos)] call fen_iedman_doMove;
		waitUntil {
			sleep 3;
			unitReady _iedMan or not(alive _iedMan);
		};
		if not(alive _iedMan) exitWith {};
		if ([(position _iedMan),300] call fen_iedman_clrOfPlayers) exitWith {
			deleteVehicle _iedMan;
		};
	};
};


/* MAINLINE */

// debug - mark ied location
if (fen_debug) then {
	[_iedLoc,"IED Location"] call fenTools_fnc_debugmarker;
};

// equip unit
[_iedMan,_iedCls] call fen_iedman_equip; 
if not(alive _iedMan) exitWith{};

// if trigger, wait until active.
if not(isNull _trgNam) then {
	waitUntil {
		sleep 3;
		triggerActivated _trgNam;
	};
};

// move to position to observe IED location
if ([_iedMan,_iedCls] call fen_iedman_hasIed) then {
	[_iedMan,([_iedMan,_iedLoc] call fen_iedman_fndObsvLoc)] call fen_iedman_doMove;
};
if not(alive _iedMan) exitWith{};

// wait until there are no players at IED location
if ([_iedMan,_iedCls] call fen_iedman_hasIed) then {
	waitUntil {
		sleep 3;
		([_iedLoc,300] call fen_iedman_clrOfPlayers) or not(alive _iedMan);
	};
};
if not(alive _iedMan) exitWith{};

// move to IED location
if ([_iedMan,_iedCls] call fen_iedman_hasIed) then {
	[_iedMan,_iedLoc] call fen_iedman_doMove;
};
if not(alive _iedMan) exitWith{};

// put IED
if ([_iedMan,_iedCls] call fen_iedman_hasIed) then {
	[_iedMan,_iedCls] call fen_iedman_putIed;
};
if not(alive _iedMan) exitWith{};

// runaway
[_iedMan] call fen_iedman_runAway;

