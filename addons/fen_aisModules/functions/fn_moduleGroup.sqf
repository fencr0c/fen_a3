/*

File: fn_moduleGroup.sqf
Author: Fen 

Description:
Function for module Group

*/


params [
	["_logic",objNull,[objNull]],
	["_units",[],[[]]]
];

// server only
if not(isServer) exitWith{};

{
	{
		doStop _x;
	} forEach units group _x;
} forEach _units;

private _command=_logic getVariable ["command",""];
private _doStop=_logic getVariable ["doStop",false];
private _sentry=_logic getVariable ["sentry",false];
private _sentryRange=_logic getVariable ["sentryRange",0];
private _sentryTriggers=[_logic getVariable ["sentryTriggers","[]"]] call BIS_fnc_parseNumber;
if (typeName _sentryTriggers!="ARRAY") then {
	_sentryTriggers=[];
};
private _VCOMoff=_logic getVariable ["VCOMoff",false];
private _VCOMnopath=_logic getVariable ["VCOMnopath",false];
private _excludeASR=_logic getVariable ["excludeASR",false];
private _excludeBalancing=_logic getVariable ["excludeBalancing",true];
private _combatMode=_logic getVariable ["combatMode","YELLOW"];
private _behaviour=_logic getVariable ["behaviour","AWARE"];
private _loadOut=_logic getVariable ["loadout",false];
private _owningLocation=[_logic getVariable ["owningLocation",objNull]] call BIS_fnc_parseNumber;
if (typeName _owningLocation!="OBJECT") then {
	_owningLocation=objNull;
};

private _options=[];
if (_command!="") then {
	_options pushBack "exec:";
	_options pushBack _command;
};
if (_doStop) then {
	_options pushBack "stop:";
};
if (_sentry) then {
	_options pushBack "sentry:";
	_options pushBack [_sentryRange,_sentryTriggers];
};
if (_VCOMoff) then {
	_options pushBack "vcom_off:";
};
if (_VCOMnopath) then {
	_options pushBack "vcom_nopath:";
};
if (_excludeASR) then {
	_options pushBack "asr_exclude:";
};
if (_excludeBalancing) then {
	_options pushBack "nobalance:";
};
if (_combatMode!="") then {
	_options pushBack "combatmode:";
	_options pushBack _combatMode;
};
if (_behaviour!="") then {
	_options pushBack "behaviour:";
	_options pushBack _behaviour;
};
if (_loadout) then {
	_options pushBack "loadout:";
};

private _groups=[];
{
	if not(group _x in _groups) then {
        if (_owningLocation isEqualTo objNull) then {
            [_x,_options] call fenAIS_fnc_group;
        } else {
            [_x,_options,_owningLocation] call fenAIS_fnc_group;
        };
       _groups pushBack (group _x);
    };
} forEach _units;
