/*

File: fn_sentryQueueAdd.sqf
Author: Fen 

Description:
Adds a group to the sentry processing queue

Parameters:
_this select 0 : group
_this select 1 : release range

*/

params [
	["_group",grpNull,[grpNull]],
	["_releaseData",[0,[]],[[]]]
];

//if (_range==0) exitWith {};
if ((_releaseData select 0==0) and (count (_releaseData select 1)==0)) exitWith {};

if (isNil "fen_ais_sentryQueue") then {
	fen_ais_sentryQueue=[];
};

fen_ais_sentryQueue pushBackUnique _group;
//_group setVariable ["fen_ais_sentryGroupData",[_range,count units _group]];
_group setVariable ["fen_ais_sentryGroupData",[_releaseData,count units _group]];

if (isNil "fen_ais_sentryQueueHandlerRunning") then {
	fen_ais_sentryQueueHandlerRunning=false;
};

if not(fen_ais_sentryQueueHandlerRunning) then {
	fen_ais_sentryQueueHandlerRunning=true;
	[] spawn fenAIS_fnc_sentryQueueHandler;
};

