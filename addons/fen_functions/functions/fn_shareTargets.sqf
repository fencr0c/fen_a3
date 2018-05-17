/*

File: fn_shareTargets
Author: Fen

Description:
Allows AI to share target info with nearby friendly units

Parameters:
_this select 0 : (Group) group to be removed.

Example:
[[east,independent],60,200,600] spawn fen_fnc_shareTargets

*/

params [
    ["_sides",[west,east,independent],[[]]],
    ["_frequency",60,[0]],
    ["_broadcastRange",200,[0]],
    ["_visibleRange",600,[0]]
];

if not(isServer) exitWith {};

while {true} do {

    sleep _frequency;
    {   
        private _group=_x;
        {
            sleep 0.03;
            private _targetData=_x;
            if ([side _group,(_targetData select 2)] call BIS_fnc_sideIsEnemy) then {
                private _knowsAbout=(leader _group) knowsAbout (_targetData select 4);
                if (_knowsAbout>0) then {
                    {
                        [leader _x,[(_targetData select 4),_knowsAbout]] remoteExec ["reveal",(leader _x)]; 
                    } forEach (allGroups select {(leader _group distance leader _x<=_broadcastRange) and ([side _group,side _x] call BIS_fnc_sideIsFriendly) and not(isPlayer (leader _x))});
                };
            };
        } forEach (leader _group nearTargets _visibleRange);
    } forEach (allGroups select {side _x in _sides});
}; 
