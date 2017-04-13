/*

File: fn_nearTargets.sqf
Author: Fen 

Description:
Returns array of nearby targets

Parameters:
_this select 0 : vehicle or unit
_this select 1 : range metres

*/

private ["_unit","_side","_objUnt","_tgtRng","_targets","_enemies","_enemySides"];
 
_objUnt=_this select 0;
_tgtRng=_this select 1;

_targets = _objUnt nearTargets _tgtRng;

_enemies = [];
_enemySides = _objUnt call BIS_fnc_enemySides;

{
	_unit = (_x select 4);
	_side = (_x select 2);

	if ((_side in _enemySides) && (count crew _unit > 0)) then {
		if ((side driver _unit) in _enemySides) then {
			_enemies pushBack _unit;
		};
	};
} forEach _targets;

_enemies