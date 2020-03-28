/*

File: fn_moduleTrackHits.sqf
Author: Fen 

Description:
Function for module Track Hits

*/


params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith{};

private _synchronisedOnly=_logic getVariable["synchronisedOnly",true];
private _frequency=_logic getVariable["frequencey",5];
private _hitLife=_logic getVariable["hitLife",30];

missionNamespace setVariable["fen_trackHitsLife",_hitLife,true];

if (_synchronisedOnly) then {
    {
        [_x] remoteExec ["fenTools_fnc_trackHitsAddEvent",0,true];
    } forEach (synchronizedObjects _logic);
} else {
    [_frequency] remoteExec ["fenTools_fnc_trackHitsMonitor",0,true];
};