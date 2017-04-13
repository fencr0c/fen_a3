/*

File: fn_moduleInit.sqf
Author: Fen 

Description:
Function for module Init

*/


params [
	["_logic",objNull,[objNull]]
];

private _useHc=_logic getVariable ["useHC",false];

if (isDedicated) then {
	if (_useHc) then {
		private _countHC=count (entities "HeadlessClient_F");
		if (_countHC==0) then {
			if (isServer) then {
				[] spawn fenAIS_fnc_init;
			};
		} else {
			private _hcOwner=owner (entities "HeadlessClient_F" select 0);
			[true] remoteExec ["fenAIS_fnc_init",_hcOwner];
		};
	} else {
		if (isServer) then {
			[true] spawn fenAIS_fnc_init;
		};
	};
} else {
	if (isServer) then {
		[true] spawn fenAIS_fnc_init;
	};
};
