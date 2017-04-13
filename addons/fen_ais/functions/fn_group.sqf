/*

File: fn_group.sqf
Author: Fen 

Description:
Adds units group to processed via AIS

Parameters:
_this select 0 : unit 
_this select 1 : optional parameters
_this select 2 : optional owning location

*/

private ["_unit","_data","_vari"];

_unit=param[0,objNull,[objNull]];
_data=param[1,true];
_vari=param[2,objNull,[objNull]];

if (isNull _unit) exitWith {};

diag_log format["fn_group vari is %1",_vari]; // debug delete me 


private _grpData=(group _unit) getVariable ["fen_ais_group",""];

if (typeName _grpData!="STRING") then {
	if (typeName _grpData isEqualTo "BOOLEAN") then {
		_grpData=_data;
	} else {
		{
			_grpData pushback _x;
		} forEach _data;
	};
} else {
	_grpData=_data;
};

(group _unit) setVariable ["fen_ais_group",_grpData,true];

if not(isNull _vari) then {
	(group _unit) setVariable ["fen_ais_groupOwnedBy",_vari,true];
};
