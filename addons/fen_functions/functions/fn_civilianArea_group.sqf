/*

File: fn_civilianArea_group.sqf
Author: Fen 

Description:
Controls group of civilians from the fn_civilianarea function.

Parameters:
_this select 0 : (Group) civilian group
_this select 1 : (Array) centre position for civilians
_this select 2 : (Scalar) max wandering distance
_this select 3 : (Array) building positions within wander radius

Example:
[_group,[100,100,0],300,[[001,001,001],[002,002,002]] spawn fen_fnc_civilianArea_group

*/

private ["_civGrp","_civUnt","_araLoc","_araRad","_movLoc","_bldPos"];

params [
    ["_civGrp",grpNull,[grpNull]],
    ["_araLoc",[0,0],[[]]],
    ["_araRad",300,[0]],
    ["_bldPos",[],[[]]]
];

while {{alive _x} count units _civGrp>0} do {
		
	{
		if (alive _x and unitReady _x) then {
            _civUnt=_x;
			group _civUnt setCombatMode "GREEN";
			group _civUnt setBehaviour "SAFE";
			group _civUnt setSpeedMode "LIMITED";
			_civUnt allowFleeing 1;
			doStop _civUnt; 
				
			if not(fleeing _civUnt) then {
				_civUnt forceSpeed 1.4;
  				if (count _bldPos<30) then {
					_movLoc=[_araLoc,50,_araRad,4,0,1,0] call BIS_fnc_findSafePos;
				} else {
					_movLoc=_bldPos select floor(random count _bldPos);
				};
				_civUnt domove _movLoc;
			} else {
				_civUnt forceSpeed -1;
				group _civUnt setCombatMode "GREEN";
				group _civUnt setBehaviour "SAFE";
				group _civUnt setSpeedMode "LIMITED";
			};
		};
	} forEach units _civGrp;
	sleep 30;
};
