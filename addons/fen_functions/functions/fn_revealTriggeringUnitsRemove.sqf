/*

File: fn_revealTriggeringUnitsRemove
Author: Fen

Description:
Removes group from reveal triggering units queue

Parameters:
_this select 0 : (Group) group to be removed.

Example:


*/
params [
    ["_group",grpNull,[grpNull]]
];

if (isNil "fen_revealTriggeringUnitsQueue") exitWith {};

fen_revealTriggeringUnitsQueue=fen_revealTriggeringUnitsQueue-[_group];
