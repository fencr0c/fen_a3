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

diag_log format["fn_iedObjectVCBGSHandler starting"]; //debugdeleteme

while {(missionNamespace getVariable["fen_iedObjectVCBGSHandler_running",false])} do {

  diag_log format["fn_iedObjectVCBGSHandler execution frequency %1",_frequency]; //debugdeleteme
  sleep _frequency;

  {
    diag_log format["fn_iedObjectVCBGSHandler checking spawn in for  %1",_x]; //debugdeleteme
    if (([_x select 1,_proximity] call fen_fnc_playerNearMinePosition)) then {
        diag_log format["fn_iedObjectVCBGSHandler spawning in %1",_x]; //debugdeleteme
        [_x] call fen_fnc_iedObjectVCBGSSpawn;
    };
  } forEach (missionNamespace getVariable["fen_iedObjectVCBGSCache",[]]);

  {
    diag_log format["fn_iedObjectVCBGSHandler checking despawn in for  %1",_x]; //debugdeleteme
    if not([(getPosWorld _x),_proximity] call fen_fnc_playerNearMinePosition) then {
      diag_log format["fn_iedObjectVCBGSHandler despawning %1",_x]; //debugdeleteme
      [_x] call fen_fnc_iedObjectVCBGSDespawn;
    };
  } forEach (allMines select {[_x] call fen_fnc_isVCBGroundSign});
};
diag_log format["fn_iedObjectVCBGSHandler ended"]; //debugdeleteme
