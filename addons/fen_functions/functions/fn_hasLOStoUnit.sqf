/*

File: fn_hasLOStoUnit.sqf
Author: Fen

Description:
Returns if unit has LOS to another unit.

Parameters:
_this select 0 : observer unit
_this select 1 : target unit

*/

params[
  ["_observer",objNull,[objNull]],
  ["_target",objNull,[objNull]]
];

private _hasLOS=false;
if (([objNull,"VIEW",_observer] checkVisibility [(eyePos _observer),(eyePos _target)])==1) then {
  _hasLOS = true;
};

_hasLOS
