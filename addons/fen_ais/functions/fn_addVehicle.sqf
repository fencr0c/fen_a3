/*

File: fn_addVehicle.sqf
Author: Fen 

Description:
Adds vehicles to AIS location

Parameters:
_this select 0 : vehicle
_this select 1 : AIS location

*/

private ["_vehObj","_aisLoc","_vehMet","_vehOpt","_locVeh"];
    
_vehObj=_this select 0;
_aisLoc=_this select 1;    

_vehMet=[getPosWorld _vehObj,direction _vehObj,locked _vehObj,typeOf _vehObj,(_vehObj call BIS_fnc_getPitchBank),simulationEnabled _vehObj];
_vehOpt=[];
if (typeName (_vehObj getVariable ["fen_ais_vehicle",""])=="ARRAY") then {
	{
		_vehOpt set [(count _vehOpt),_x];
	} forEach (_vehObj getVariable "fen_ais_vehicle");
};
    
_locVeh=_aisLoc getVariable ["fen_ais_vehicleArray",[]];
_locVeh pushBack [_vehMet,_vehOpt];
_aisLoc setVariable ["fen_ais_vehicleArray",_locVeh];
    
deleteVehicle _vehObj;