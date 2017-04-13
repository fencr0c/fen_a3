/*

File: fn_createLocation.sqf
Author: Fen 

Description:
Defines game logic/logic/location/area as an AIS location.
To be used on the game logic/location/area init box.

Parameters:
_this select 0 : object
_this select 1 : activation radius, default 1500
_this select x : paired parameters to set other values (optional)
				 "sides:",[east,west]		array of sides that will activate the location (default is west)
				 "trigger:",triggername		name of trigger that will also activate location along with radius
				 "script:","script.sqf"		name of script to be executed on activate location	
				 "ai:", true or false		can be activated by AI units of side (default is false)
				 "balance:", true or false	turn on/off dynamic balancing (default is off)
				 "maxplayers:", number		max players override for dynamic balancing
				 "despawn:",true or false	allows a location to despawn vehicles and groups is no longer triggered (default is false)

Examples:
	[this] call fen_fnc_createLoation
	[this,1500] call fen_fnc_createLocation
	[this,1500,"sides:",[west,independant] call fen_fnc_createLocation
	[this,1500,"trigger:",trigger01] call fen_fnc_createLocation 
	[this,1500,"script:","scipts\script.sqf"] call fen_fnc_createLocation 
	[this,1500,"ai:",true] call fen_fnc_createLocation
	[this,1500,"balance:",true] call fen_fnc_createLocation 
	[this,1500,"maxplayers:",30] call fen_fnc_createLocation
	[this,1500,"despawn:",true] call fen_fnc_createLocation
	
*/

private ["_location","_idx"];

_location=param[0,objNull];
_radius=param[1,1500];

if (isNull _location) exitWith {};

_location setVariable ["fen_ais_location",_radius];
_location setVariable ["fen_ais_balance",false];

_idx=2;
while {_idx<count _this} do {

	switch (toLower (_this select _idx)) do {
	
		case "sides:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_enemy",(_this select _idx),true];
		};
		case "trigger:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_trigger",(_this select _idx),true];
		};
		case "script:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_script",(_this select _idx),true];
		};
		case "ai:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_byAI",(_this select _idx),true];
		};
		case "balance:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_balance",(_this select _idx),true];
		};
		case "maxplayers:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_maxPlayers",(_this select _idx),true];
		};
		case "despawn:" : {
			_idx=_idx+1;
			_location setVariable ["fen_ais_allowDespawn",(_this select _idx),true];
			
		};
		
	};
	_idx=_idx+1;

};