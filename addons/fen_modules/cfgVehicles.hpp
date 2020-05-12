class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

	// fen_fnc_aiSpotter
	class fen_moduleAISpotter: Module_F {
		scope = 2;
    displayName="AI Spotter";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleAISpotter";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleAISpotter.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class spotRange {
		  displayName="Spotting range";
			description="Defines maximum engagement range for spotter.";
			typeName="NUMBER";
			defaultValue=1000;
			};
			class callRange {
				displayName="Calling Range";
				description="Defines calling radius, spotter can request fire missions from all artillery within this value.";
				typeName="NUMBER";
				defaultValue=5000;
			};
			class artilleryTypes {
				displayName="Artillery classes array";
				description="Defines an array of artillery classes the spotter can use.";
				typeName="STRING";
				defaultValue=["O_Mortar_01_F"];
			};
			class frequency {
				displayName="Fire mission frequency";
				description="Defines delay between fire missions.";
				typeName="NUMBER";
				defaultValue=120;
			};
			class engageSide {
				displayName="Side to be engaged";
				description="Defines side the spotter can engage.";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="west";
						default=1;
					};
					class east {
						name="East";
						value="east";
					};
					class independent {
						name="Independent";
						value="independent";
					};
				};
			};
			class safeRound {
				displayName="Chance of non-leathal round";
				description="Defines the percentrage chance of a round landing clear of players";
				typeName="Number";
				defaultValue=50;
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="AI Spotter";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_airResupply
	class fen_moduleAirResupply: Module_F {
    scope = 2;
    displayName="Air Resupply";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleAirResupply";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleAirResupply.paa";
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class dropWP {
				displayName="Drop Waypoint";
				description="Waypoint number when supplies dropped";
				typeName="NUMBER";
				defaultValue=1;
			};
            class flyHeight {
				displayName="Flying Height";
				description="Defines flying height for aircraft.";
				typeName="NUMBER";
				defaultValue=150;
			};
			class chuteClass {
				displayName="Chute Class Name";
				description="Defines chute to be used for drop.";
				defaultValue="B_Parachute_02_F";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Air Resupply";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Any"
				};
			};
		};
	};

	// fen_fnc_artilleryFX
	class fen_moduleArtilleryFX: Module_F {
    scope = 2;
    displayName="Artillery FX";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleArtilleryFX";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleArtilleryFX.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class minDistance {
				displayName="Minimum Distance";
				description="Defines minimum distance shells land from module.";
				typeName="NUMBER";
				defaultValue=0;
			};
            class maxDistance {
				displayName="Maximum Distance";
				description="Defines maximum distance shells land from module.";
				typeName="NUMBER";
				defaultValue=300;
			};
			class fireMissions {
				displayName="Fire missions";
				description="Defines number of fire missions.";
				typeName="NUMBER";
				defaultValue=2;
			};
			class delayFireMissions{
				displayName="Delay between fire missions";
				description="Defines number of seconds between fire missions.";
				typeName="NUMBER";
				defaultValue=60;
			};
			class shellCount {
				displayName="Shells per fire mission";
				description="Defines number of shells per fire mission.";
				typeName="NUMBER";
				defaultValue=5;
			};
			class safeDistance {
				displayName="Proximity";
				description="Defines closest shell can land near player.";
				typeName="NUMBER";
				defaultValue=75;
			};
			class shellClass {
				displayName="Shell Class";
				description="Defines shell class for artillery.";
				typeName="STRING";
				defaultValue="Sh_82mm_AMOS";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Artillery FX";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Any"
				};
			};
		};
	};

	// fen_fnc_artilleryLine
	class fen_moduleArtilleryLine: Module_F {
    scope = 2;
    displayName="Artillery Line";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleArtilleryLine";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleArtilleryLine.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class numberShells {
				displayName="Number of shells";
				description="Defines number of shells in artiller line.";
				typeName="NUMBER";
				defaultValue=5;
			};
            class shellSpace {
				displayName="Shell spacing";
				description="Defines distance between each shell.";
				typeName="NUMBER";
				defaultValue=10;
			};
			class shellDelay {
				displayName="Shell delay";
				description="Defines time between each shell.";
				typeName="NUMBER";
				defaultValue=1;
			};
			class shellClass {
				displayName="Shell Class";
				description="Defines shell class for artillery.";
				typeName="STRING";
				defaultValue="Sh_82mm_AMOS";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Artillery FX";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Any"
				};
			};
		};
	};

	// fen_fnc_bldPatrol
	class fen_moduleBldPatrol: Module_F {
    scope = 2;
    displayName="Building Patrol";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleBldPatrol";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleBldPatrol.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class patrolRadius{
				displayName="Patrol radius";
				description="Define maximum range units will patrol from group leader.";
				typeName="NUMBER";
				defaultValue=300;
			};
			class excludeBuildings{
				displayName="Exclude building classes";
				description="Optional: Defines array of building classes not to be patrolled e.g. ['Land_Barrack2','Land_i_Barracks_V2_F']";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Building Patrol";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_boobyTrahVeh
	class fen_moduleBoobyTrapVeh: Module_F {
    scope = 2;
    displayName="Booby Trap Vehicle";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleBoobyTrapVeh";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleBoobyTrapVeh.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class explosionClass{
				displayName="Explosion size";
				description="Defines size of explosion.";
				typeName="STRING";
				class values {
					class small {
						name="Small";
						value="M_NLAW_AT_F";
						default=1;
					};
					class medium {
						name="Medium";
						value="M_Mo_82mm_AT";
					};
					class large {
						name="Large";
						value="Bo_Mk82";
					};
				};
			};
			class minDelay {
				displayName="Minimum delay (seconds)";
				description="Defines minimum time in seconds between unit mounting vehicle and detonation.";
				typeName="NUMBER";
				defaultValue=0;
			};
			class maxDelay {
				displayName="Maximum delay (seconds)";
				description="Defines maximum time in seconds between unit mounting vehicle and detonation.";
				typeName="NUMBER";
				defaultValue=10;
			};
			class trapSide {
				displayName="Triggering side";
				description="Defines side that will trigger detonation when vehicle mounted.";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="west";
						default=1;
					};
					class east {
						name="East";
						value="east";
					};
					class independent {
						name="Independent";
						value="independent";
					};
					class civilian {
						name="Civilian";
						value="civilian";
					};
				};
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Add synchronised objects to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Booby Trap Vehicle";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyVehicle",
					"AnyStaticObject"
				};
			};
		};
	};

  //fen_fnc_cachedMines
  class fen_moduleCachedMines: Module_F {
    scope = 2;
    displayName="Cached Mines";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleCachedMines";
    functionPriority = 10;
    icon = "\fen_a3\addons\fen_modules\images\fn_moduleCachedMines.paa";
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

    class Arguments: ArgumentsBaseUnits {
      class proximity {
        displayName="Proximity";
        description="Defines proximity to player for mines to be spawned.";
        typeName="NUMBER";
        defaultValue=800;
      };
      class frequency {
        displayName="Frequency";
        description="Defines how oftern check for spawning/despawning mines occurs.";
        typeName="NUMBER";
        defaultValue=5;
      };
    };
  };

	// fen_fnc_civilianArea
	class fen_moduleCivilianArea: Module_F {
    scope = 2;
    displayName="Civilian Area";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleCivilianArea";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleCivilianArea.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class radius {
				displayName="Area radius";
				description="Defines wandering radius from module for civilian units.";
				typeName="NUMBER";
				defaultValue=300;
			};
      class maxCivilians {
				displayName="Maximum number of civilians";
				description="Defines maximum number of civilians that will be created.";
				typeName="number";
				defaultValue=10;
			};
			class triggerByWest {
				displayName="Activated by: West";
				description="Civilians will be created when West units in range.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
					};
					class yes {
						name="Yes";
						value=1;
						default=1;
					};
				};
			};
			class triggerByEast {
				displayName="Activated by: East";
				description="Civilians will be created when East units in range.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class triggerByGuer {
				displayName="Activated by: Independent";
				description="Civilians will be created when Independent units in range.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class triggerByCiv {
				displayName="Activated by: Civilian";
				description="Civialians will be created when Civilian units in range.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class triggerRange {
				displayName="Activation radius";
				description="Defines activation radius from module.";
				typeName="NUMBER";
				defaultValue=1500;
			};
			class civFaction {
				displayName="Civilian faction";
				description="Optional: If supplied, random units from this faction will be created.";
				typeName="STRING";
				defaultValue="CIV_F";
			};
			class civClasses {
				displayName="Civilian classes array";
				description="Optional: If supplied and Civilian faction is blank, random units from this array will be created.";
				typeName="STRING";
			};
			class fpsLimiter {
				displayName="FPS limiter";
				descriptions="If FPS falls below this value civilians will not be spawned";
				typeName="NUMBER";
				defaultValue=20;
			};
			class conversations {
				displayName="Conversation array";
				description="Optional: If supplied will assign conversations randomly to civilians e.g. [['Hello','Goodbye'],['Nothing to say','Go away']]";
				typeName="STRING";
			};
            class clause {
                displayName="Conversation clause";
                description="Optional: If supplied conversation only possible if clause is true";
                typeName="STRING";
            };
			class excludeBuildings {
				displayName="Exclude building classes array";
				description="Optional: Defines array of building classes civilians will avoid";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Civilian Area";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={};
			};
		};
	};

  // fen_fnc_civThrowGrenade
  class fen_moduleCivThrowGrenade: Module_F {
    scope = 2;
    displayName="Civ Throw Grenade";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleCivThrowGrenade";
    functionPriority = 10;
    icon = "\fen_a3\addons\fen_modules\images\fn_moduleCivThrowGrenade.paa";
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

    class Arguments: ArgumentsBaseUnits {
      class sideToEngage {
        displayName="Side";
        description="Defines side civilian will throw grenade at.";
        typeName="STRING";
        class values {
          class west {
            name="West";
            value="west";
            default=1;
          };
          class east {
            name="East";
            value="east";
          };
          class independent {
            name="Independent";
            value="independent";
          };
        };
      };
      class proximity {
        displayName="Proximity";
        description="Defines proximity of side to cause grenade to be thrown.";
        typeName="NUMBER";
        defaultValue=80;
      };
      class evasionProximity {
        displayName="Evasion Proximity";
        description="Proximity of cause civilian to flee after throwing grenade.";
        typeName="NUMBER";
        defaultValue=100;
      };
      class evasionMove {
        displayName="Evasion move distance";
        description="Distance civilian will move in each evasion attempt";
        typeName="NUMBER";
        defaultValue=100;
      };
      class includeAIS {
        displayName="Add to AIS";
        description="Add synchronised objects to AIS.";
        typeName="BOOL";
        class values {
          class no {
            name="No";
            value=0;
            default=1;
          };
          class yes {
            name="Yes";
            value=1;
          };
        };
      };
      class owningLocation {
        displayName="Owning Location";
        description="Optional: Defines owning AIS location";
        typeName="STRING";
      };
    };

    class ModuleDescription: ModuleDescription {
      description="Civ Throw Grenade";
      sync[]={
        "LocationArea_F"
      };
      class LocationArea_F {
        description[]={
          "https://feedback.bistudio.com/T84295",
          "has been fixed if you can see this."
        };
        position=0;
        optional=0;
        duplicate=1;
        synced[]={
          "AnyVehicle",
          "AnyStaticObject"
        };
      };
    };
  };

	// fen_fnc_civTalk_addConversation
	class fen_moduleAddConversation: Module_F {
    scope = 2;
    displayName="Add Conversation";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleAddConversation";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleAddConversation.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class conversation {
			  displayName="Conversation array";
				description="Defines array of conversation text, each element requires and addition interaction e.g. ['Hello','GoodBye']";
				typeName="STRING";
			};
      class clause {
        displayName="Conversation clause";
        description="Optional: If supplied conversation only possible if clause is true";
        typeName="STRING";
      };
			class includeAIS {
				displayName="Add to AIS";
				description="Add synchronised units to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Add Conversation";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_dicker
	class fen_moduleDicker: Module_F {
    scope = 2;
    displayName="Dicker";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleDicker";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleDicker.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class passIntel {
				displayName="Percentage chance of passing on info";
				description="Defines percentage chance of dicker passing on sigthings to nearby enemy.";
				typeName="NUMBER";
				defaultValue=75;
			};
			class updateWest {
				displayName="Pass intel to: West";
				description="Dicker will pass on intel to all nearby West units.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class updateEast {
				displayName="Pass intel to: East";
				description="Dicker will pass on intel to all nearby East units.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
					};
					class yes {
						name="Yes";
						value=1;
						default=1;
					};
				};
			};
			class updateGuer {
				displayName="Pass intel to: Independent";
				description="Dicker will pass on intel to all nearby Independent units.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class updateCiv {
				displayName="Pass intel to: Civilian";
				description="Dicker will pass on intel to all nearby Civilian units.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class updateRange {
				displayName="Update all units within";
				description="Defines update radius, all units within this value will be updated by dicker.";
				typeName="NUMBER";
				defaultValue=1000;
			};
			class frequency {
				displayName="Frequency";
				descriptions="Defines in seconds how oftern dicker will update nearby units.";
				typeName="NUMBER";
				defaultValue=10;
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Dicker";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

    // fen_fnc_flares
	class fen_moduleFlares: Module_F {
    scope = 2;
    displayName="Flares";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleFlares";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleFlares.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class maxDistance {
				displayName="Radius";
				description="Defines maximum radius flares will be generated from module position.";
				typeName="NUMBER";
				defaultValue=300;
			};
            class numSimFlares {
				displayName="Number of simulatenous flares";
				description="Defines maximum number of simulatenous flares.";
				typeName="NUMBER";
				defaultValue=10;
			};
			class frequency {
				displayName="Frequency of flares";
				description="Defines how oftern flares are created.";
				typeName="NUMBER";
				defaultValue=30;
			};
			class runTimes {
				displayName="Number of times to run";
				description="Defines number flares will be generated.";
				typeName="NUMBER";
				defaultValue=10;
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Flares";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Any"
				};
			};
		};
	};

    // fen_fnc_forwardObs
	class fen_moduleForwardObs: Module_F {
		scope = 2;
    displayName="Forward Observer";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleForwardObs";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleForwardObs.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class engageRange {
				displayName="Engagement Range";
				description="Defines maximum engagement range for FO.";
				typeName="NUMBER";
				defaultValue=1500;
			};
    	class artilleryTypes {
				displayName="Artillery classes array";
				description="Defines an array of artillery classes the spotter can use.";
				typeName="STRING";
				defaultValue=["O_Mortar_01_F"];
			};
			class callingRange {
				displayName="Calling Range";
				description="Defines calling radius, FO can request fire missions from all artillery within this value.";
				typeName="NUMBER";
				defaultValue=5000;
			};
			class delayFireMission {
				displayName="Fire mission frequency";
				description="Defines delay between fire missions.";
				typeName="NUMBER";
				defaultValue=120;
			};
      class dfpTriggers {
        displayName="Defensive Fire Plan Triggers";
				description="Defines an array triggers for defensive fire plan.";
				typeName="STRING";
				defaultValue=[];
      };
      class skillLevel {
        displayName="Skill Level";
        description="Skill level of FO";
        typeName="NUMBER";
        class values {
          class low {
            name="Low";
            value=1;
          };
          class medium {
            name="Medium";
            value=2;
            default=1;
          };
          class high {
            name="High";
            value=3;
          };
        };
      };
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="AI Spotter";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_grpDefend
	class fen_moduleGrpDefend: Module_F {
    scope = 2;
    displayName="Group Defend";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleGrpDefend";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleGrpDefend.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class defendRadius{
				displayName="Defend radius";
				description="Defines maximum radius from group leader units will garrison buildings and mount weapons systems.";
				typeName="NUMBER";
				defaultValue=100;
			};
			class excludeBuildings{
				displayName="Exclude building classes";
				description="Optional: Defines array of building classes not to be patrolled e.g. ['Land_Barrack2','Land_i_Barracks_V2_F']";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Defend Group";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_grpStaticPos
	class fen_moduleGrpStaticPos: Module_F {
    scope = 2;
    displayName="Group Static Positions";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleGrpStaticPos";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleGrpStaticPos.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class defendRadius{
				displayName="Defend radius";
				description="Defines maximum radius from group leader units will garrison buildings and mount weapons systems.";
				typeName="NUMBER";
				defaultValue=100;
			};
			class excludeBuildings{
				displayName="Exclude building classes";
				description="Optional: Defines array of building classes not to be patrolled e.g. ['Land_Barrack2','Land_i_Barracks_V2_F']";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Defend Group";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_grpSurrender
	class fen_moduleGrpSurrender: Module_F {
    scope = 2;
    displayName="Group Surrender";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleGrpSurrender";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleGrpSurrender.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class condition {
				displayName="Condition to cause surrender";
				description="Defines clause that triggers surrender. Variable _group indicates group e.g. {alive _x} count units _group<3.";
				typeName="STRING";
			};
      class command {
				displayName="Command to run on surrender";
				description="Optional: Defines command to run on surrender. Variable _group is available.";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Defend Group";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_hiddenEnemy
	class fen_moduleHiddenEnemy: Module_F {
    scope = 2;
    displayName="Hidden Enemy";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleHiddenEnemy";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleHiddenEnemy.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class armFaction {
				displayName="Arm with weapons (faction)";
				description="When units are triggered they will be armed with weapons from this faction.";
				typeName="STRING";
			};
			class armWeapons {
				displayName="Arm with weapons (class array)";
				description="Optional: If weapons faction not used will arm with weapons in this array e.g. ['Rifle_1','Rifle_2']";
				typeName="STRING";
			};
			class armFrom {
				displayName="Weapons cache classes array";
				description="Defines array of class used as weapons caches e.g. ['ammo_crate1','car1']";
				typeName="STRING";
			};
			class armDistance {
				displayName="Weapon cache distance";
				description="Defines maximum distance unit travel to find weapons cache.";
				typeName="NUMBER";
				defaultValue=200;
			};
			class wanderRadius {
				displayName="Wander radius";
				description="Defines maximum distance units will wander";
				typeName="NUMBER";
				defaultValue=300;
			};
			class proximity {
				displayName="Proximity";
				description="Defines proximity that will cause unit to equip.";
				typeName="NUMBER";
				defaultValue=100;
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Hidden Enemy";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_iedMan
	class fen_moduleIEDMan: Module_F {
    scope = 2;
    displayName="IED Man";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleIEDMan";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleIEDMan.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class iedClasses {
				displayName="IED classes array";
				description="Defines array of classes of IED unit will place e.g. ['IEDLandBig_F','IEDLandBigF'] unit will place two IEDs.";
				typeName="STRING";
				defaultValue=["IEDLandBig_F","IEDLandBig_F"];
			};
			class startTrigger {
				displayName="Trigger to start placement";
				description="Defines name of trigger that will start unit placing IEDs";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="IED Man";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_iedObject
	class fen_moduleIEDObject: Module_F {
    scope = 2;
    displayName="IED Object";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleIEDObject";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleIEDObject.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class removeIED {
				displayName="Delete object after detonation";
				description="Defines if object will be deleted after detonation.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class explosionClass {
				displayName="Explosion size";
				description="Defines size of explosion.";
				typeName="STRING";
				class values {
					class small {
						name="Small";
						value="M_NLAW_AT_F";
						default=1;
					};
					class medium {
						name="Medium";
						value="M_Mo_82mm_AT";
					};
					class large {
						name="Large";
						value="Bo_Mk82";
					};
				};
			};
			class minRange {
				displayName="Minimum proximity";
				description="Defines minimum distance from object to detonation.";
				typeName="NUMBER";
				defaultValue=0;
			};
			class maxRange {
				displayName="Maximum proximity";
				description="Defines maximum distance from object to detonation.";
				typeName="NUMBER";
				defaultValue=8;
			};
			class minDelay {
				displayName="Minimum delay before detonation";
				description="Defines minimum delay in seconds from triggered to detonation.";
				typename="NUMBER";
				defaultValue=0;
			};
			class maxDelay {
				displayName="Maximum delay before detonation";
				desription="Defines maximum delay in seconds from triggered to detonation.";
				typeName="NUMBER";
				defaultValue=5;
			};
			class trgSide {
				displayName="Side causing detonation";
				description="Defines side that cause IED to trigger";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="west";
						default=1;
					};
					class east {
						name="East";
						value="east";
					};
					class independent {
						name="Independent";
						value="independent";
					};
				};
			};
      class daisyChainID {
        displayName="Daisy Chain ID";
        description="All IED's for same ID will simulatenously trigger.";
        typeName="STRING";
      };
      class triggerManID {
        displayName="Trigger Man ID";
        description="IED can be detonated by trigger man with same ID.";
        typeName="STRING"
      };
			class includeAIS {
				displayName="Add to AIS";
				description="Add synchronised objects to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="IED Object";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyVehicle",
					"AnyStaticObject"
				};
			};
		};
	};

  // fen_fnc_iedObjectTriggerMan
  class fen_moduleIEDObjectTriggerMan: Module_F {
    scope = 2;
    displayName="IED Object Trigger Man";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleIEDObjectTriggerMan";
    functionPriority = 10;
    icon = "\fen_a3\addons\fen_modules\images\fn_moduleIEDObjectTriggerMan.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

    class Arguments: ArgumentsBaseUnits {
      class trgSide {
        displayName="Side causing detonation";
        description="Defines side that cause trigger man to detonate IED.";
        typeName="STRING";
        class values {
          class west {
            name="West";
            value="west";
            default=1;
          };
          class east {
            name="East";
            value="east";
          };
          class independent {
            name="Independent";
            value="independent";
          };
        };
      };
      class proximity {
        displayName="Trigger proximity";
        description="Defines proximity of triggering side to IED to cause detonation.";
        typeName="NUMBER";
        defaultValue=20;
      };
      class triggerManID {
        displayName="Trigger Man ID";
        description="Trigger man will detonate IEDs with same Trigger Man ID (see IED Object Module).";
        typeName="STRING"
      };
      class evasionProximity {
        displayName="Evasion Proximity";
        description="Proximity of triggering side to cause Trigger man to start evasions.";
        typeName="NUMBER";
        defaultValue=75;
      };
      class evasionMove {
        displayName="Evasion move distance";
        description="Distance trigger man will move in each evasion attempt";
        typeName="NUMBER";
        defaultValue=100;
      };
      class includeAIS {
        displayName="Add to AIS";
        description="Add synchronised objects to AIS.";
        typeName="BOOL";
        class values {
          class no {
            name="No";
            value=0;
            default=1;
          };
          class yes {
            name="Yes";
            value=1;
          };
        };
      };
      class owningLocation {
        displayName="Owning Location";
        description="Optional: Defines owning AIS location";
        typeName="STRING";
      };
    };

    class ModuleDescription: ModuleDescription {
      description="IED Object Trigger Man";
      sync[]={
        "LocationArea_F"
      };
      class LocationArea_F {
        description[]={
          "https://feedback.bistudio.com/T84295",
          "has been fixed if you can see this."
        };
        position=0;
        optional=0;
        duplicate=1;
        synced[]={
          "AnyVehicle",
          "AnyStaticObject"
        };
      };
    };
  };



	// fen_fnc_iedPP
	class fen_moduleIEDPP: Module_F {
    scope = 2;
    displayName="Pressure Plate IED (BIS classes only)";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleIEDPP";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleIEDPP.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class trgSide {
				displayName="Side causing detonation";
				description="Defines side that cause IED to trigger";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="WEST";
						default=1;
					};
					class east {
						name="East";
						value="EAST";
					};
					class independent {
						name="Independent";
						value="INDEPENDENT";
					};
				};
			};
			class minRange {
				displayName="Minimum proximity";
				description="Defines minimum distance from object to detonation.";
				typeName="NUMBER";
				defaultValue=0;
			};
			class maxRange {
				displayName="Maximum proximity";
				description="Defines maximum distance from object to detonation.";
				typeName="NUMBER";
				defaultValue=8;
			};
			class minDelay {
				displayName="Minimum delay before detonation";
				description="Defines minimum delay in seconds from triggered to detonation.";
				typename="NUMBER";
				defaultValue=0;
			};
			class maxDelay {
				displayName="Maximum delay before detonation";
				desription="Defines maximum delay in seconds from triggered to detonation.";
				typeName="NUMBER";
				defaultValue=5;
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Pressure Plate IED";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
				};
			};
		};
	};

	// fen_fnc_intel_addIntel
	class fen_moduleAddIntel: Module_F {
    scope = 2;
    displayName="Add Intel to object";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleAddIntel";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleAddIntel.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class intel {
				displayName="Intel";
				description="Defines intel string.";
				typeName="STRING";
				};
			class includeAIS {
				displayName="Add to AIS";
				description="Add synchronised objects to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Add Intel to object";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
				};
			};
		};
	};

	// fen_fnc_retreatGroup
	class fen_moduleRetreatGroup: Module_F {
    scope = 2;
    displayName="Retreat Group";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleRetreatGroup";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleRetreatGroup.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class proximity {
				displayName="Proximity retreat";
				description="Defines proximity retreat radius. When units of sides below are near group they will retreat.";
				typeName="NUMBER";
				defaultValue=300;
			};
			class proximityWest {
				displayName="Proximity: West";
				description="Group will retreat if West units in proximity.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
					};
					class yes {
						name="Yes";
						value=1;
						default=1;
					};
				};
			};
			class proximityEast {
				displayName="Proximity: East";
				description="Group will retreat if West units in proximity.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class proximityGuer {
				displayName="Proximity: Independent";
				description="Group will retreat if West units in proximity.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class proximityCiv {
				displayName="Proximity: Civilian";
				description="Group will retreat if West units in proximity.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class percentage {
				displayName="Casualty retreat";
				description="Defines percentage of casualities to trigger a retreat";
				typeName="NUMBER";
				defaultValue=50;
			};
			class retreatAction {
				displayName="Action on retreat";
				description="Defines what action is performed when group has retreated";
				typeName="BOOL";
				class values {
					class no {
						name="Defend";
						value=0;
						default=1;
					};
					class yes {
						name="Delete group";
						value=1;
					};
				};
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Retreat Group";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=1;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

    // fen_fnc_revealTriggeringUnitsAdd
	class fen_moduleRevealTriggeringUnitsAdd: Module_F {
    scope = 2;
    displayName="Reveal Triggering Units";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleRevealTriggeringUnitsAdd";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleRevealTriggeringUnitsAdd.paa";
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class revealTriggers {
        displayName="Reveal Triggers";
				description="Defines an array of reveal triggers.";
				typeName="STRING";
				defaultValue=[];
      };
      class useLOS {
        displayName="Use line of sight";
        description="Only visible triggering units will be revealed to synchronised units";
        typeName="BOOL";
			  class values {
					class no {
						name="No";
						value=0;
            default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
      };
			class excludeAir {
				displayName="Exclude Air Units";
				description="By default Air units are not revealed";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
					};
					class yes {
						name="Yes";
						value=1;
                        default=1;
					};
				};
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Retreat Group";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=1;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

	// fen_fnc_rollingBarrage
	class fen_moduleRollingBarrage: Module_F {
    scope = 2;
    displayName="Rolling Barrage";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleRollingBarrage";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleRollingBarrage.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class xAxisShells {
				displayName="X axis number of shells";
				description="Defines number of shells in the X axis (width).";
				typeName="NUMBER";
				defaultValue=10;
			};
      class xAxisSpace {
				displayName="X axis spacing";
				description="Defines space between shells in the X axis (width).";
				typeName="NUMBER";
				defaultValue=10;
			};
			class xAxisDelay {
				displayName="X axis delay";
				description="Defines time between shells in axis (width).";
				typeName="NUMBER";
				defaultValue=1;
			};
			class yAxisShells {
				displayName="Y axis number of shells";
				description="Defines number of shells in the Y axis (height).";
				typeName="NUMBER";
				defaultValue=10;
			};
      class yAxisSpace {
				displayName="Y axis spacing";
				description="Defines space between shells in the Y axis (height).";
				typeName="NUMBER";
				defaultValue=10;
			};
			class yAxisDelay {
				displayName="Y axis delay";
				description="Defines time between shells in Y axis (height).";
				typeName="NUMBER";
				defaultValue=1;
			};
			class shellClass {
				displayName="Shell Class";
				description="Defines shell class for artillery.";
				typeName="STRING";
				defaultValue="Sh_82mm_AMOS";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Rolling Barrage";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Any"
				};
			};
		};
	};

