/*

File: fn_VIRQueueHandler.sqf
Author: Fen

Description:
Handler for VIR

Parameters:
none
*/

while {fen_VIRQueueRunning} do {

    {
      private _group=_x;

      if ({alive _x} count units _group==0) then {
          [_group] call fen_fnc_revealTriggeringUnitsRemove;
      } else {
        private _proximity=_group getVariable["fen_VIRProximity",750];
        if (count([leader _group,_proximity] call fen_fnc_neartargets)>0) then {
          [_group] call fen_fnc_VIRQueueRemove;
          [_group,_proximity] spawn fen_fnc_VIRInContact;

          private _inContactPacket=_group getVariable["fen_VIRPacket","none"];
          if not(typeName _inContactPacket=="STRING") then {
            {
              private _groupPacket=_x getVariable["fen_VIRPacket","none"];
              if not(typeName _groupPacket=="STRING") then {
                if (_groupPacket==_inContactPacket) then {
                  [_x] call fen_fnc_VIRQueueRemove;
                  [_x,_proximity] spawn fen_fnc_VIRInContact;
                };
              };
            } forEach fen_VIRQueue;
          };
        };
      };

    } forEach fen_VIRQueue;

    if (count fen_VIRQueue==0) then {
      fen_VIRQueueRunning=false;
    };

    sleep 2;
};
