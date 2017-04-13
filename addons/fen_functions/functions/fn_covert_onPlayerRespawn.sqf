/*

File: fn_covert_onPlayerRespawn.sqf
Author: Fen 

Description:
Used by fn_covert to handle player respawns

Parameters:
none
*/

if (hasInterface) then {
	
	player addEventHandler ["FiredMan",{
		if (captive player) then {
			player setCaptive 0; 
			player setVariable ["fen_covert_suspicionRating",fen_covert_ratingMax,true];
		}
	}];

	player forceAddUniform (player getVariable ["fen_covert_uniform",""]);

	player setVariable["fen_covert_suspicionRating",0,true];
	player setCaptive 1;
	
	if (player hasWeapon "ACE_FakePrimaryWeapon") then {
		player removeWeapon "ACE_FakePrimaryWeapon";
	};
};