/*

File: fn_factionSides.sqf
Author: Fen 

Description:
Returns side of thing, using faction override

Parameters:
_this select 0 : thing unit or object

*/

private ["_object","_side","_idx"];
 
_object=_this select 0;
    
_side=side _object;

if not(isNil "fen_ais_factionSides") then {

	_idx=fen_ais_factionSides find (faction _object);
	if (_idx>=0) then {
		_idx=_idx+1;
		
		if (typeName (fen_ais_factionSides select _idx)=="SIDE") then {
			_side=fen_ais_factionSides select _idx;
		};
	};
};

_side
