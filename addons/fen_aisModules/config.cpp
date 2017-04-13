class CfgPatches {	
	class fenAIS_modules {
		author = "Fen";
		name = "Fen AIS Modules";
		units[] = {
			"fenAIS_moduleCreateLocation",
			"fenAIS_moduleGroup",
			"fenAIS_init",
			"fenAIS_moduleVehicle"
		};
		requiredVersion = 1.640000;
		requiredAddons[] = {
			"A3_Modules_F",
			"fen_ais"
		};	
	};
};

#include "cfgFactionClasses.hpp"
#include "cfgFunctions.hpp"
#include "cfgVehicles.hpp"