// fen_fnc_shareTargets
  class fen_moduleShareTargets: Module_F {
    scope = 2;
    displayName="Share Targets";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleShareTargets";
    functionPriority = 10;
	  icon = "\fen_a3\addons\fen_modules\images\fn_moduleShareTargets.paa";
    isGlobal = 1;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class processWest {
				displayName="Share targets: West";
				description="West will share targets with friendly groups.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
                        default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
      class processEast {
				displayName="Share targets: East";
				description="East will share targets with friendly groups.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
					};
					class yes {
						name="Yes";
						value=1;
            default=1;
					};
				};
			};
      class processGuer {
				displayName="Share targets: Independent";
				description="Independent will share targets with friendly groups.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
            default=1;
				  };
          class yes {
					  name="Yes";
					  value=1;
					};
				};
			};
      class processCiv {
				displayName="Share targets: Civilian";
				description="Civilians will share targets with friendly groups.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
            default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class frequency {
				displayName="Frequency";
				description="Defines how oftern targets are shared.";
				typeName="NUMBER";
				defaultValue=60;
			};
      class shareDistance {
				displayName="Broadcast Distance";
				description="Defines how far targets will be broadcast to nearby friendlies.";
				typeName="NUMBER";
				defaultValue=250;
			};
      class visibleRange {
			  displayName="Visible Range";
				description="Only targets within visibile range will be shared.";
				typeName="NUMBER";
				defaultValue=600;
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Share Targets";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={};
			};
		};
	};

	// fen_fnc_scrambleCrew
	class fen_moduleScrambleCrew: Module_F {
    scope = 2;
    displayName="Scramble Crew";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleScrambleCrew";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleScrambleCrew.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class crewSide {
				displayName="Crew side";
				description="Defines side of crew spawned.";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="west";
					};
					class east {
						name="East";
						value="east";
						default=1;
					};
					class independent {
						name="Independent";
						value="independent";
					};
				};
			};
			class triggerSide {
				displayName="Side triggering scramble";
				description="Defines side that will cause crew to scramble.";
				typeName="STRING";
				class values {
					class west {
						name="West";
						value="west";
						default=1;
					};
					class east {
						name="East";
						value="east";
					};
					class independent {
						name="Independent";
						value="independent";
					};
				};
			};
			class range {
				displayName="Proximity";
				description="Defines proximity of triggering side.";
				typeName="NUMBER";
				defaultValue=500;
			};
			class fight {
				displayName="Action on scramble";
				description="Defines action on crew scrambling";
				typeName="BOOL";
				class values {
					class no {
						name="Flee";
						value=0;
					};
					class yes {
						name="Fight";
						value=1;
						default=1;
					};
				};
			};
			class clutter {
				displayName="Clutter array";
				description="Optional: Array of classes to spawn as clutter around vehicle.";
				typeName="STRING";
			};
			class crew {
				displayName="Override Crew Class";
				descrption="Optional: Class name for crew. eg. I_Soldier_A_F";
				typeName="STRING";
			};
			class includeAIS {
				displayName="Add to AIS";
				description="Add synchronised objects to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Scramble Crew";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyVehicle",
				};
			};
		};
	};

	// fen_fnc_suicideBomber
	class fen_moduleSuicideBomber: Module_F {
    scope = 2;
    displayName="Suicide Bomber";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleSuicideBomber";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleSuicideBomber.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class bombJacket {
				displayName="Bomb jacket";
				description="Unit is wearing bomb jacket.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
      class deadmanChance {
        displayName="Dead mans trigger %";
        description="Percentage change of touch off on death";
        typeName="NUMBER";
        defaultValue=0;
      };
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised groups are added to AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="Suicide Bomber";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

  // fen_fnc_UCRaddCivilianClothesObject
	class fen_moduleUCRaddCivilianClothesObject: Module_F {
    scope = 2;
    displayName="UCR Add Civ Clothes Object";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleUCRaddCivilianClothesObject";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleUCRaddCivilianClothesObject.paa";
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class minimum {
        displayName="Minimum number of clothes to add";
        description="The minimum number of civ uniforms to add to object.";
        typeName="NUMBER";
        defaultValue=0;
      };
      class maximum {
        displayName="Maximum number of clothes to add";
        description="The maximum number of civ uniforms to add to object.";
        typeName="NUMBER";
        defaultValue=5;
      };
			class includeAIS {
				displayName="Add to AIS";
				description="Synchronised objects are added AIS.";
				typeName="BOOL";
				class values {
					class no {
						name="No";
						value=0;
						default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional: Defines owning AIS location";
				typeName="STRING";
			};
		};

		class ModuleDescription: ModuleDescription {
			description="UCR Add civ clothes to object";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"AnyAI"
				};
			};
		};
	};

  // fen_fnc_UCRsearchBuildingClothes
	class fen_moduleUCRsearchBuildingClothes: Module_F {
    scope = 2;
    displayName="UCR Search Building Civ Clothes";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleUCRsearchBuildingClothes";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleUCRsearchBuildingClothes.paa";
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class buildingBlackList {
				displayName="Buildings to exclude";
				description="Array of building types where search is not available.";
				typeName="STRING";
				defaultValue=[];
	    };
      class chanceNewClothes {
				displayName="Chance of finding new clothes %";
				description="Defines the percentrage chance for finding new clothes.";
				typeName="Number";
				defaultValue=25;
			};
		};

		class ModuleDescription: ModuleDescription {
			description="UCR Search Building Clothes";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Anything"
				};
			};
		};
	};

  // fen_fnc_VIR
	class fen_moduleVIR: Module_F {
    scope = 2;
    displayName="VIR";
    author = "Fen";
    vehicleClass = "Modules";
    category = "Fen_Modules";
    function = "fen_fnc_moduleVIR";
    functionPriority = 10;
		icon = "\fen_a3\addons\fen_modules\images\fn_moduleVIR.paa";
    isGlobal = 0;
    isTriggerActivated = 0;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
      class crewDisembark {
				displayName="Crew disembark";
				description="Determine if driver, commander, gunner should disembark on contact.";
        typeName="BOOL";
    		class values {
					class no {
						name="No";
						value=0;
            default=1;
					};
					class yes {
						name="Yes";
						value=1;
					};
				};
			};
      class proximity {
        displayName="Reaction proximity";
				description="Vehicle will react to enemy within proximity radius.";
				typeName="Number";
				defaultValue=750;
			};
      class convoyNumber {
        displayName="Convoy Number";
        description="Vehicles of same convoy number will react together."
        typeName="NUMBER";
        defaultValue=1;
      };
      class includeAIS {
        displayName="Add to AIS";
        description="Add synchronised objects to AIS.";
        typeName="BOOL";
        class values {
          class no {
            name="No";
            value=0;
            default=1;
          };
          class yes {
            name="Yes";
            value=1;
          };
        };
      };
      class owningLocation {
        displayName="Owning Location";
        description="Optional: Defines owning AIS location";
        typeName="STRING";
      };
		};

		class ModuleDescription: ModuleDescription {
			description="VIR";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"https://feedback.bistudio.com/T84295",
					"has been fixed if you can see this."
				};
				position=0;
				optional=0;
				duplicate=1;
				synced[]={
					"Anything"
				};
			};
		};
	};
};
