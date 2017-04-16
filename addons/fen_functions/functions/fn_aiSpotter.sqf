/*

File: fn_aispotter.sqf
Author: Fen

Description:
Gives an AI unit the ability to use nearby artillery to engage targets.

Parameters:
_this select 0 : (Object) spotter
_this select 1 : (Scalar) maximum range at which spotter will engage targets, default is 1000
_this select 2 : (Scalar) spotter can use artillery within this range, default is 5000
_this select 3 : (Array) types of artillery spotter can call fire from, default is ["O_Mortar_01_F"]
_this select 4 : (Scalar) delay between fire missions, default is 120
_this select 5 : (Side) side to engage with artillery, default is west
_this select 6 : OPTIONAL (Scalar) percentage chance of round landing clear of players and AI, default is 50

Example usage:
[this,1000,5000,["O_Mortar_01_F"],10,west] spawn fen_fnc_aiSpotter

*/

private ["_sptUnt","_sptRng","_calRng","_artTyp","_frqMis","_engSid","_rngCan","_rngMrt","_sptTgt","_allCls","_engCst","_engLoc","_wpnRng","_engArt","_tmploc","_tmpCst","_crwArt","_lstSht","_dirTgt","_dumLoc","_dumTgt","_artMag","_magRnd","_rndX","_rndY","_rndLoc","_rndShl","_subArr","_subRnd","_safRnd","_l","_locFnd"];

_sptUnt=param[0,objNull,[objNull]];
_sptRng=param[1,1000,[0]];
_calRng=param[2,5000,[0]];
_artTyp=param[3,["O_Mortar_01_F"],[[]]];
_frqMis=param[4,120,[0]];
_engSid=param[5,west,[sideLogic]];
_safRnd=param[6,50,[0]];

if not(local _sptUnt) exitWith {};

if (isNil "fen_debug") then {
	fen_debug=false;
};

// define [min,max] range for cannons and mortars
_rngCan=[400,10000]; // cannon
_rngMrt=[100,6000];  // mortar

// define subsitution non-exploding ammo e.g. GRAD rockets (add entries in upper case)
_subArr=["R_GRAD"];
_subRnd="Sh_122_HE";

// marker spotter 
_sptUnt setVariable ["fen_aispotter",true];

// wait before starting to avoid all spotters starting at once
sleep random 180; 

