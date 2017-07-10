/*

File: fn_moduleToolsInit.sqf
Author: Fen 

Description:
Function for module Tools Init

*/


params [
	["_logic",objNull,[objNull]]
];

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



