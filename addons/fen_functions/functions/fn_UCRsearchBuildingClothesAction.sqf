/*

File: fn_UCRsearchBuildingClothesAction.sqf
Author: Fen 

Description:
Called from fn_UCRsearchBuildingClothesMonitor

Parameters:
_this select 0 :
_this select 1 :
_this select 2 :

Example:

*/

_target=param[0,objNull,[objNull]];
_caller=param[1,objNull,[objNull]];
_actionId=param[2,0,[0]];

private _blackListBuildings=player getVariable["fen_UCRsearchBuildingClothesBlackList",[]];
private _chanceNewClothes=player getVariable["fen_UCRseachBuildingClothesChangeNewClothes",25];

if not(([_caller,_blackListBuildings] call fen_fnc_isInsideBuilding)) exitWith{
    hint "You are no longer in the building";
};

[_caller,"AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon"] remoteExec ["playMove",0];

private _uniform=selectRandom (missionNamespace getVariable["INC_civilianUniforms",[]]);
if (not((uniform _caller)==_uniform) and ((random 100)<=_chanceNewClothes)) then {
        _caller forceAddUniform _uniform;
        hint "New clothes found."
} else {
    hint "No clothing found.";
};

_caller removeAction _actionId;

_caller setVariable["fen_UCRsearchBuildingClothesLastPosition",(getPosASL _caller)];
sleep 3;
hint "";