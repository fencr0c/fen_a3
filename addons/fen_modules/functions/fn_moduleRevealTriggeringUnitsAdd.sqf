/*

File: fn_moduleRevealTriggeringUnitsAdd.sqf
Author: Fen 

Description:
Function for module RevealTriggeringUnitsAdd

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};


private _localUnits=_units select {local _x};
private _revealTriggers=[_logic getVariable ["revealTriggers","[]"]] call BIS_fnc_parseNumber;
if (typeName _revealTriggers!="ARRAY") then {
    _revealTriggers=[];
};
private _useLOS=_logic getVariable ["useLOS",false];
private _excludeAir=_logic getVariable ["excludeAir",true];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
    private _unit=_x;
    if (_includeAIS) then {
        private _grpOptions=["exec:"];
          
        private _parameters="[%1," +
        format ["%1",_revealTriggers] + "," +
        format ["%1",_useLOS] + "," +
        format ["%1",_excludeAir] + 
        "] spawn fen_fnc_revealTriggeringUnitsAdd;";
                   
        _grpOptions pushBack _parameters;
            
        if (_owningLocation isEqualTo objNull) then {
            [_unit,_grpOptions] call fenAIS_fnc_group;
        } else {
            [_unit,_grpOptions,_owningLocation] call fenAIS_fnc_group;
        };
    } else {
        [group _unit,_revealTriggers,_useLOS,_excludeAir] spawn fen_fnc_revealTriggeringUnitsAdd;
    };
} forEach _localUnits;