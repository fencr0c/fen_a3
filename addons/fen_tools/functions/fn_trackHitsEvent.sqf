/*

File: fn_trackHitsAddEvent.sqf
Author: Fen 

Description:
Function for adding event handler to object

*/

params [
    ["_hitPartArray",[],[[]]]
];


if not(hasInterface) exitWith{};

{
    private _hitPartTarget=_x select 0;
    private _hitPartPosition=_x select 3;
    
    private _hitPartMarker=createVehicle ["Sign_Sphere10cm_F",_hitPartPosition,[],0,"CAN_COLLIDE"];
    _hitPartMarker setPosASL _hitPartPosition;
    
    [_hitPartMarker,_hitPartTarget] call BIS_fnc_attachToRelative;
    
    //[_hitPartMarker] spawn {
    //  sleep (missionNamespace getVariable["fen_trackHitsLife",30]);
    //  deleteVehicle (_this select 0);
    //};
    [_hitPartMarker] remoteExec ["fenTools_fnc_trackHitsRemoveMarker",2];
} forEach _hitPartArray;