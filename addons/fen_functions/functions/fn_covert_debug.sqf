/*

File: fn_covert_debug.sqf
Author: Fen 

Description:
Display covert debug data to user for testing.

Parameters:

*/

if not(hasInterface) exitWith {};

if (isNil "fen_covert_debug") then {
	fen_covert_debug=false;
};

private _lastDebugTime=0;

while {true} do {

	if not(fen_covert_debug) then {
		waitUntil {
			sleep 3;
			fen_covert_debug;
		};
	};
	
	private _debugData="";
	
	waitUntil {
		sleep 0.5;
		_debugData=player getVariable ["fen_covert_debugData",[0,"waiting","waiting","waiting","waiting"]];
		(_debugData select 0)!=_lastDebugTime;
	};
	
	_lastDebugTime=_debugData select 0;
	
	hintSilent parseText format["
		<t align='centre'>Covert Debug:<br/></tr>
		<t align='centre'>----------------<br/></tr>
		<t align='left'> Time:</t><t align='right'>%1<br/></t>
		<t align='left'> Rating:</t><t align='right'>%2<br/></t>
		<t align='left'> Safe:</t><t align='right'>%3<br/></t>
		<t align='left'> Have Weapon:</t><t align='right'>%4<br/></t>
		<t align='left'> Known [seen,hostile]:</t><t align='right'>%5<br/></t>
		<t align='left'> Side:</t><t align='right'>%6<br/></t>
		<t align='left'> Penalty:</t><t align='right'>%7<br/></t>
		",
		_debugData select 0,
		_debugData select 1,
		captive player,
		_debugData select 2,
		_debugData select 3,
		side player,
		_debugData select 4
		];
	
	sleep 1;
};
