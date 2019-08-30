/*

File: fn_UCRsearchBuildingClothesMonitor.sqf
Author: Fen 

Description:
Allows players to randomly search for UCR civ uniforms when inside a building.
Required INCON UCR


Parameters:
_this select 0 : (array) array of building classes where search not available

Example:

*/

waitUntil {
    count (missionNamespace getVariable["INC_civilianUniforms",[]])>0;
};

params [
    ["_blackList",[],[[]]],
    ["_chanceNewClothes",25,[0]]
];

if not(hasInterface) exitWith {};

player setVariable["fen_UCRsearchBuildingClothesLastPosition",(getPosASL player)];
player setVariable["fen_UCRsearchBuildingClothesBlackList",_blackList];
player setVariable["fen_UCRseachBuildingClothesChangeNewClothes",_chanceNewClothes];

private _actionId=nil;
while {true} do {

    if (([player,_blackList] call fen_fnc_isInsideBuilding)) then {
        if ((getPosASL player) distance (player getVariable["fen_UCRsearchBuildingClothesLastPosition",[0,0,0]])>5) then {
            if (isNil "_actionId") then {
                _actionId=player addAction ["Search for clothing",fen_fnc_UCRsearchBuildingClothesAction,[],0,false,true,""];
            };
        };
    } else {
        if not(isNil "_actionId") then {
            player removeAction _actionId;
            _actionId=nil;
        };
    };
    sleep 2;
};