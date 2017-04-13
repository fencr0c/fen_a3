/*

File: fn_covert.sqf
Author: Fen 

Description:
use for SFSG missions to control players sides, assumption is that all players are on same side.

Parameters:
_this select 0 : SFSG side when overt (Side)
_this select 1 : SFSG side when covert (Side)
_this select 2 : sides of enemies (Array)
_this select 3 : restrict all items factions (Array)
_this select 4 : user defined restricted items (Array)
_this select 5 : user defined unrestricted items (Array)
_this select 6 : restricted vehicle factions (Array)
_this select 7 : low supsicion trigger/markers areas (Array)
_this select 8 : medium suspicion trigger/markers areas (Array)
_this select 9 : high suspicion trigger/markers areas (Array)
_this select 10 : restricted trigger/markers areas (Array)

Instructions:

	Add to init.sqf:
	[west,civilian,[east],[],[],[],[],[],[],[]] spawn fen_fnc_covert;

	// covert - initialise players
	[] spawn fen_fnc_covert_initPlayer;

	Add to onPlayerKilled.sqf
	[] spawn fen_fnc_covert_onPlayerKilled;
	
	Add to onPlayerRespawn.sqf
	[] spawn fen_fnc_covert_onPlayerRespawn;
	
	Add to ini.sqf if you want to debug.
	if (hasInterface) then {
		[] spawn fen_fnc_covert_debug;
	};
	
*/

params [
	["_SFSGSideOvert",west,[sideLogic]],
	["_SFSGSideCovert",civilian,[sideLogic]],
	["_enemySides",[east],[[]]],
	["_restrictedItemFactions",["UK_ARMED_FORCES"],[[]]],
	["_restrictedItems",[],[[]]],
	["_unrestrictedItems",[],[[]]],
	["_restrictedVehicleFactions",[],[[]]],
	["_lowSuspicionAreas",[],[[]]],
	["_mediumSuspicionAreas",[],[[]]],
	["_highSuspicionAreas",[],[[]]],
	["_restrictedAreas",[],[[]]]
];

if (isNil "fen_covert_debug") then {
	fen_covert_debug=false;
};

// parameters (do not change here, add them into init.sqf)
if (isNil "fen_covert_frequencey") then {
	fen_covert_frequency=2;														// frequency ratings are adjusted
};
if (isNil "fen_covert_ratingMax") then {
	fen_covert_ratingMax=2000;													// maximum rating
};
publicVariable "fen_covert_ratingMax";
if (isNil "fen_covert_ratingSwitch") then {
	fen_covert_ratingSwitch=400;												// rating at which player switches between covert/overt
};
if (isNil "fen_covert_penaltyDecay") then {	
	fen_covert_penaltyDecay=50;													// Decay value for reducing penalty
};
if (isNil "fen_covert_penaltyPrimaryWeapon") then {
	fen_covert_penaltyPrimaryWeapon=100;										// penalty for being observed with  primary weapon
};
if (isNil "fen_covert_penaltySecondaryWeapon") then {
	fen_covert_penaltySecondaryWeapon=100;										// penalty for being observed with secondary weapon
};
if (isNil "fen_covert_penaltyHandGunDrawn") then {
	fen_covert_penaltyHandGunDrawn=25;											// penalty for being observed with drawn hand gun
};
if (isNil "fen_covert_bonusWeaponLowered") then {
	fen_covert_bonusWeaponLowered=12;											// bonus for weapon lowered
};
if (isNil "fen_covert_checkTargetRange") then {
	fen_covert_checkTargetRange=300; 											// only query enemy units within x for player for known
};
if (isNil "fen_covert_overtRange") then {
	fen_covert_overtRange=50; 													// range to check for overt players and apply overt penalty
};
if (isNil "fen_covert_penaltyProximity") then {
	fen_covert_penaltyProximity=30;												// maximum penalty for observed proximity to enemy (reduced by distance)
};
if (isNil "fen_covert_penaltyLowSuspicionArea") then {
	fen_covert_penaltyLowSuspicionArea=5;										// penalty for being observed in low suspicion area
};
if (isNil "fen_covert_penaltyMediumSuspicionArea") then {
	fen_covert_penaltyMediumSuspicionArea=20;									// penalty for being observed in medium suspicion area
};
if (isNil "fen_covert_penaltyHighSuspicionArea") then {
	fen_covert_penaltyHighSuspicionArea=50;										// penalty for being observed in high suspicion area
};
if (isNil "fen_covert_penaltyRestrictedItem") then {
	fen_covert_penaltyRestrictedItem=20;										// penalty for being observed with restricted item
};
if (isNil "fen_covert_penaltyRestrictedVehicle") then {							// penalty for being in a restricted vehicle
	fen_covert_penaltyRestrictedVehicle=100;
};
if (isNil "fen_covert_penaltyOvertProximity") then {							// penaly for being near friendly player has is overt
	fen_covert_penaltyOvertProximity=20;
};


