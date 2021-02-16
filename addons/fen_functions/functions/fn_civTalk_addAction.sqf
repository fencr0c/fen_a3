/*

File: fn_civtalk_addAction.sqf
Author: Fen

Description:
Adds Action to civilian units to allow conversation, see fen_fnc_civtalk_addConversation

Parameters:
_this select 0 : (Object) unit
_this select 1 : (Array) conversation
_this select 2 : (String) optional clause for conversation

*/

private ["_unit","_intel","_clause"];

_unit=param[0,objNull,[objNull]];
_intel=param[1,[],[[]]];
_clause=param[2,"",[""]];
_completionVariable=param[3,"",[""]];

if (hasInterface) then {
	_unit addAction ["Talk to Unit",fen_fnc_civTalk_speak,[_intel,_clause,_completionVariable],99,true,true,"","alive _target",3];
};
