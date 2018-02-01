/*

File: fn_moduleFowardObs.sqf
Author: Fen

Description:
Function for module ForwardObs

*/

params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];


// exclude player (i.e. include servers and headless clients)
if (hasInterface and not isServer) exitWith {};

private _localunits=_units select {local _x};
private _engageRange=_logic getVariable ["engageRange",1500];
private _artilleryTypes=[_logic getVariable ["artilleryTypes","['O_Mortar_01_F']"]] call BIS_fnc_parseNumber;
if (typeName _artilleryTypes!="ARRAY") then {
    _artilleryTypes=["O_Mortar_01_F"];
};
private _callingRange=_logic getVariable ["callingRange",5000];
private _delayFireMission=_logic getVariable ["delayFireMission",120];
private _dfpTriggers=[_logic getVariable ["dfpTriggers","[]"]] call BIS_fnc_parseNumber;
if (typeName _dfpTriggers!="ARRAY") then {
    _dfpTriggers=[];
};
private _skillLevel=_logic getVariable ["skillLevel",2];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

{
    if (_includeAIS) then {
        private _grpOptions=["exec:"];
        
        private _parameters="[leader %1," +
            str _engageRange + "," + 
            format["%1",_artilleryTypes] + "," +
            str _callingRange + "," +
            str _delayFireMission + "," + 
            format["%1",_dfpTriggers] + "," +
            str _skillLevel + 
            "] spawn fen_fnc_forwardObs;";
            
        _grpOptions pushBack _parameters;
        
        if (_owningLocation isEqualTo objNull) then {
			[_x,_grpOptions] call fenAIS_fnc_group;
		} else {
			[_x,_grpOptions,_owningLocation] call fenAIS_fnc_group;
		};
    } else {
        [_x,_engageRange,_artilleryTypes,_callingRange,_delayFireMission,_dfpTriggers,_skillLevel] spawn fen_fnc_forwardObs;
    };
} forEach _localunits;