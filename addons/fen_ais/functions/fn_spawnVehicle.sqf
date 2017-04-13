/*

File: fn_spawnVehicle.sqf
Author: Fen 

Description:
Spawns AIS vehicle

Parameters:
_this select 0 : vehicle data array
_this select 1 : AIS location

*/

private ["_vehDta","_vehMet","_vehOpt","_spnVeh","_idx","_locVeh","_aisLoc"];
    
_vehDta=_this select 0;
_aisLoc=_this select 1;
    
_vehMet=_vehDta select 0;
_vehOpt=_vehDta select 1;
_spnVeh=createVehicle [(_vehMet select 3),(_vehMet select 0),[],0,"CAN_COLLIDE"];
_spnVeh enableSimulationGlobal (_vehMet select 5);
_spnVeh allowDamage false;
_spnVeh setDir (_vehMet select 1);
_spnVeh lock (_vehMet select 2);
_spnVeh setPosWorld (_vehMet select 0);
_spnVeh allowDamage true;
_spnVeh setVariable ["fen_ownedBy",(str _aisLoc)];
[_spnVeh,(_vehMet select 4) select 0,(_vehMet select 4) select 1] call BIS_fnc_setPitchBank;	
    
_idx=0;
while {_idx<count _vehOpt} do {
        
	switch (toLower (_vehOpt select _idx)) do {
		case "exec:" : {
			_idx=_idx+1;
			call compile format[(_vehOpt select _idx),"_spnVeh"];
		};
	};
	_idx=_idx+1;
};
    
_locVeh=_aisLoc getVariable ["fen_ais_vehicles",[]];
_locVeh pushBack _spnVeh;
_aisLoc setVariable ["fen_ais_vehicles",_locVeh];

if ((_aisLoc getVariable ["fen_ais_allowDespawn",false])) then {
	if (count _vehOpt==0) then {
		_spnVeh setVariable ["fen_ais_vehicle",true];
	} else {
		_spnVeh setVariable ["fen_ais_vehicle",_vehOpt];
	};
};