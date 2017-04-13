/*

File: fn_bldPatrol.sqf
Author: Fen 

Description:
Units of the group will act independantly and patrol from one building position to another.
If there are not enterable buildings in patrol range, nothing will happen.

Parameters:
_this select 0 : (Group) group to patrol 
_this select 1 : (Scalar) patrol range, default is 300
_this select 2 : OPTIONAL (Array building classes to exclude

Example:
[_group,300] spawn fen_fnc_bldPatrol

Note:
In debug console, command below to find class of building.
	typeof (nearestBuilding player)
	
*/

private ["_chkPos","_idx","_patGrp","_patRad","_patBld","_bldPos","_excBld"];

_patGrp=param[0,grpNull,[grpNull]];
_patRad=param[1,300,[0]];
_excBld=param[2,[],[[]]];

if not(local leader _patGrp) exitWith{};

if (isNil "fen_debug") then {
	fen_debug=false;
};

_patBld=nearestObjects [position leader _patGrp,["Building"],_patRad];
if (count _patBld==0) exitWith {};

// build list of building positions for nearby buildings
_bldPos=[];
{
	if not(typeOf _x in _excBld) then {
	 _idx=0;
	 _chkPos=_x buildingPos _idx;
	 while {format["%1",_chkPos] != "[0,0,0]"} do {
			_bldPos pushBack _chkPos;
			_chkPos=_x buildingPos _idx;
			_idx=_idx+1;
		};
	};
} forEach _patBld;

_patGrp setBehaviour "SAFE";

// start each unit in group randomly moving around building
{
	[_x,_bldPos] spawn {
		
		private ["_patUnt","_bldPos"];
		
		_patUnt=_this select 0;
		_bldPos=_this select 1;
		
		_patUnt setSpeedMode "LIMITED";
		_patUnt setCombatMode "YELLOW";
		doStop _patUnt;
				
		while {alive _patUnt} do {
			scopeName "moveControl";
			
			// move to random building position 
			_patUnt doMove (_bldPos select floor(random count _bldPos));
			waitUntil {
				sleep 3;
				unitReady _patUnt or not(alive _patUnt);
			};
		};
	};
} forEach units _patGrp;

