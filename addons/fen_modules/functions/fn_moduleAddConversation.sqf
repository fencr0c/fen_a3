/*

File: fn_moduleAddConversation.sqf
Author: Fen 

Description:
Function for module AddConversation

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};

private _conversation=[_logic getVariable ["conversation",[]]] call BIS_fnc_parseNumber;
if (typeName _conversation!="ARRAY") then {
	_conversation=["Something went wrong"];
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
				format["%1",_conversation] + 
				"] spawn fen_fnc_civTalk_addConversation;";
	
		_grpOptions pushBack _parameters;
		
		if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_conversation] spawn fen_fnc_civTalk_addConversation;
	};
} forEach _localunits;

	