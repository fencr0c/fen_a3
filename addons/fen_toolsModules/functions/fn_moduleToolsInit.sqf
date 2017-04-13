/*

File: fn_moduleToolsInit.sqf
Author: Fen 

Description:
Function for module Tools Init

*/


params [
	["_logic",objNull,[objNull]]
];

diag_log format["fn_moduleToolsInit hasInterface %1",hasInterface]; // debug delete me 
diag_log format["fn_moduleToolsInit editorOnly %1",_logic getVariable ["editorOnly","not found"]]; // debug delete me 

private _editorOnly=_logic getVariable ["editorOnly",false];

if (_editorOnly) then {
	if (isServer and hasInterface) then {
		fen_debug=true;
		publicVariable "fen_debug";
		[] spawn fenTools_fnc_toolsInit;
	};
} else {
	if (isServer) then {
		fen_debug=true;
		publicVariable "fen_debug";
		[] remoteExec ["fenTools_fnc_toolsInit",0,true];
	};
};



