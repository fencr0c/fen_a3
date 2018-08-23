/*

File: fn_locationGrabber.sqf
Author: Fen 

Description:
Grabs AIS Location Variables for non-active locations and copies to clipboard.

Parameters:
none

*/
private _br=toString [13,10];
private _tab=toString [9];
private _string="";

player sideChat "Starting AIS Location Data Capture";

for [{_z=0},{_z<count fen_ais_locations},{_z=_z+1}] do {

    private _location=fen_ais_locations select _z;
    
    if ((_location getVariable ["fen_ais_locationTriggered",false])) then {
        player sideChat format["Location %1 ignored, active.",_location];
    } else {
    
        // groupArray
        private _groupArray=_location getVariable ["fen_ais_groupArray",[]];

        // fen_ais_group output formatting
        if (count _groupArray>0) then {
            
            _string=_string + str _location + " setVariable[""fen_ais_groupArray"",[" + _br;

            for [{_a=0},{_a<count _groupArray},{_a=_a+1}] do {

                _string=_string +_tab + "[" + _br;
                
                // group
                _string=_string + _tab + _tab + "[" + _br;
                private _groupData=(_groupArray select _a) select 0;
                for [{_b=0},{_b<count _groupData},{_b=_b+1}] do {
                     _string=_string + _tab + _tab + _tab + str(_groupData select _b);
                    if (_b<(count _groupData)-1) then {
                        _string=_string + ",";
                    };
                    _string=_string + _br;
                };
                _string=_string + _tab + _tab + "]," + _br;
                       
                // waypoint
                _string=_string + _tab + _tab + "[";
                private _groupWayPoints=(_groupArray select _a) select 1;
                if ((count _groupWayPoints)>0) then {
                    _string=_string + _br;
                };
                for [{_b=0},{_b<count _groupWayPoints},{_b=_b+1}] do {
                    _string=_string + _tab + _tab + _tab + str(_groupWayPoints select _b);
                    if (_b<(count _groupWayPoints)-1) then {
                        _string=_string + ",";
                    };
                    _string=_string + _br;
                };
                if ((count _groupWayPoints)>0) then {
                    _string=_string + "," + _tab + _tab;
                };
                _string=_string + "]," + _br;
                
                // optional
                private _groupOptional=(_groupArray select _a) select 2;
                _string=_string + _tab + _tab + str(_groupOptional) + _br;
                
                _string=_string + _tab + "]";
                if (_a<(count _groupArray)-1) then {
                    _string=_string + ",";
                };
                _string=_string + _br;

            };
            
            _string=_string + "]];" + _br;
            
        };

        // vehicle array
        private _vehicleArray = _location getVariable["fen_ais_vehicleArray",[]];

        if (count _vehicleArray>0) then {
            
            _string=_string + str _location + " setVariable[""fen_ais_vehicleArray"",[" + _br;
            
            for [{_a=0},{_a<count _vehicleArray},{_a=_a+1}] do {

                _string=_string +_tab + "[" + _br;

                private _vehicleData=(_vehicleArray select _a) select 0;
                _string=_string + _tab + _tab + str(_vehicleData) + "," + _br; 
                
                private _vehicleOptional=(_vehicleArray select _a) select 1;
                _string=_string + _tab + _tab + str(_vehicleOptional) + _br;
                
                _string=_string +_tab + "]";
                if (_a<(count _vehicleArray)-1) then {
                    _string=_string + ",";
                };
                _string=_string + _br;
            };
            
            _string=_string + "]];" + _br;
            
        };
    };
};

copyToClipboard _string;

player sideChat "Finished AIS Location Data Capture, clipboard updated.";