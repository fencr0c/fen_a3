class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class ArgumentsBaseUnits;
        class ModuleDescription;
    };

	class fenTools_moduleToolsInit: Module_F {
		scope = 2;
        displayName="Fen Tools";
        author = "Fen";
        vehicleClass = "Modules";
        category = "fenTools_modules";
        function = "fenTools_fnc_moduleToolsInit";
        functionPriority = 10;
        isGlobal = 1;
        isTriggerActivated = 1;
        isDisposable = 0;
        is3DEN = 0;
		
		class Arguments: ArgumentsBaseUnits {
			class editorOnly {
				displayName="Debug available in editor only";
				description="Debug will only run in the editor.";
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
			description="Fen Tools";
			sync[]={};
		};
	};
};

