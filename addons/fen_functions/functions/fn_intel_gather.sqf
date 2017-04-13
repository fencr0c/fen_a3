/*

File: fn_intel_gather.sqf
Author: Fen 

Description:
Handles conversaton called from addAction, see fen_fnc_intel_addIntel

Parameters:
_this select 0 : (Object) target i.e. the civilian
_this select 1 : (Object) caller i.e. the player
_this select 3 : (Array) conversation

*/
private ["_target","_intel","_caller","_subject","_grid"];

_target=param[0,objNull,[objNull]];
_caller=param[1,objNull,[objNull]];
_intel=param[3,""];

if not(hasInterface) exitWith {};

hint "Intel Gathered, see Map, Diary / Intel Gathered";

if not(_caller diarySubjectExists "intelLog") then {
	_caller createDiarySubject ["intelLog","Intel Gathered"];
};

//_grid=[(getPos _target) select 0,(getPos _target) select 1];
_grid=mapGridPosition (getPos _target);
_subject=format["%1/GR%2",text (nearestLocations [_caller,["nameVillage","nameCity"],500] select 0),_grid];
_caller createDiaryRecord ["intelLog",[_subject,_intel]];	

deleteVehicle _target;

