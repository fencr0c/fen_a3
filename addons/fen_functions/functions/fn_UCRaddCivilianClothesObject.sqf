/*

File: fn_UCRaddCivilianClothesObject.sqf
Author: Fen 

Description:
Adds random INC UCR civilian uniforms to an object.


Parameters:
_this select 0 : (object) container

Example:

*/

waitUntil {
    count (missionNamespace getVariable["INC_civilianUniforms",[]])>0;
};

params [
    ["_container",objNull,[objNull]],
    ["_minMax",[1,5],[[]]]
];

if not(local _container) exitWith {};

_numberOfUniforms=selectRandom _minMax;
for "_i" from 1 to _numberOfUniforms do {
    private _uniform=selectRandom (missionNamespace getVariable["INC_civilianUniforms",[]]);
    _container addItemCargoGlobal [_uniform,1];
};
    