/*

File: fn_playersInTrigger.sqf
Author: Fen

Description:
Returns array of players of a side within a trigger.

Parameters:
_this select 0 : (Object) trigger
_this select 1 : (Side) side of players to return

Example:
_arrayPlayers=[trigger,west] call fen_fnc_playersInTrigger;

*/

private ["_trigger","_side","_playersArr"];

_trigger=param[0,objNull,[objNull]];
_side=param[1,west,[sideLogic]];

if (isNil "fen_debug") then {
    fen_debug=false;
};

_playersArr=[];
if (triggerActivated _trigger) then {

	{
		if (_x isKindOf "Man") then {
			if (isPlayer _x) then {
				_playersArr pushBack _x;
			};
		} else {
			{
				if (isPlayer _x) then {
					_playersArr pushBack _x;
				};
			} forEach (crew _x);
		};
	} forEach (list _trigger);
};

_playersArr