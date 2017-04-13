/*

File: fn_artilleryLine.sqf
Author: Fen

Description:
Spawns a line of artillery shells

Parameters:
_this select 0 : (Array) location 
_this select 1 : (Scalar) azimuth 
_this select 2 : (Scalar) number of shells 
_this select 3 : (Scalar) spacing between shells 
_this select 4 : (Scalar) seconds between shells 
_this select 5 : (String) shell class

Example:
[[1000,1000],0,5,10,1,"Sh_82mm_AMOS"] spawn fen_fnc_artilleryLine

*/

private ["_idx","_strLoc","_shlDir","_numShl","_shlSpc","_artShl","_shlLoc","_shlDly"];

_strLoc=param[0,[0,0,0],[[]],[2,3]];
_shlDir=param[1,0,[0]];
_numShl=param[2,5,[0]];
_shlSpc=param[3,10,[0]];
_shlDly=param[4,1,[0]];
_artShl=param[5,"Sh_82mm_AMOS",[""]];

_shlLoc=_strLoc;
for [{_idx=1},{_idx<=_numShl},{_idx=_idx+1}] do {
    
    [_shlLoc,_artShl] spawn {
       
        private ["_shlLoc","_artShl","_rndShl"];
        
        _shlLoc=_this select 0;
        _artShl=_this select 1;
        
         if (ceil random 2>1) then {
             [[_shlLoc,"mortar1"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
             sleep 2;
         };
        
        _rndShl=createVehicle[_artShl,_shlLoc,[],0,"CAN_COLLIDE"];
        _rndShl setvelocity [0,0,-30];
        sleep 360;
        deleteVehicle _rndShl;
    };
    
    sleep _shlDly;
    _shlLoc=[_shlLoc,_shlSpc,_shlDir] call BIS_fnc_relPos;
    
};


