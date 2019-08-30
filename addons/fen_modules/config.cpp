class CfgPatches {	
	class fen_modules {
		author = "Fen";
		name = "Fen Modules";
		units[] = {
			"fen_moduleAISpotter",
            "fen_moduleAirResupply",
            "fen_moduleArtilleryFX",
            "fen_moduleArtilleryLine",
			"fen_moduleBldPatrol",
			"fen_moduleBoobyTrapVeh",
			"fen_moduleCivilianArea",
			"fen_moduleAddConversation",
			"fen_moduleDicker",
            "fen_moduleFlares",
            "fen_moduleForwardObs",
			"fen_moduleGrpDefend",
			"fen_moduleGrpStaticPos",
			"fen_moduleGrpSurrender",
			"fen_moduleHiddenEnemy",
			"fen_moduleIEDMan",
			"fen_moduleIEDObject",
			"fen_moduleIEDPP",
			"fen_moduleAddIntel",
			"fen_moduleRetreatGroup",
            "fen_moduleRollingBarrage",
			"fen_moduleScrambleCrew",
			"fen_moduleSuicideBomber",
            "fen_moduleRevealTriggeringUnitsAdd",
            "fen_moduleShareTargets",
            "fen_moduleUCRSearchBuildingClothes"
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