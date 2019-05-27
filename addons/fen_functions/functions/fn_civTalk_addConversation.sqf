/*

File: fn_civtalk_addConversation.sqf
Author: Fen 

Description:
Allows civilian unit to talk to player. (Doesnt have to be a civilian).
Conversations are recorded on the map diary, in the conversation subject heading, along with location, name of civilian and map grid.

Parameters:
_this select 0 : (Object) unit
_this select 1 : (Array) conversation
_this select 2 : (String)optional clause for conversation

Example:
[_unit,["Hello","There where soldiers here yesterday","They went north"]] call fen_fnc_civTalk_addConversation

*/

private ["_unit","_intel","_clause"];

_unit=param[0,objNull,[objNull]];
_intel=param[1,[],[[]]];
_clause=param[2,"",[""]];

if not(local _unit) exitWith {};

[_unit,_intel,_clause] remoteExec ["fen_fnc_civTalk_addAction",0,true];

