/*

File: fn_moduleIEDMan.sqf
Author: Fen 

Description:
Function for module IEDMan

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _iedPosition=position _logic;
private _iedClasses=[_logic getVariable ["iedClasses",["IEDLandBig_F","IEDLandBigF"]]] call BIS_fnc_parseNumber;
if (typeName _iedClasses!="ARRAY") then {
	_iedClasses=["IEDLandBig_F","IEDLandBigF"];
};
private _startTrigger=_logic getVariable ["startTrigger",""] call BIS_fnc_parseNumber;
if (typeName _startTrigger!="OBJECT") then {
	_startTrigger=objNull;
};

private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[leader %1," + 
				format["%1",position _logic] + "," +
				format["%1",_iedClasses] + "," + 
				(_logic getVariable ["startTrigger","missing"]) + 
				"] spawn fen_fnc_iedMan;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		
		[_x,position _logic,_iedClasses,_startTrigger] spawn fen_fnc_iedMan;
	};
} forEach _localunits;

	