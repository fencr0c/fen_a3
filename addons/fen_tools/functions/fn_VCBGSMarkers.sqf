/*

File: fn_VCBGSMarkers.sqf
Author: Fen

Description:
Function for marking all VCB ground sign objects in mission

*/

private _markerPrefix="fen_VCBGSMarker_";
while {true} do {
  {
    deleteMarker _x;
  } forEach (allMapMarkers select {((_x find _markerPrefix)>=0)});

  {
    deleteVehicle _x;
  } forEach (allmissionObjects "Sign_Arrow_F");

  private _markerNumber=0;
  {
    _markerNumber=_markerNumber+1;
    private _markerName=str _markerPrefix + str _markerNumber;
    private _marker=createMarker [_markerName,position _x];
    _marker setMarkerType "hd_dot";
    _marker setMarkerColor "colorRed";
    _marker setMarkerText "VCBGS";
    _marker setMarkerSize [0.75,0.75];
    createVehicle ["Sign_Arrow_F",(getMarkerPos _marker),[],0,"CAN_COLLIDE"];

  } forEach (allMines select {([_x] call fen_fnc_isVCBGroundSign)});

  sleep 10;
};
