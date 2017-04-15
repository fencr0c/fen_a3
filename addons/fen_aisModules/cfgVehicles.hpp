class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

	class fenAIS_moduleCreateLocation: Module_F {
		scope = 2;
        displayName="AIS Location";
        author = "Fen";
        vehicleClass = "Modules";
        category = "fenAIS_modules";
        function = "fenAIS_fnc_moduleCreateLocation";
        functionPriority = 20;
		icon = "\fen_a3\addons\fen_aisModules\images\fn_moduleCreateLocation.paa";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
		
		class Arguments: ArgumentsBaseUnits {
			class radius {
				displayName="Activation Radius";
				description="Activation radius";
				typeName="NUMBER";
				defaultValue=1500;
			};
			class script {
				displayName="Script to run on activation";
				description="Named script will run each time location activates e.g. scripts\myscript.sqf";
				typeName="STRING";
			};
			class trigger {
				displayName="Activating trigger";
				description="Named trigger that will also activate location e.g. trigger1";
				typeName="STRING";
			};
			class despawn {
				displayName="Despawn";
				description="Location can despawn AI groups and objects when not active.";
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
			class triggerByAIWest {
				displayName="Activated by AI: West";
				description="By default locations are activated by player, use this to also trigger activation by West AI units.";
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
			class triggerByAIEast {
				displayName="Activated by AI: East";
				description="By default locations are activated by player, use this to also trigger activation by East AI units.";
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
			class triggerByAIGuer {
				displayName="Activated by AI: Independent";
				description="By default locations are activated by player, use this to also trigger activation by Independent AI units.";
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
			class triggerByAICiv {
				displayName="Activated by AI: Civilian";
				description="By default locations are activated by player, use this to also trigger activation by Civilian AI units.";
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
			class balance {
				displayName="Apply Balancing"; 
				description="Number of AI groups spawned in will be balanced to number of players in mission.";
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
			class maxPlayers {
				displayName="Max players in mission";
				description="Optional:Used when balancing to determine nubmer of AI to spawn";
				typeName="NUMBER";
			};
		};
		
		class ModuleDescription: ModuleDescription {
			description="Add Vehicle to AIS";
			sync[]={
			};
		};
	};
	
	class fenAIS_moduleInit: Module_F {
		scope = 2;
        displayName="AIS Auto Start";
        author = "Fen";
        vehicleClass = "Modules";
        category = "fenAIS_modules";
        function = "fenAIS_fnc_moduleInit";
        functionPriority = 40;
		icon = "\fen_a3\addons\fen_aisModules\images\fn_moduleInit.paa";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
		
		class Arguments: ArgumentsBaseUnits {
			class useHC {
				displayName="Use Headless Client if available";
				description="AIS will run on first headless client if available.";
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
		};

		class ModuleDescription: ModuleDescription {
			description="Add Vehicle to AIS";
			sync[]={};
		};
	};
	
	class fenAIS_moduleGroup: Module_F {
		scope = 2;
        displayName="AIS Group";
        author = "Fen";
        vehicleClass = "Modules";
        category = "fenAIS_modules";
        function = "fenAIS_fnc_moduleGroup";
        functionPriority = 20;
		icon = "\fen_a3\addons\fen_aisModules\images\fn_moduleGroup.paa";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
		
		class Arguments: ArgumentsBaseUnits {
            class command {
				displayName="Command to execute on spawn";
				description="Command will be run when AIS spawns group. %1 will be substitued for group";
				typeName="STRING";
			};
			class doStop {
				displayName="Do Stop";
				descrption="doStop command is issued on all group";
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
			class sentry {
				displayName="Sentry";
				description="Group will remain in position until enemy detected within sentry range or they take a causality.";
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
			class sentryRange {
				displayName="Sentry release radius";
				descriptions="Groups on Sentry will be release if enemy detected within radius.";
				typeName="NUMBER";
			};
			class VCOMoff {
				displayName="VCOM Off";
				description="Group will be exlcuded from VCOM_AI as per VCOM NOAI";
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
			class VCOMnopath {
				displayName="VCOM no path";
				description="Group will not respond to calls for help as per VCOM_NOPATHING_Unit";
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
			class excludeASR {
				displayName="Exclude from ASR_AI";
				description="Group will be excluded from ASR_AI";
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
			class excludeBalancing {
				displayName="Exclude from balancing";
				description="Group will not be affected by AIS Balancing if on";
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
			class combatMode {
				displayName="Combat Mode";
				description="";
				typeName="STRING";
				class values {
					class blue {
						name="Never Fire";
						value="BLUE";
					};
					class green {
						name="Hold fire-defend only";
						value="GREEN";
					};
					class white {
						name="Hold fire-engage at will";
						value="WHITE";
					};
					class yellow {
						name="Fire at will";
						value="YELLOW";
						default=1;
					};
					class red {
						name="Fire at will-engage at will";
						value="RED";
					};
				};
			};
			class behaviour {
				displayName="Behaviour";
				description="";
				typeName="STRING";
				class values {
					class careless {
						name="Careless";
						value="CARELESS";
					};
					class safe {
						name="Safe";
						value="SAFE";
					};
					class aware {
						name="Aware";
						value="AWARE";
						default=1;
					};
					class combat {
						name="Combat";
						value="COMBAT";
					};
					class stealth {
						name="Stealth";
						value="STEALTH";
					};
				};
			};
			class loadOut {
				displayName="Save groups load out";
				description="Groups load out will be applied at spawn";
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
			description="Add Group to AIS";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"some text which can be multi line",
					"line 2"
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

	class fenAIS_moduleVehicle: Module_F {
		scope = 2;
        displayName="AIS Object";
        author = "Fen";
        vehicleClass = "Modules";
        category = "fenAIS_modules";
        function = "fenAIS_fnc_moduleVehicle";
        functionPriority = 20;
		icon = "\fen_a3\addons\fen_aisModules\images\fn_moduleVehicle.paa";
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
		
		class Arguments: ArgumentsBaseUnits {
            class command {
				displayName="Command to execute on spawn";
				description="Command will be run when AIS spawns vehicle. %1 will be substitued for vehicle";
				typeName="STRING";
			};
			class owningLocation {
				displayName="Owning Location";
				description="Optional owning AIS location";
				typeName="STRING";
			};
		};
		
		class ModuleDescription: ModuleDescription {
			description="Add Vehicle to AIS";
			sync[]={
				"LocationArea_F"
			};
			class LocationArea_F {
				description[]={
					"some text which can be multi line",
					"line 2"
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
