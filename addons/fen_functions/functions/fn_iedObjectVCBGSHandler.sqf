/*

File: fn_iedObjectVCBGSHandler.sqf
Author: Fen

Description:
Controls spawning an despawing of VCB ground sign cache

Parameters:
none
*/

private _proximity=missionNamespace getVariable["fen_iedObjectVCBGSProximity",800];
private _frequency=missionNamespace getVariable["fen_iedObjectVCBGSFrequency",5];

while {(missionNamespace getVariable["fen_iedObjectVCBGSHandler_running",false])} do {

  sleep _frequency;

  {
    if (([_x select 1,_proximity] call fen_fnc_playerNearMinePosition)) then {
        [_x] call fen_fnc_iedObjectVCBGSSpawn;
    };
  } forEach (missionNamespace getVariable["fen_iedObjectVCBGSCache",[]]);

  {
    if not([(getPos _x),_proximity] call fen_fnc_playerNearMinePosition) then {
      [_x] call fen_fnc_iedObjectVCBGSDespawn;
    };
  } forEach (allMines select {[_x] call fen_fnc_isVCBIED});
};
