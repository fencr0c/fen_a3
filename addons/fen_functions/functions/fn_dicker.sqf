/*

File: fn_dicker.sqf
Author: Fen

Description:
Turns civilian unit into a dicker
Dicker will observer and follow movement of players, reporting position to nearby enemy groups.

Parameters:
_this select 0 : (Object) dicker unit
_this select 1 : (Scalar) percentage change of passing on intel, default is 75
_this select 2 : (Array) sides to update with intel, default is [east]
_this select 3 : (Scalar) updates groups with x meters, default is 1000
_this select 4 : (Scalar) frequency to check dicker for targets, default is 10

Example:
[_unit,75,[east,resistance],1000,10] spawn fen_fnc_dicker

*/

private ["_dicUnt","_prcInt","_frqChk","_strLoc","_binRng","_sidUpd","_maxRng","_movPrc","_genMov","_manMov","_vehMov","_knwUnt","_knwRat","_dicMov","_knwDta"];

waitUntil {not isNil "bis_fnc_init"};

_dicUnt=param[0,objNull,[objNull]];
_prcInt=param[1,75,[0]];
_sidUpd=param[2,[east],[[]]];
_maxRng=param[3,1000,[0]];
_frqChk=param[4,10,[0]];

if not(local _dicUnt) exitWith {};

if (isNil "fen_debug") then {
    fen_debug=false;
};

_strLoc=getPos _dicUnt;


removeAllWeapons _dicUnt;
removeAllItems _dicunt;
_dicUnt addWeapon "Binocular";
_dicUnt setCombatMode "GREEN";
_dicUnt setBehaviour "CARELESS";
_dicUnt allowFleeing 0;

_binRng=200;
_movPrc=65;
_binRng=200;
_genMov=[100,250];
_manMov=[50,250];
_vehMov=[250,350];

sleep 5;

fen_fnc_dicker_end={
    
private ["_dicEnd","_dicUnt"];
_dicUnt=_this select 0;
    
    _dicEnd=false;
    if not(alive _dicUnt) then {
        _dicEnd=true;
    };
    
    _dicEnd
};


fen_fnc_dicker_knowPlayers={
    
    private ["_knwAbt","_knwUnt","_knwRat","_knwDst","_dicUnt"];
    
    _dicUnt=_this select 0;
    
    _knwUnt="";
    _knwRat=0;
    _knwDst=999999999;
    
    {
        
        _knwAbt=_dicUnt knowsAbout _x;
        
        if (vehicle _x!=_x) then {
            if not(vehicle _x isKindOf "Air") then {
                _knwAbt=_dicUnt knowsAbout _x;
            };
        };
        
        if (alive _x and _knwAbt>0 and (_x distance _dicUnt)<_knwDst) then {
            _knwUnt=_x;
            _knwRat=_knwAbt;
            _knwDst=_x distance _dicUnt;
        };
    } forEach ([] call BIS_fnc_listPlayers);
    
    [_knwUnt,_knwRat];
};


fen_fnc_dicker_watch={
    
    private ["_dicUnt","_knwUnt","_binRng","_dirKnw"];

    _dicUnt=_this select 0;
    _knwUnt=_this select 1;
    _binRng=_this select 2;
    
    _dirKnw=[_dicUnt,_knwUnt] call BIS_fnc_dirTo;
        switch true do {
        case (_dirKnw<0) : {_dirKnw=_dirKnw+360};
        case (_dirKnw>360) : {_dirKnw=_dirKnw-360};
    };

    if (_dicUnt isKindOf "man") then {
        _dicUnt setDir _dirKnw;
        _dicUnt setPosAsl getPosAsl _dicUnt;
        _dicUnt doWatch _knwUnt;

        if (_dicUnt isKindof "man" and _dicUnt distance _knwUnt>_binRng) then {
            _dicUnt addWeapon "Binocular";
            waitUntil {
                sleep 0.3;
                _dicUnt hasWeapon "Binocular" or not(alive _dicUnt);
            };
            _dicUnt selectWeapon "Binocular";
        } else {
            if (_dicUnt isKindOf "man" and _dicUnt hasWeapon "Binocular") then {
                _dicUnt removeWeapon "Binocular";
            };
        };
        
        if (fen_debug) then {
            player sideChat format["dicker: %1 watching %2 has bino %3",_dicUnt,_knwUnt,(_dicUnt hasWeapon "Binocular")];
        };

    };
    sleep 2;
};

