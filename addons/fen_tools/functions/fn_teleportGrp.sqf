/*

File: fn_teleportGrp.sqf
Author: Fen 

Description:
Teleports player and units of there group to the position clicked on the map.

Parameters:
none

*/

if not(hasInterface) exitWith {};

titleText ["Open map and click on teleport location", "plain down"];

done = 0;

while {(done == 0)} do {
    onMapSingleClick {
        if (isDedicated) then {
            player setPos _pos;
        } else {
            {_x setPos _pos} forEach units group player;
        };
        done=1;
    };
};

waitUntil {done == 1};
onMapSingleClick {};
titleText ["Teleported to new location.","plain down"];

forceMap false;


