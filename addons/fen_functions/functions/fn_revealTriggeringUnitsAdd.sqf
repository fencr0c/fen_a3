/*

File: fn_revealTriggeringUnitsAdd
Author: Fen

Description:
Adds group to the reveal triggering units queue.

Parameters:
_this select 0 : (group) Reveal units triggering to this group
_this select 1 : (array) Array of triggers
_this select 2 : (boolean) Use line of sight
_this select 2 : (boolean) Exclude air (optional)


Example:
[_group,[trg1,trg2,trg3],true,true] spawn fen_fnc_revealTriggeringUnitsAdd;

*/

params [
    ["_group",grpNull,[grpNull]],
    ["_triggers",[],[[]]],
    ["_useLOS",false,[true]],
    ["_excAir",true,[false]]
];

if not(local leader _group) exitWith {};

if (isNil "fen_debug") then {
    fen_debug=false;
};

if (count _triggers==0) exitWith {};

_group setVariable ["fen_revealTriggeringUnits_triggers",_triggers];
_group setVariable ["fen_revealTriggeringUnits_useLOS",_useLOS];
_group setVariable ["fen_revealTriggeringUnits_excAir",_excAir];


if (isNil "fen_revealTriggeringUnitsQueue") then {
    fen_revealTriggeringUnitsQueue=[];
};

 fen_revealTriggeringUnitsQueue pushBackUnique _group;

if (isNil "fen_revealTriggeringUnitsQueueHandlerRunning") then {
    fen_revealTriggeringUnitsQueueHandlerRunning=false;
};

if not(fen_revealTriggeringUnitsQueueHandlerRunning) then {
    fen_revealTriggeringUnitsQueueHandlerRunning=true;
    [] spawn fen_fnc_revealTriggeringUnitsQueueHandler;
};