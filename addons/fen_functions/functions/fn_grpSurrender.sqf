/*

File: fn_grpSurrender.sqf
Author: Fen

Description:
Causes a group to surrnder when condition is met.

Parameters:
_this select 0 : (Group) Group
_this select 1 : (String) Condition to cause surrender. Variable _group can be used in condition
_this select 2 : (String) Optional command to run on surrender Variable _group can be used in string

Example:

	nul0=[group this,"{alive _x} count units _group<3","{[_x,['You win','I surrender']] spawn fen_fnc_civTalk_addConversation} forEach units _group"] spawn fen_fnc_grpSurrender;
	
*/

params[
["_group",grpNull,[grpNull]],
["_conditionString","",[""]],
["_commandString","",[""]]
];

if not(local leader _group) exitWith {};

private _condition="";
if (_conditionString!="") then {
_condition=compile _conditionString;
};

private _command="";
if (_commandString!="") then {
_command=compile _commandString;
};

private _surrendered=false;
while {{alive _x} count units _group>0 and not _surrendered;} do {

	if ([] call _condition) then {
		{
			if (alive _x) then {
				doStop _x;
				_x removeWeapon (currentWeapon _x);
				_x action ["surrender",_x];
			};
		} forEach units _group;
		_surrendered=true;
		if (_commandString!="") then {
			call _command;
		};
	};
	sleep 3;
};
