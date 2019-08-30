/*

File: fn_moduleUCRSearchBuildingClothes
Author: Fen 

Description:
Function for module SearchBuildingClothes

*/

params [
	["_logic",objNull,[objNull]]
];

if not(isServer) exitWith {};

private _buildingBlackList=[_logic getVariable ["buildingBlackList",[]]] call BIS_fnc_parseNumber;
if (typeName _buildingBlackList!="ARRAY") then {
	_buildingBlackList=["Something went wrong"];
};
private _chanceNewClothes=_logic getVariable ["chanceNewClothes",25];

[_buildingBlackList,_chanceNewClothes] remoteExec ["fen_fnc_UCRsearchBuildingClothesMonitor",0,true];

