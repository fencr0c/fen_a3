/*

File: fn_rtnBuildingPos
Author: Fen 

Description:
Returns array of buildingPos for nearby buildings within range

Parameter(s):
_this select 0 : (Array) centre location
_this select 1 : (Scalar) radius
_this select 2 : OPTIONAL (Array building classes to exclude

Returns:
Array of positions

Example:
_positions=[[1000,1000],100] call fen_fnc_rtnBuildingPos

Note:
In debug console, command below to find class of building.
	typeof (nearestBuilding player)

*/

private ["_chkPos","_idx","_bldPos","_cenLoc","_cenRad","_clsBld","_excBld"];

_cenLoc=param[0,[0,0,0],[[]]];
_cenRad=param[1,100,[0]];
_excBld=param[2,[],[[]]];

// build list of buildings positions 
_clsBld=nearestObjects [_cenLoc,["Building"],_cenRad];
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
} forEach _clsBld;

_bldPos