/*

File: fn_sentryGrabber.sqf
Author: Fen 

Description:
Use to collect info for use with the fn_spawnSentries

Place group of playerable units on map, switch between units and move into required position, then use this to grab the data required for fn_spawnSentries.

Parameters:
none

*/

private ["_untSid","_untTyp","_untDir","_untLoc","_lstGrp","_newGrp","_lstVeh","_addUnt","_untStn"];

diag_log "+++++++++++++++++++++++++++";
diag_log "+++ Start of swtgrabber +++";
diag_log "+++++++++++++++++++++++++++";
diag_log "for man [side, position, direction, class, new group, no move, unit stance (optional)]";
diag_log "for veh [side, position, direction, class, new group, no move]";

player sideChat "Capturing Switchable";

{
 
    _addUnt=false;
    _untSid=side _x;
    _untDir=getDir _x;
    _untLoc=getPosASL _x;
    
    switch true do {
        case (isNil "_lstGrp") : {_newGrp=true};
        case (group _x!=_lstGrp) : {_newGrp=true};
        default {_newGrp=false};
    };

    _lstGrp=group _x;
    
    
    switch true do {
        case (vehicle _x==_x) : {_untTyp=typeOf _x;_addUnt=true};
        case (isNil "_lstVeh") : {_untTyp=typeOf vehicle _x;_untDir=getDir vehicle _x;_addUnt=true;_lstVeh=vehicle _x};
        case (vehicle _x!=_lstVeh) : {_untTyp=typeOf vehicle _x;_untDir=getDir vehicle _x;_addUnt=true;_lstVeh=vehicle _x};
    };
    
    _untStn=unitPos _x;

    if (_addUnt) then {
        
        switch true do {
            case (str _untSid=="CIV") : {_untSid="civilian"};
            case (str _untSid=="GUER") : {_untSid="resistance"};
            case (str _untSid=="EAST") : {_untSid="east"};
            case (str _untSid=="WEST") : {_untSid="west"};
        };
        
        if (_untTyp isKindOf "Man") then {
            diag_log format["[%1,%2,%3,""%4"",%5,%6,""%7""],",_untSid,_untLoc,_untDir,_untTyp,_newGrp,"false",_untStn];
        } else {
            diag_log format["[%1,%2,%3,""%4"",%5],",_untSid,_untLoc,_untDir,_untTyp,_newGrp,"false"];
        };
    };

} forEach switchableUnits;

diag_log "+++++++++++++++++++++++++++";
diag_log "++++ End of swtgrabber ++++";
diag_log "+++++++++++++++++++++++++++";

player sideChat "Switchable Captured";
