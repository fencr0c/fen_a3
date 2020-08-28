/*

File: fn_handleMines.sqf
Author: Fen

Description:
Function for handling caching and spawning mines

Parameters:
_this select 0 : promixity (scalar)

*/

params [
    ["_proximity",500,[0]],
    ["_frequencey",5,[0]]
];

while {true} do {

    sleep _frequency;

    {
        if (([_x select 1,_proximity] call fen_fnc_playerNearMinePosition)) then {
            [_x] call fen_fnc_spawnMine;
        };
    } forEach (missionNamespace getVariable["fen_cachedMines",[]]);

    {
        if (not([(getPos _x),_proximity] call fen_fnc_playerNearMinePosition)) then {
            [_x] call fen_fnc_addCachedMine;
        };
    } forEach allMines;

};
