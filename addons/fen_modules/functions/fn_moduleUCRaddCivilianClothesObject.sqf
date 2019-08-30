/*

File: fn_moduleUCRaddCivilianClothesObject.sqf
Author: Fen 

Description:
Function for module UCRAddCivilianClothesObject

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _minimum=_logic getVariable["minimum",0];
private _maximum=_logic getVariable["minimum",0];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
	if (_includeAIS) then {
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				"[" + str _minimum + "," + str _maximum + "]" +
				"] spawn fen_fnc_UCRaddCivilianClothesObject;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_vehicle;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_vehicle;
		};
	} else {
		[_x,[_minimum,_maximum]] spawn fen_fnc_UCRaddCivilianClothesObject;
	};
} forEach _localunits