fen_covert_buildAllRestrictedItems={

	params [
		["_restrictedItemFactions",[],[[]]],
		["_restrictedItems",[],[[]]],
		["_unrestrictedItems",[],[[]]]
	];
	
	private _classArray=[];
	private _allRestrictedItems=_restrictedItems;
	private _configFile=configFile>>"CfgVehicles";
	{
		private _faction=_x;
		for [{_idx=0},{_idx<count _configFile},{_idx=_idx+1}] do {
			if (isClass (_configFile select _idx)) then {
				if (configname(_configFile select _idx) isKindOf "Man" and tolower ([(_configFile select _idx),"faction","none"] call BIS_fnc_returnConfigEntry)==tolower _faction) then {
					_classArray pushBackUnique configName (_configFile select _idx);
				};
			};
		};		
	} forEach _restrictedItemFactions;
	
	{
		{
				if not(_x in _unrestrictedItems) then {
					if (_x!="") then {
						_allRestrictedItems pushBackUnique _x;
					};
				};
		} forEach (getArray(configFile>>"CfgVehicles">>_x>>"linkedItems"));
		
		private _backpack=(getText(configFile>>"CfgVehicles">>_x>>"backpack"));
		if (_backpack!="") then {
			if not(_backpack in _unrestrictedItems) then {
				_allRestrictedItems pushBackUnique _backpack;
			};
		};
	} forEach _classArray;
	
	if (fen_covert_debug) then {
		{
			diag_log format["fn_covert Restricted Item %1",_x];
		} forEach _allRestrictedItems;
	};
	
	_allRestrictedItems
	
};

fen_covert_hasWeapon={
	
	params [
		["_player",objNull,[objNull]]
	];
	
	private _hasPrimaryWeapon=false;
	private _hasSecondaryWeapon=false;
	private _hasHandGunDrawn=false;
	private _hasWeaponRaised=false;

	if (primaryWeapon _player!="" and primaryWeapon _player !="ACE_FakePrimaryWeapon") then {
		_hasPrimaryWeapon=true;
	};
	if (secondaryWeapon _player!="") then {
		_hasSecondaryWeapon=true;
	};
	if (currentWeapon _player!="") then {
		if (currentWeapon _player==handgunWeapon _player) then {
			_hasHandGunDrawn=true;
		};
		_hasWeaponRaised=not(weaponLowered _player);
	};

	[_hasPrimaryWeapon,_hasSecondaryWeapon,_hasHandGunDrawn,_hasWeaponRaised]
};

