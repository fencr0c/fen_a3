/*

File: fn_civilianAreaQueueHandler
Author: Fen

Description:
Process civilian area queue

Parameters:
none

Example:

*/

while {fen_civilianAreaQueueHandlerRunning} do {

    {
    
        private _trigger=_x;
        
        private _actSid=_trigger getVariable ["fen_civilianArea_actSid",[]];
        
        if (({alive _x and side _x in _actSid and isPlayer _x} count list _trigger)>0) then {
        
            if not((_trigger getVariable ["fen_civilianArea_live",false])) then {
            
                private _civGrp=createGroup civilian;
                civilian setFriend [west,1];
                civilian setFriend [east,1];
                civilian setFriend [resistance,1];
                
                private _araRad=_trigger getVariable "fen_civilianArea_araRad";
                private _maxCiv=_trigger getVariable "fen_civilianArea_maxCiv";
                private _fpsLmt=_trigger getVariable "fen_civilianArea_fpsLmt";
                private _tlkArr=_trigger getVariable "fen_civilianArea_tlkAra";
                private _bldPos=_trigger getVariable "fen_civilianArea_bldPos";
                private _civArr=_trigger getVariable "fen_civilianArea_civArr";
                private _clause=_trigger getVariable "fen_civilianArea_clause";
                
                
                for [{_idx=1},{_idx<=_maxCiv},{_idx=_idx+1}] do {
        
                    sleep 0.03;
        
                    if (diag_fps>_fpsLmt) then {
           
                        private _civTyp=_civArr select floor(random count _civArr);
                        private _spnLoc=[(position _trigger),0,(_araRad/2),1,0,2,0] call BIS_fnc_findSafePos;
                        private _civUnt=_civGrp createUnit[_civTyp,_spnLoc,[],0,"NONE"];
                        removeAllWeapons _civUnt;
                        removeAllItems _civUnt;
			
                        _civUnt setVariable ["NOAI",true];
                        _civUnt setVariable ["VCOM_NOPATHING_Unit",true];
                        _civUnt setVariable ["asr_ai_exclude",true];
			
                        if (count _tlkArr>0) then {
                            if (ceil(random 100)<=50) then {
                            [_civUnt,(selectRandom _tlkArr),_clause] call fen_fnc_civTalk_addConversation;
                            };
                        };
                    };
                };
	
                [_civGrp,(position _trigger),_araRad,_bldPos] spawn	fen_fnc_civilianArea_group;
                
                _trigger setVariable ["fen_civilianArea_civGrp",_civGrp];
                _trigger setVariable ["fen_civilianArea_live",true];
                
            };
        } else {
        
            private _civGrp=_trigger getVariable ["fen_civilianArea_civGrp",grpNull];
            {
                deletevehicle _x;
            } forEach units _civGrp;
            
            if (typeName _civGrp=="GROUP") then {
                if ({alive _x} count units _civGrp==0) then {
                    deleteGroup _civGrp;
                };
            };
            
            _trigger setVariable ["fen_civilianArea_civGrp",nil];
            _trigger setVariable ["fen_civilianArea_live",false];
            
        };
        
        sleep 0.03;
        
    } forEach fen_civilianAreaQueue;
    
    sleep 5;
};