// main loop
while {true} do {
    scopeName "main";
    
    // wait for next fire mission
    sleep _frqMis;
	
    
    if (true) then {
        scopeName "process";
        
        // if spotter dead, end 
        if (not alive _sptUnt) then {
            breakOut "main";
        };
        
        // if no targets, wait and recheck
        _sptTgt=_sptUnt nearTargets _sptRng;
		if ({_x select 2==_engSid} count _sptTgt==0) then {
			if (fen_debug) then {
				diag_log format["aispotter: %1 no targets",_sptUnt];
			};
            breakOut "process";
        };
		
        // build array of crewed artilery in range of spotter
        _crwArt=[];
        {
            if (count crew _x!=0) then {
                _crwArt=_crwArt+[_x];
            };
        } forEach ((position _sptUnt) nearEntities[_artTyp,_calRng]);
		
        // if spotter has no artillery ignore, they maybe in range later
        if (count _crwArt==0) then {
			if (fen_debug) then {
				diag_log format["aispotter: %1 no crewed artillery",_sptUnt];
			};
            breakOut "process";
        };
        
        // find highest priority target known to spotter that can be engaged with artillery
        _engCst=0;
        _engLoc=[];
        {
            if (true) then {
                scopeName "checkTarget";
                
                // ignore if not side to be engaged
                if (_x select 2!=_engSid) then {
                    breakOut "checkTarget";
                };
                
                // ignore air targets 
                if (_x select 1 isKindOf "Air") then {
                    breakOut "checkTarget";
                };
                
                // location of target must be clear of spotters side (200m radius)
                _allCls=_x select 0 nearEntities[["Land"],200];
                if ({side _x==side _sptUnt} count _allCls>0) then {
                    breakOut "checkTarget";
                };
                
                // ignore if not highest priority target 
                if (_x select 3<_engCst) then {
                    breakOut "checkTarget";
                };
                _tmploc=_x select 0;
                _tmpCst=_x select 3;
                
                // build list of artillery than can engage high priority target
                _engArt=[];
                _tmpLoc=_x select 0;
                _tmpCst=_x select 3;
                {
                    // set weapon range
                    _wpnRng=[800,5000];
                    if (_x isKindOf "StaticCannon") then {_wpnRng=_rngCan};
                    if (_x isKindOf "StaticMortar") then {_wpnRng=_rngMrt};
                    
					
                    // add to array of artillery to use if in range 
                    if ((_x distance _tmpLoc)>_wpnRng select 0 and (_x distance _tmpLoc)<_wpnRng select 1) then {
                        _engArt=_engArt+[_x];
                        _engCst=_tmpCst;
                        _engLoc=_tmpLoc;
                    };
                } forEach _crwArt;
            };
        } forEach _sptTgt;
        
        // ignore if no artillery to engage target 
        if (_engCst==0) then {
			if (fen_debug) then {
				diag_log format["aispotter: %1 no targets can be engaged",_sptUnt];
			};
            breakOut "process";
        };
        
        // fire each artillery unit
        {
            if (true) then {
                scopeName "fireArtillery";
                
                // get time artillery last fired
                _lstSht=_x getVariable"fen_aispotter_Chk";
                if (isNil "_lstSht") then {
                    _lstSht=-1;
                    _x setVariable ["fen_aispotter_Chk",_lstSht];
                };
                
                // ingore if fired in last 30 seconds
                if (_lstSht!=-1 and (time-_lstSht)<30) then {
                    breakOut "fireArtillery";
                };
                
                // release artillery from fire mission 
                _x setVariable ["fen_aispotter_Chk",time];
                
                // add eh to remove artillery projectile 
                _x addEventHandler ["fired",{
                    _this spawn {
                        sleep 5;
                        deleteVehicle (_this select 6);
                        (_this select 0) removeAllEventHandlers "fired";
                    }}
                ];

                // create dummy target for artillery to engage
                _dirTgt=[_x,_engLoc] call BIS_fnc_dirTo;
                if (_dirTgt<0) then {_dirTgt=_dirTgt+360};
                if (_dirTgt>360) then {_dirTgt=_dirTgt-360};
                _dumLoc=[_x,1000,_dirTgt] call BIS_fnc_relPos;
                _dumTgt=createVehicle["Land_CncBarrier_F",[_dumLoc select 0,_dumLoc select 1,2000],[],0,"NONE"];
                _dumTgt setPosATL [_dumLoc select 0,_dumLoc select 1,1000];
                
                // fire artillery unit
                group _x reveal [_dumTgt,4];
                _x doWatch _dumTgt;
                sleep 1;
                _x fireAtTarget [_dumTgt];
                _x setVehicleAmmo 1;
				if (fen_debug) then {
					diag_log format["aispotter: %1 fired %2",_sptUnt,_x];
				};


                // remove dummy target 
                deleteVehicle _dumTgt;
                
                // determine shell type for artillery
                _artMag=getArray (configFile >> "CfgVehicles" >> typeOf _x >> "Turrets" >> "MainTurret" >> "magazines");
                _magRnd=getText (configFile >> "CfgMagazines" >> (_artMag select 0) >> "ammo");
		
                // substitute round if non-exploding type
                if (toUpper _magRnd in _subArr) then {
                    _magRnd=_subRnd;
                };
                
				// safe round?
				_locFnd=true;
				if (ceil (random 100)>_safRnd) then {
					// not safe round
					_rndX=[-200,200] call BIS_fnc_randomInt;
					_rndY=[-200,200] call BIS_fnc_randomInt;
					_rndLoc=[(_engLoc select 0)+_rndX,(_engLoc select 1)+_rndY,0];
					if (fen_debug) then {
						diag_log format["aispotter: %1 fired %2 deadly round at %3",_sptUnt,_x,_rndLoc];
					};

				} else {
					// safe round
					_locFnd=false;
					for [{_l=1},{_l<100},{_l=_l+1}] do {
						scopeName "safeLoc";
						_rndX=[-300,300] call BIS_fnc_randomInt;
						_rndY=[-300,300] call BIS_fnc_randomInt;
						_rndLoc=[(_engLoc select 0)+_rndX,(_engLoc select 1)+_rndY];
						if ({_x distance _rndLoc<125} count allUnits==0) then {
							_locFnd=true;
							if (fen_debug) then {
								diag_log format["aispotter: %1 fired %2 safe round at %3",_sptUnt,_x,_rndLoc];
							};
							breakOut "safeLoc";
						};
						sleep 0.03
					};
                };
				
				if (_locFnd) then {
					[[_rndLoc,"mortar1"],"fen_fnc_say3d",false,false] call BIS_fnc_MP;
					sleep 2;
					if (fen_debug) then {
						diag_log format["aispotter: %1 fired %2 round at %3",_sptUnt,_x,_rndLoc];
					};

					if (fen_debug) then {
						[_rndLoc,"AISPOTTER"] call fenTools_fnc_debugmarker;
					};
                
					// spawn shell
					_rndShl=createVehicle[_magRnd,_rndLoc,[],0,"NONE"];
					_rndShl setvelocity [0,0,-30];
					sleep ceil(random 10)+3;
					deleteVehicle _rndShl;
				};
                
            };
            sleep 0.3;
        } forEach _engArt;
    };
};


    
    
    
    