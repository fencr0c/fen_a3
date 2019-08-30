/*

File: fn_panelInfo.sqf
Author: Fen 

Description:
Displays debug panel

Parameters:
none

*/

private ["_curLoc","_curDir","_allUnt","_curASL","_east200","_east500","_east1km","_east2km","_east3km","_east4km","_eastAll","_guer200","_guer500","_guer1km","_guer2km","_guer3km","_guer4km","_guerAll","_aisEnv","_serverFPS","_headlessFPS","_cntSQF"];

while {fen_tools_panelOn} do {
    _curLoc=getPos player;
    _curASL=getPosAsl player;
    _curDir=getDir player;
    _allUnt=allUnits;
    _east200={player distance _x<0200 and side _x==east} count _allUnt;
    _east500={player distance _x<0500 and side _x==east} count _allUnt;
    _east1km={player distance _x<1000 and side _x==east} count _allUnt;
    _east2km={player distance _x<2000 and side _x==east} count _allUnt;
    _east3km={player distance _x<3000 and side _x==east} count _allUnt;
    _east4km={player distance _x<4000 and side _x==east} count _allUnt;
    _eastAll={side _x==east} count _allUnt;
    _guer200={player distance _x<0200 and side _x==resistance} count _allUnt;
    _guer500={player distance _x<0500 and side _x==resistance} count _allUnt;
    _guer1km={player distance _x<1000 and side _x==resistance} count _allUnt;
    _guer2km={player distance _x<2000 and side _x==resistance} count _allUnt;
    _guer3km={player distance _x<3000 and side _x==resistance} count _allUnt;
    _guer4km={player distance _x<4000 and side _x==resistance} count _allUnt;
    _guerAll={side _x==resistance} count _allUnt;
	_cntSQF=count diag_activeSQFScripts;
	
	if (isNil "fen_ais_environment") then {
		_aisEnv="not running";
	} else {
		_aisEnv=fen_ais_environment;
	};
	
	if (isNil "fen_serverFPS") then {
		_serverFPS="Not measured";
	} else {
		_serverFPS=fen_serverFPS;
	};
	
	if (isNil "fen_headlessFPS") then {
		_headlessFPS="Not measured";
	} else {
		_headlessFPS=fen_headlessFPS;
	};
    
	hintSilent parseText format["
	<t align='centre'>Debug Tools:<br/></tr>
	<t align='centre'>----------------<br/></tr>
	<t align='left'> Position X:</t><t align='right'>%1<br/></t>
	<t align='left'> Position Y:</t><t align='right'>%2<br/></t>
	<t align='left'> Position Z:</t><t align='right'>%3<br/></t>
	<t align='left'> Pos ASL X:</t><t align='right'>%4<br/></t>
	<t align='left'> Pos ASL Y:</t><t align='right'>%5<br/></t>
	<t align='left'> Pos ASL Z:</t><t align='right'>%6<br/></t>
	<t align='left'> Direction :</t><t align='right'>%7<br/></t>
	<t align='left'> East 200m  :</t><t align='right'>%8<br/></t>
	<t align='left'> East 500m  :</t><t align='right'>%9<br/></t>
	<t align='left'> East 1000m :</t><t align='right'>%10<br/></t>
	<t align='left'> East 2000m :</t><t align='right'>%11<br/></t>
	<t align='left'> East 3000m :</t><t align='right'>%12<br/></t>
	<t align='left'> East 4000m :</t><t align='right'>%13<br/></t>
	<t align='left'> East ALL   :</t><t align='right'>%14<br/></t>
	<t align='left'> Guer 200m  :</t><t align='right'>%15<br/></t>
	<t align='left'> Guer 500m  :</t><t align='right'>%16<br/></t>
	<t align='left'> Guer 1000m :</t><t align='right'>%17<br/></t>
	<t align='left'> Guer 2000m :</t><t align='right'>%18<br/></t>
	<t align='left'> Guer 3000m :</t><t align='right'>%19<br/></t>
	<t align='left'> Guer 4000m :</t><t align='right'>%20<br/></t>
	<t align='left'> Guer ALL   :</t><t align='right'>%21<br/></t>
	<t align='left'> Local FPS Cur   :</t><t align='right'>%22<br/></t>
	<t align='left'> Local FPS Min   :</t><t align='right'>%23<br/></t>
	<t align='left'> Server FPS      :</t><t align='right'>%24<br/></t>
	<t align='left'> Headless FPS    :</t><t align='right'>%25<br/></t>
	<t align='left'> AIS Active :</t><t align='right'>%26<br></t>
	<t align='left'> Active SQFS :</t><t align='right'>%27<br></t>
	",
	(_curLoc select 0),
	(_curLoc select 1),
	(_curLoc select 2),
	(_curASL select 0),
	(_curASL select 1),
	(_curASL select 2),
	_curDir,
	_east200,
	_east500,
	_east1km,
	_east2km,
	_east3km,
	_east4km,
	_eastAll,
	_guer200,
	_guer500,
	_guer1km,
	_guer2km,
	_guer3km,
	_guer4km,
	_guerAll,
	diag_fps,
	diag_fpsmin,
	_serverFPS,
	_headlessFPS,
	_aisEnv,
	_cntSQF
	];
   
    sleep 10;
};