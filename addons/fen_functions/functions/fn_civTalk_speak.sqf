/*

File: fn_civtalk_speak.sqf
Author: Fen 

Description:
Handles conversaton called from addAction, see fen_fnc_civTalk_addConversation

Parameters:
_this select 0 : (Object) target i.e. the civilian
_this select 1 : (Object) caller i.e. the player
_this select 3 : (Array) conversation

*/

private ["_target","_intel","_caller","_subject","_text"];

_target=param[0,objNull,[objNull]];
_caller=param[1,objNull,[objNull]];
_intel=param[3,[],[[]]];

if not(hasInterface) exitWith {};

if isNil("fen_civTalk_lastCiv") then {
	fen_civTalk_idx=0;
} else {
	if (fen_civTalk_lastCiv!=str _target) then {
		fen_civTalk_idx=0;
	};
};

if (count _intel==0) exitWith {
	hint "Civilian has nothing to say.";
};

if (fen_civTalk_idx==count _intel) exitWith {
	hint "I have nothing more to say. Goodbye.";
	[_target,1.4] remoteExec ["forceSpeed",_target];
};

[_target,0] remoteExec ["forceSpeed",_target];
[_target,_caller] remoteExec ["doWatch",_target];
hint (_intel select fen_civTalk_idx);

if not(_caller diarySubjectExists "civChatLog") then {
	_caller createDiarySubject ["civChatLog","Conversation History"];
};
if (isNil "fen_civTalk_talkedWith") then {
	fen_civTalk_talkedWith=[];
};
if not(_target in fen_civTalk_talkedWith) then {
	_subject=format["%1/%2/GR%3",text (nearestLocations [_caller,["nameVillage","nameCity"],500] select 0),name _target,mapGridPosition (getPos _target)];
	_text="<br/>"+_subject+"<br/>";
	{
		_text=_text+"<br/>"+_x;
	} forEach _intel;
	_caller createDiaryRecord ["civChatLog",[_subject,_text]];	
	fen_civTalk_talkedWith pushBack _target;
};

[_target,_caller] spawn {
	private ["_target","_caller"];
	
	_target=_this select 0;
	_caller=_this select 1;
	
	waitUntil {
		sleep 30;
		not(alive _target) or (_caller distance _target>20);
	};
	
	[_target,1.4] remoteExec ["forceSpeed",_target];
	[_target,objNull] remoteExec ["doWatch",_target];
};

fen_civTalk_idx=fen_civTalk_idx+1;
fen_civTalk_lastCiv=str _target;
