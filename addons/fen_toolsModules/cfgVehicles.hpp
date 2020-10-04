class CfgVehicles {
  class Logic;
  class Module_F: Logic {
    class ArgumentsBaseUnits;
    class ModuleDescription;
  };

	class fenTools_moduleBulletTrace: Module_F {
		scope = 2;
    displayName="Bullet Trace";
    author = "Fen";
    vehicleClass = "Modules";
    category = "fenTools_modules";
    function = "fenTools_fnc_moduleBulletTrace";
    functionPriority = 10;
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class numberTraces {
				displayName="Number of traces";
				description="Defines number of visible traces per unit.";
				typeName="NUMBER";
				defaultValue=5;
			};
		};
		class ModuleDescription: ModuleDescription {
			description="Fen Tools";
			sync[]={};
    };
	};

	class fenTools_moduleTrackHits: Module_F {
		scope = 2;
    displayName="Track Hits";
    author = "Fen";
    vehicleClass = "Modules";
    category = "fenTools_modules";
    function = "fenTools_fnc_moduleTrackHits";
    functionPriority = 10;
    isGlobal = 1;
    isTriggerActivated = 1;
    isDisposable = 0;
    is3DEN = 0;

		class Arguments: ArgumentsBaseUnits {
			class synchronisedOnly {
				displayName="Synchronised objects only";
				description="Defines if hits are tracked on synchronised objects or all mission objects";
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
        class frequency {
          displayName="Frequencey to check for new objects";
          description="Defines how oftern search is made for new objects to track";
          typeName="NUMBER";
          defaultValue=5;
        };
        class hitLife {
          displayName="Track Life";
          description="Defined how long each hit marker lasts.";
          typeName="NUMBER";
          defaultValue=30;
        };
		};

		class ModuleDescription: ModuleDescription {
			description="Fen Tools";
			sync[]={};
		};
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
      class enableTeleport {
        displayName="Enable teleport self";
        description="Adds action to allow teleporting.";
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
      class enableTeleportGrp {
        displayName="Enable teleport group";
        description="Adds action to allow teleporting of all units in players group.";
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
      class enableGroupMove {
        displayName="Enable group AI move";
        description="Adds action to AI units in players group to move, if held by disableAI.";
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
      class enableLogPosition {
        displayName="Enable log players position";
        description="Adds action allow player to log there position in rpt file and clipboard";
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
      class enableLogPositionASL {
        displayName="Enable log players position ASL";
        description="Adds action to allow players to log there position above sea level in rpt file and clipboard";
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
      class enableGrabSentry {
        displayName="Enable grab sentry";
        description="Adds action capture unit data for spawn sentry function.";
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
      class enableGrabLocation {
        displayName="Enable grab AIS Location";
        description="Adds action to capture AIS location data in rpt file.";
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
      class enableLogSQF {
        displayName="Enable log active SQFs";
        description="Adds action report all active SQFs in rpt file.";
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
      class enableLogSkill {
        displayName="Enable log skill";
        description="Adds action to capture AI skill levels in rpt file.";
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
      class enableDebugPanel {
        displayName="Enable debug panel";
        description="Activates the debug panel";
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
      class enableDebugPanelDefault {
        displayName="Debug panel default active";
        description="Determines if debug panel starts active.";
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
      class enableEnemyMarkers {
        displayName="Enable enemy markers";
        description="Activates enemy markers on map.";
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
      class enableEnemyMarkersDefault {
        displayName="Enemy markers default active";
        description="Determines if enemy markers starts active.";
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
      class enableVCBGSMarkers {
        displayName="Mark VCB Ground Sign Objects";
        description="Puts a marker on all VCB ground sign objects";
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
		};
		class ModuleDescription: ModuleDescription {
			description="Fen Tools";
			sync[]={};
		};
	};
};