fen_covert_playerIsTarget={
	
	params[
		["_player",objNull,[objNull]],
		["_SFSGSideOvert",[west],[sideLogic]],
		["_rangetoPlayer",150,[0]],
		["_enemySides",[east],[[]]],
		["_targetRange",150,[0]]

	];
	
	private _playerIsKnown=false;
	private _playerIsOvert=false;
	private _closestEnemy=999999;

/* this is too processor intensive
	{
		private _unit=_x;
		{
			if (_x select 4==vehicle _player) then {
				_playerIsKnown=true;
				if (_x select 2==_SFSGSideOvert) then {
					_playerIsOvert=true;
				};
				if ((_unit distance _player)<_closestEnemy) then {
					_closestEnemy=_unit distance _player;
				};
			};
		} forEach (_unit nearTargets _targetRange);
	} forEach ((allUnits) select {side _x in _enemySides and _x distance _player<_rangetoPlayer});
*/

	{
		private _targetKnowledge=_x targetKnowledge (vehicle _player);
		if (_targetKnowledge select 0) then {
			_playerIsKnown=true;
			if (_targetKnowledge select 4==_SFSGSideOvert) then {
				_playerIsOvert=true;
			};
			if ((_x distance _player)<_closestEnemy) then {
				_closestEnemy=_x distance _player;
			};
		};
	} forEach ((allUnits) select {side _x in _enemySides and _x distance _player<_rangetoPlayer});

	[_playerIsKnown,_playerIsOvert,_closestEnemy]
};

private _allRestrictedItems=[_restrictedItemFactions,_restrictedItems,_unrestrictedItems] call fen_covert_buildAllRestrictedItems;

