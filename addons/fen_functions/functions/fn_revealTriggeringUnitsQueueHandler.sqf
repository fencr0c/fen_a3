/*

File: fn_revealTriggeringUnitsQueueHandler
Author: Fen

Description:
Process reveal triggering units queue handler

Parameters:
none

Example:

*/

if (isNil "fen_debug") then {
    fen_debug=false;
};

while {fen_revealTriggeringUnitsQueueHandlerRunning} do {

    {

        private _group=_x;
                    
        if ({alive _x} count units _group==0) then {
            [_group] call fen_fnc_revealTriggeringUnitsRemove;
        } else {
        
            private _triggers=_group getVariable ["fen_revealTriggeringUnits_triggers",[]];
            private _useLOS=_group getVariable ["fen_revealTriggeringUnits_useLOS",false];
            private _excAir=_group getVariable ["fen_revealTriggeringUnits_excAir",true];
            
            {
                private _trigger=_x;
               
                if (count (list _x)!=0) then {
                    {
                        private _triggeringUnit=_x;
                        
                        if ((not _excAir) or (_excAir and not(_triggeringUnit isKindOf "Air"))) then {
                            private _reveal=false;
                            if (_useLOS) then {
                                {
                                    if (([objNull,"VIEW",_x] checkVisibility [(eyePos _x),(eyePos _triggeringUnit)])==1) exitWith {
                                        _reveal=true;
                                    };
                                } forEach units _group;
                            } else {
                                _reveal=true;
                            };
                            if (_reveal) then {
                                [(leader _group),[_triggeringUnit,4]] remoteExec ["reveal",(leader _group)];
                                _triggers=_triggers-[_trigger];
                            };
                        };
                    } forEach list _trigger;
                };
            } forEach _triggers;
            _group setVariable ["fen_revealTriggeringUnits_triggers",_triggers];
        
        };
        
        if (count (_group getVariable ["fen_revealTriggeringUnits_triggers",[]])==0) then {
            [_group] call fen_fnc_revealTriggeringUnitsRemove;
        };
        
        sleep 5;
        
    } forEach fen_revealTriggeringUnitsQueue;

};
