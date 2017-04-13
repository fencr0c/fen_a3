/*

File: fn_moduleSuicideBomber.sqf
Author: Fen 

Description:
Function for module SuicideBomber

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _bombJacket=_logic getVariable ["bombJacket",false];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{ 
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[leader %1," + 
				format["%1",_bombJacket] +
				"] spawn fen_fnc_suicideBomber;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_bombJacket] spawn fen_fnc_suicideBomber;
	};
} forEach _localunits;

	