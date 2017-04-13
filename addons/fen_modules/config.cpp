class CfgPatches {	
	class fen_modules {
		author = "Fen";
		name = "Fen Modules";
		units[] = {
			"fen_moduleAISpotter",
			"fen_moduleBldPatrol",
			"fen_moduleBoobyTrapVeh",
			"fen_moduleCivilianArea",
			"fen_moduleAddConversation",
			"fen_moduleDicker",
			"fen_moduleGrpDefend",
			"fen_moduleGrpStaticPos",
			"fen_moduleGrpSurrender",
			"fen_moduleHiddenEnemy",
			"fen_moduleIEDMan",
			"fen_moduleIEDObject",
			"fen_moduleIEDPP",
			"fen_moduleAddIntel",
			"fen_moduleRetreatGroup",
			"fen_moduleScrambleCrew",
			"fen_moduleSuicideBomber"
		};
		requiredVersion = 1.640000;
		requiredAddons[] = {
			"A3_Modules_F",
			"fen_functions"
		};	
	};
};

#include "cfgFactionClasses.hpp"
#include "cfgFunctions.hpp"
#include "cfgVehicles.hpp"