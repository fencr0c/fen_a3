/*

File: fn_enemyMarkers.sqf
Author: Fen 

Description:
Start script to display all units on map not on the players side.

Parameters:
none

*/


private ["_colArr","_lstCol","_mrkArr","_l","_grpTxt","_txtArr","_mrkNam"];

if not(hasInterface) exitWith {};

_colArr=[
    "ColorBlack",
    "ColorRed",
    "ColorGreen",
    "ColorBlue" ,
    "ColorYellow", 
    "ColorOrange",
    "ColorWhite",
    "ColorPink",
    "ColorBrown", 
    "ColorKhaki" 
];

_mrkArr=[];

while {fen_tools_enemyMarkersOn} do {
    
    // delete markers 
    {
        deleteMarkerLocal _x;
    } forEach _mrkArr;

    _lstCol=-1;
    
    // put markers 
    {

        // not players side or civilians
        //if (side _x!=side player and side _x!=civilian) then {
		if (side _x!=side player) then {
            
            // assign colour
            _lstCol=_lstCol+1;
            if (_lstCol==count _colArr) then {
                _lstCol=0;
            };
            
            // units in group 
            {
                // only mark alive units 
                if (alive _x) then {
                    
                    // if group leader
                    if (leader group _x==_x) then {
                        
                        // strip leading 2 characters from group name
                        _txtArr=toArray str group _x;
                        _grpTxt=[];
                        for [{_l=2},{_l<count _txtArr},{_l=_l+1}] do {
                            //_grpTxt set[count _grpTxt,_txtArr select _l];
							_grpTxt pushBack (_txtArr select _l);
                        };
                        _grpTxt=toString _grpTxt;
                        
                        // create group marker
                        _mrkNam=format["fen_untMrk_%1",str group _x];
                        createMarkerLocal [_mrkNam,position leader group _x];
                        _mrkNam setMarkerShapeLocal "ICON";
                        _mrkNam setMarkerTypeLocal "B_INF";
                        _mrkNam setMarkerSizeLocal [0.8,0.8];
                        _mrkNam setMarkerTextLocal _grpTxt;
                        _mrkNam setMarkerColorLocal (_colArr select _lstCol);
                        _mrkArr set[count _mrkArr,_mrkNam];
                    } else {
                        
                        // if not in vehicle draw unit arrow
                        if (vehicle _x==_x) then {
                            _mrkNam=format["fen_untMrk_%1",str _x];
                            createMarkerLocal [_mrkNam,position _x];
                            _mrkNam setMarkerShapeLocal "ICON";
                            _mrkNam setMarkerTypeLocal "mil_triangle";
                            _mrkNam setMarkerSizeLocal [0.8,0.8];
                            _mrkNam setMarkerColorLocal (_colArr select _lstCol);
                            _mrkNam setMarkerDirLocal direction _x;
                            _mrkArr set[count _mrkArr,_mrkNam];    
                            
                        };
                    };
                };
            } foreach units _x;
        };
    } forEach allGroups;
    sleep 10;
};

// delete markers 
{
    deleteMarkerLocal _x;
} forEach _mrkArr;