fen_fnc_dicker_move={
    
    private ["_knwUnt","_dicUnt","_movPrc","_genMov","_manMov","_vehMov","_movDir","_movDst","_movLoc","_intLoc","_rndDir","_dicMov","_movCnt"];
    
    _dicUnt=_this select 0;
    _knwUnt=_this select 1;
    _movPrc=_this select 2;
    _genMov=_this select 3;
    _manMov=_this select 4;
    _vehMov=_this select 5;
    
    _dicMov=false;
    if (ceil(random 100)<=_movPrc) then {

        if (_dicUnt distance _knwUnt<_genMov select 0 or _dicUnt distance _knwUnt>_genMov select 1) then {
            
            if (_dicUnt distance _knwUnt<_genMov select 0) then {
                _movDir=[_knwUnt,_dicUnt] call BIS_fnc_dirTo;
                switch true do {
                    case (_movDir<0) : {_movDir=_movDir+360};
                    case (_movDir>360) : {_movDir=_movDir-360};
                };
            } else {
                _movDir=[_dicUnt,_knwUnt] call BIS_fnc_dirTo;
                switch true do {
                    case (_movDir<0) : {_movDir=_movDir+360};
                    case (_movDir>360) : {_movDir=_movDir-360};
                };
            };
            
            _rndDir=[-30,30] call BIS_fnc_RandomInt;
            _movDir=_movDir+_rndDir;
            switch true do {
                case (_movDir<0) : {_movDir=_movDir+360};
                case (_movDir>360) : {_movDir=_movDir-360};
            };
            
            if (_dicUnt isKindOf "man") then {
                _movDst=_manMov call BIS_fnc_randomInt;
            } else {
                _movDst=_vehMov call BIS_fnc_randomInt;
            };
            
            if (_dicUnt distance _knwUnt<_genMov select 0) then {
                _intLoc=[position _knwUnt,_movDst,_movDir] call BIS_fnc_relPos;
            } else {
                _intLoc=[position _dicUnt,_movDst,_movDir] call BIS_fnc_relPos;
            };
            _movLoc=[_intLoc,0,50,10,0,9,0] call BIS_fnc_findSafePos;
            if (_intLoc distance _movLoc>50) then {
                _movLoc=_intLoc;
            };
            if (_dicUnt hasWeapon "Binocular") then {
                _dicUnt removeWeapon "Binocular";
            };
            
            _dicUnt doWatch objNull;
			_dicUnt doMove _movLoc;
            waitUntil {
                sleep 3;
                unitReady _dicUnt or not(alive _dicUnt)
            };
            if (fen_debug) then {
                _movCnt=_dicUnt getVariable ["fen_dicker_movCnt",0];
                _movCnt=_movCnt+1;
                [position _dicUnt,(format["Dicker %1 Move %2 ",str _dicUnt,_movCnt])] call fenTools_fnc_debugmarker;
                _dicUnt setVariable ["fen_dicker_movCnt",_movCnt];
            };
        };
    };
    _dicMov
};

fen_fnc_dicker_passIntel={
    private ["_dicUnt","_knwUnt","_knwRat","_prcInt","_sidUpd","_maxRng"];

    _dicUnt=_this select 0;
    _knwUnt=_this select 1;
    _knwRat=_this select 2;
    _prcInt=_this select 3;
    _sidUpd=_this select 4;
    _maxRng=_this select 5;
    
    if (ceil(random 100)<=_prcInt) then {
        {
            if (side _x in _sidUpd and _dicUnt distance leader _x<_maxRng) then {
                leader _x reveal [_knwUnt,_knwRat];
                if (fen_debug) then {
                    player sideChat format["dicker: %1 passing on %2 to %3",_dicUnt,_knwUnt,leader _x];
                };
            };
        } forEach allGroups;
    };
};


while {true} do {
    scopeName "doDicker";
    
    sleep _frqChk;
    
    if ([_dicUnt] call fen_fnc_dicker_end) then {
        breakOut "doDicker";
    };
    
    _knwDta=[_dicUnt] call fen_fnc_dicker_knowPlayers;
    if (_knwDta select 1>0) then {
        
        _knwUnt=_knwDta select 0;
        _knwRat=_knwDta select 1;
       
        [_dicUnt,_knwUnt,_binRng] call fen_fnc_dicker_watch;

        if ([_dicUnt] call fen_fnc_dicker_end) then {
            breakOut "doDicker";
        };
        
        _dicMov=[_dicUnt,_knwUnt,_movPrc,_genMov,_manMov,_vehMov] call fen_fnc_dicker_move;
        
        if ([_dicUnt] call fen_fnc_dicker_end) then {
            breakOut "doDicker";
        };
        
        if (_dicMov) then {
            [_dicUnt,_knwUnt,_binRng] call fen_fnc_dicker_watch;
        };
        
        if ([_dicUnt] call fen_fnc_dicker_end) then {
            breakOut "doDicker";
        };
        
        [_dicUnt,_knwUnt,_knwRat,_prcInt,_sidUpd,_maxRng] call fen_fnc_dicker_passIntel;

    } else{

        if (_dicUnt distance _strLoc>30) then {
            _dicUnt doMove _strLoc;
        };
        
    };
};

if (fen_debug) then {
    player sideChat format["dicker: %1 ended",_dicUnt];
};