while {true} do {

	{
		private _penaltyDebug="";
		private _penaltyAwarded=false;
		private _hasWeapon="Not checked";
		private _player=_x;
		private _suspicionRating=_player getVariable ["fen_covert_suspicionRating",0];

		private _playerIsTarget=[_player,_SFSGSideOvert,fen_covert_checkTargetRange,_enemySides,fen_covert_checkTargetRange] call fen_covert_playerIsTarget;		
	
		if (_playerIsTarget select 0) then {

			if (_suspicionRating<fen_covert_ratingMax) then {
				if (fen_covert_debug) then {
					if (_playerIsTarget select 0) then {
						_penaltyDebug=_penaltyDebug+"Seen (0)<br/>";
					};
				};

				{
					if (vehicle _player inArea _x) then {
						_suspicionRating=_suspicionRating+fen_covert_penaltyLowSuspicionArea;
						_penaltyAwarded=true;
						if (fen_covert_debug) then {
							_penaltyDebug=_penaltyDebug+"Low Suspicion Area ("+str fen_covert_penaltyLowSuspicionArea+")<br/>"
						};
					};
				} forEach _lowSuspicionAreas;
	
				{
					if (vehicle _player inArea _x) then {
						_suspicionRating=_suspicionRating+fen_covert_penaltyMediumSuspicionArea;
						_penaltyAwarded=true;
						if (fen_covert_debug) then {
							_penaltyDebug=_penaltyDebug+"Medium Suspicion Area ("+str fen_covert_penaltyMediumSuspicionArea+")<br/>"
						};
					};
				} forEach _mediumSuspicionAreas;
				
				{
					if (vehicle _player inArea _x) then {
						_suspicionRating=_suspicionRating+fen_covert_penaltyHighSuspicionArea;
						_penaltyAwarded=true;
						if (fen_covert_debug) then {
							_penaltyDebug=_penaltyDebug+"High Suspicion Area ("+str fen_covert_penaltyHighSuspicionArea+")<br/>"
						};
					};
				} forEach _highSuspicionAreas;
	
				{
					if (vehicle _player inArea _x) then {
						_suspicionRating=_suspicionRating+fen_covert_ratingMax;
						_penaltyAwarded=true;
						if (fen_covert_debug) then {
							_penaltyDebug=_penaltyDebug+"Restricted Area ("+str fen_covert_ratingMax+")<br/>"
						};
					};
				} forEach _restrictedAreas;
			
				_hasWeapon=[_player] call fen_covert_hasWeapon;
				
				if (_hasWeapon select 0) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyPrimaryWeapon;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Primary Weapon ("+str fen_covert_penaltyPrimaryWeapon+")<br/>";
					};
				};
				if (_hasWeapon select 1) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltySecondaryWeapon;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Secondary Weapon ("+str fen_covert_penaltySecondaryWeapon+")<br/>";
					};
				};
				if (_hasWeapon select 2) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyHandGunDrawn;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Drawn Handgun ("+str fen_covert_penaltyHandGunDrawn+")<br/>";
					};
				};
				if (fen_covert_debug) then {
					if (_hasWeapon select 3 and (_hasWeapon select 0 or _hasWeapon select 1 or _hasWeapon select 2)) then {
						_penaltyDebug=_penaltyDebug+"Raised Weapon<br/>";
					};
				};
				if (not(_hasWeapon select 3) and (_hasWeapon select 0 or _hasWeapon select 1 or _hasWeapon select 2)) then {
					_suspicionRating=_suspicionRating-fen_covert_bonusWeaponLowered;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Lowered Weapon Bonus (-"+str fen_covert_bonusWeaponLowered+")<br/>";
					};
				};
				
				if (headgear _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Headgear ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
				
				if (goggles _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Goggles ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
	
				if (hmd _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted HMD ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
				
				if (vest _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Vest ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
	
				if (backpack _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Backpack ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
			
				if (uniform _player in _allRestrictedItems) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedItem;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Uniform ("+str fen_covert_penaltyRestrictedItem+")<br/>";
					};
				};
			
				if (faction (vehicle _player) in _restrictedVehicleFactions) then {
					_suspicionRating=_suspicionRating+fen_covert_penaltyRestrictedVehicle;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Restricted Vehicle ("+str fen_covert_penaltyRestrictedVehicle+")<br/>";
					};
				};
				
				if (count (allplayers select {_x !=_player and _x distance _player<=fen_covert_overtRange and side _x==_SFSGSideOvert})>0) then {  
					_suspicionRating=_suspicionRating+fen_covert_penaltyOvertProximity;
					_penaltyAwarded=true;
					if (fen_covert_debug) then {
						_penaltyDebug=_penaltyDebug+"Overt Proximity ("+str fen_covert_penaltyOvertProximity+")<br/>";
					};
				};
			
				if (_penaltyAwarded) then {
					if (_playerisTarget select 2<fen_covert_checkTargetRange) then {
						_suspicionRating=_suspicionRating+((fen_covert_checkTargetRange/(_playerIsTarget select 2))/100)*fen_covert_penaltyProximity;
						if (fen_covert_debug) then {
							_penaltyDebug=_penaltyDebug+" Enemy Proximity ("+ str (((fen_covert_checkTargetRange/(_playerIsTarget select 2))/100)*fen_covert_penaltyProximity)+")<br/>";
						};
					};
				};
			};

		} else {
			_suspicionRating=_suspicionRating-fen_covert_penaltyDecay;
		};

		if (_suspicionRating<=0) then {
			_suspicionRating=0;
		};
		
		if (_suspicionRating>fen_covert_ratingMax) then {
			_suspicionRating=fen_covert_ratingMax;
		};
		
		if (_suspicionRating>=fen_covert_ratingSwitch and captive _x) then {
			[_player,0] remoteExec ["setCaptive",_player];
		};
		if (_suspicionRating<fen_covert_ratingSwitch and not(captive _player)) then {
			[_player,1] remoteExec ["setCaptive",_player];
		};
			
		_player setVariable ["fen_covert_suspicionRating",_suspicionRating];

		if (fen_covert_debug) then {	
			_player setVariable["fen_covert_debugData",[time,_suspicionRating,_hasWeapon,_playerIsTarget,_penaltyDebug],true];
		};
		
		sleep 0.03;
		
	} forEach (allPlayers) select {side _x in [_SFSGSideCovert,_SFSGSideOvert]};
	
	sleep fen_covert_frequency;
};
