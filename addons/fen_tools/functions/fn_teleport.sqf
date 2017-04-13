/*

File: fn_teleport.sqf
Author: Fen 

Description:
Teleports player to the position clicked on the map.

Parameters:
none

*/

if not(hasInterface) exitWith {};

titleText ["Open map and click on teleport location", "plain down"];

done = 0;

while {(done == 0)} do {
    onMapSingleClick {
            player setPos _pos;
        done=1;
    };
};

waitUntil {done == 1};
onMapSingleClick {};
titleText ["Teleported to new location.","plain down"];

forceMap false;


