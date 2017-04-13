/*

File: fn_sentryQueueRemove.sqf
Author: Fen 

Description:
Removes a group from the sentry processing queue

Parameters:
_this select 0 : group

*/

params [
	["_group",grpNull,[grpNull]]
];

if (isNil "fen_ais_sentryQueue") exitWith {};

fen_ais_sentryQueue=fen_ais_sentryQueue-[_group];
