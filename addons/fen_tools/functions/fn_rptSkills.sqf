/*

File: fn_rptSkills.sqf
Author: Fen 

Description:
Reports all units skill levels to the rpt file.

Parameters:
none

*/

private ["_sTypes","_untIdn","_untTxt","_dryTxt"];

_sTypes=[
	"aimingAccuracy",
    "aimingShake",
    "aimingSpeed",
    "endurance",
    "spotDistance",
    "spotTime",
    "courage",
    "reloadSpeed",
    "commanding",
    "general"
];

_dryTxt="";

if (isNil "fen_reportSkill") then {
	player createDiarySubject ["reportSkills","Report Skills"];
};

player sideChat "Report Skills Started";
{
    if (side _x!=side player) then {
        {
            if (alive _x) then {
                _untIdn=_x;
				_dryTxt=_dryTxt+"<br/>";
                {
					_untTxt=format["Unit %1 Skill %2 Level %3",_untIdn,_x,_untIdn skill _x];
                    diag_log format["rptskills: %1",_untTxt];
					_dryTxt=_dryTxt+_untTxt+"<br/>";
                } forEach _sTypes;
            };
        } forEach (units _x);
    };
} forEach allGroups;

player createDiaryRecord["reportSkills",[format["Report Skills %1",([daytime] call BIS_fnc_timeToString)],_dryTxt]];
player sideChat "Report Skills Finished";

