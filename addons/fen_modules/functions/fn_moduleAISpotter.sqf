/*

File: fn_moduleAISpotter.sqf
Author: Fen 

Description:
Function for module AISpotter

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};
private _spotRange=_logic getVariable ["spotRange",1000];
private _callRange=_logic getVariable ["callRange",5000];
private _artilleryTypes=[_logic getVariable ["ArtilleryTypes","['O_Mortar_01_F']"]] call BIS_fnc_parseNumber;
if (typeName _artilleryTypes!="ARRAY") then {
	_artilleryTypes=["O_Mortar_01_F"];
};
private _frequency=_logic getVariable ["frequency",120];
private _engageSide=[_logic getVariable ["engageSide",west]] call BIS_fnc_parseNumber;
if (typeName _engageSide!="SIDE") then {
	_engageSide=west;
};
private _safeRound=_logic getVariable ["safeRound",50];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
	if (_includeAIS) then {
		private _grpOtions=["exec:"];
		
		private _parameters="[leader %1," + 
				str _spotRange + "," +
				str _callRange + "," + 
				format["%1",_artilleryTypes] + "," + 
				str _frequency + "," + 
				str _engageSide + "," +
				str _safeRound + 
				"] spawn fen_fnc_aiSpotter;";
		
		_grpOtions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOtions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOtions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_spotRange,_callRange,_artilleryTypes,_frequency,_engageSide,_safeRound] spawn fen_fnc_aiSpotter;
	};
} forEach _localunits;


