/*

File: fn_vehicle.sqf
Author: Fen

Description:
Adds vehicle to processed via AIS

Parameters:
_this select 0 : vehicle
_this select 1 : optional parameters
_this select 2 : optional owning location

*/

private ["_vehicle","_data","_vari"];

_vehicle=param[0,objNull,[objNull]];
_data=param[1,true];
_vari=param[2,objNull,[objNull]];

if (isNull _vehicle) exitWith {};

if (_vehicle in allMines) exitWith {
	systemChat format["AIS Error: %1 cannot be used with AIS",typeOf _vehicle];
};

private _vehData=_vehicle getVariable ["fen_ais_vehicle",""];

if (typeName _vehData!="STRING") then {
	if (typeName _vehData isEqualTo "BOOLEAN") then {
		_vehData=_data;
	} else {
		{
			_vehData pushBack _x;
		} forEach _data;
	};
} else {
	_vehData=_data;
};

_vehicle setVariable ["fen_ais_vehicle",_vehData,true];

if not(isNull _vari) then {
	_vehicle setVariable ["fen_ais_vehicleOwnedBy",_vari,true];
};
