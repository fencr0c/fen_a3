/*

File: fn_moduleRetreatGroup.sqf
Author: Fen 

Description:
Function for module RetreatGroup

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _proximity=_logic getVariable ["proximity",300];
private _proximitySides=[_logic getVariable ["proximitySides",[west]]] call BIS_fnc_parseNumber;
if (typeName _proximitySides!="ARRAY") then {
	_proximitySides=[west];
};
private _percentage=_logic getVariable ["percentage",50];
private _retreatAction=_logic getVariable ["_retreatAction",false];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};


{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				"[" + format["%1",_proximitySides] + "," + str _proximity + "]," + 
				str _percentage + "," + 
				format["%1",position _logic] + "," +
				format["%1",_retreatAction] +
				"] spawn fen_fnc_retreatGroup;";
		
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[group _x,[_proximitySides,_proximity],_percentage,position _logic,_retreatAction] spawn fen_fnc_retreatGroup;
	};
} forEach _localunits;

	