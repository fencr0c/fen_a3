/*

File: fn_rollingBarrage.sqf
Author: Fen

Description:
Creates a rolling barrage of artillery

Parameters:
_this select 0 : (Array) start location [bottom left]
_this select 1 : (Scalar) direction of barrage
_this select 2 : (Scalar) x axis number of shells
_this select 3 : (Scalar) x axis shell spacing
_this select 4 : (Scalar) x axis seconds between shells
_this select 5 : (Scalar) y axis number of rows
_this select 6 : (Scalar) Y axis row spacing
_this select 7 : (Scalar) seconds between rows
_this select 8 : (String) shell class

Example:
[[1000,1000],0,10,5,1,10,10,1,"Sh_82mm_AMOS"] spawn fen_fnc_rollingBarrage

*/

private ["_linDir","_idy","_rowLoc","_strLoc","_barDir","_xNmShl","_xSpShl","_yNmRow","_ySpRow","_shlCls","_rowDly","_xShDly"];

_strLoc=param[0,[0,0,0],[[]],[2,3]];
_barDir=param[1,0,[0]];
_xNmShl=param[2,10,[0]];
_xSpShl=param[3,10,[0]];
_xShDly=param[4,1,[0]];
_yNmRow=param[5,5,[0]];
_ySpRow=param[6,5,[0]];
_rowDly=param[7,1,[0]];
_shlCls=param[8,"Sh_82mm_AMOS",[""]];

_rowLoc=_strLoc;
_linDir=_barDir+90;
switch true do {
    case (_linDir<0) : {_linDir=_linDir+360};
    case (_linDir>360) : {_linDir=_linDir-360};
}; 

for [{_idy=1},{_idy<=_yNmRow},{_idy=_idy+1}] do {
    
    [_rowLoc,_linDir,_xNmShl,_xSpShl,_xShDly,_shlCls] spawn fen_fnc_artilleryLine;
    
    sleep _rowDly;
    _rowLoc=[_rowLoc,_ySpRow,_barDir] call BIS_fnc_relPos;
};


