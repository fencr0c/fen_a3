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
private _proximityWest=_logic getVariable ["proximityWest",false];
private _proximityEast=_logic getVariable ["proximityEast",false];
private _proximityGuer=_logic getVariable ["proximityGuer",false];
private _proximityCiv=_logic getVariable ["proximityCiv",false];
private _percentage=_logic getVariable ["percentage",50];
private _retreatAction=_logic getVariable ["_retreatAction",false];
private _includeAIS=_logic getVariable ["includeAIS",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

private _proximitySides=[];
if (_proximityWest) then {
	_proximitySides pushBack west;
};
if (_proximityEast) then {
	_proximitySides pushBack east;
};
if (_proximityGuer) then {
    if (_includeAIS) then {
        _proximitySides pushBack "independent";
    } else {
        _proximitySides pushBack independent;
    };
};
if (_proximityCiv) then {
	_proximitySides pushBack civilian;
};

{ 
	if (_includeAIS) then {
    
        private _proximitySidesStr="[";
        for "_idx" from 0 to (count _proximitySides - 1) do {
            if not(str (_proximitySides select _idx)=="GUER") then {
                _proximitySidesStr=_proximitySidesStr + format["%1",(_proximitySides select _idx)];
            } else {
                _proximitySidesStr=_proximitySidesStr + format["%1","independent"];
            };
            if (_idx<(count _proximitySides - 1)) then {
                _proximitySidesStr=_proximitySidesStr + ",";
            };
        };
        _proximitySidesStr=_proximitySidesStr + "]";
        
		private _grpOptions=["exec:"];
		
		private _parameters="[%1," + 
				"[" + format["%1",_proximitySidesStr] + "," + str _proximity + "]," + 
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

	