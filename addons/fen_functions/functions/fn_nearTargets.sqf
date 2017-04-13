/*

File: fn_nearTargets.sqf
Author: Fen 

Description:
Returns array of nearby enemy units for a unit

Shamelessly ripped from BIS_fnc_neartargets but without the errors, give them credit.

Parameters:
_this select 0 : (Object) unit
_this select 1 : (Scalar) range

Examples:
_enemies=[_unit,500] call fen_fnc_nearTargets

*/

private ["_targets","_enemies","_enemySides","_side","_unit","_objUnt","_tgtRng"];

_objUnt=param[0,objNull,[objNull]];
_tgtRng=param[1,1500,[0]];

_targets = _objUnt nearTargets _tgtRng;

_enemies = [];

_enemySides = _objUnt call BIS_fnc_enemySides;

{
	_unit = (_x select 4);
	_side = (_x select 2);

	if ((_side in _enemySides) && (count crew _unit > 0)) then
	{
		if ((side driver _unit) in _enemySides) then
		{
			//_enemies set [count _enemies, _unit];
			_enemies pushBack _unit;
		};
	};
}
forEach _targets;

_enemies