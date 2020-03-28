/*

File: fn_moduleVIR
Author: Fen

Description:
Function for module VIRQueueAdd

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

if (hasInterface and not isServer) exitwith {};

private _localUnits=_units select {local _x};
private _localGroups=[];
{
	_localGroups pushBackUnique (group _x);
} forEach _localUnits;

private _crewDisembark=_logic getVariable["crewDisembark",true];
private _proximity=_logic getVariable["proximity",750];
private _convoyNumber=_logic getVariable["convoyNumber",1];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
  if (_includeAIS) then {
		private _grpOptions=["exec:"];

			private _parameters="[%1," +
			format["%1,",_crewDisembark] +
			str _proximity + "," +
			str _convoyNumber +
			"] spawn fen_fnc_VIRQueueAdd;";

			_grpOptions pushBack _parameters;

			if (_owningLocation isEqualTo objNull) then {
				[leader _x,_grpOptions] call fenAIS_fnc_group;
			} else {
				[leader _x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
	} else {
		[_x,_crewDisembark,_proximity,_convoyNumber] spawn fen_fnc_VIRQueueAdd;
	};
} forEach _localGroups;
