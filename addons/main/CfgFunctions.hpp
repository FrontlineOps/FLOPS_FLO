class FLO {
    class Functions {
        file = "\z\flo\addons\main\Functions";

        class MissionSave       {};
        class MissionStartup    {};
        class MissionLoad       {preInit = 1;};
        class initializeFOB     {};
        class initializeOP      {};
    };

    class Save {
        file = "\z\flo\addons\main\Functions\Save";

        class saveConfigureAutosave {};
        class saveCaptureCampaignState {};
        class saveCommitCampaignData {};
        class saveGetAllCargo {};
        class saveGetCompressedDamage {};
        class saveIsWeaponHolderClass {};
        class saveRequest {};
    };

    // === INITIALIZATION PHASE SYSTEM ===
    class Init {
        file = "\z\flo\addons\main\Functions\Init";

        class applyMissionConfigLocally {};
        class registerSettings      {};
        class detectSavedGame       {};
        class initFactionSplitMixedInfantryPool {};
        class initLoadFactionDefinition {};
        class initLoadFactionSelection {};
        class initMissionConfigEvents {};
        class initPhaseManager      {};
        class initPhase1_MissionConfig {};
        class initPhase2_Factions   {};
        class initPhase3_Objectives {};
        class initPhase4_Virtualization {};
        class initPhase5_MissionSystems {};
        class initRestoreTrackedCrew {};
        class initRunPhase {};
        class initSideResourcesUninitialized {};
        class initActivatePlayer    {};
        class initDeployPlayer      {};
        class initClientFinalize    {};
        class playerSideAdapterApply {};
        class playerSideAdapterInit {};
        class playerSideAdapterRequest {};
        class addonPostInit         {postInit = 1;};
    };

    // === GTN (Goal Task Network) SYSTEM ===
    #include "Functions\AI\GTN\CfgFunctions.hpp"
    #include "Functions\UI\CfgFunctions.hpp"
    #include "Functions\Notifications\CfgFunctions.hpp"

    class AITasks {
        file = "\z\flo\addons\main\Functions\AI\Tasks";

        class taskApplyRoute {};
        class taskGarrison {};
        class taskReleaseGarrison {};
        class taskReleaseGarrisonUnit {};
        class taskPatrol {};
    };

    #include "Functions\Virtualization\CfgFunctions.hpp"
    #include "Functions\Transport\CfgFunctions.hpp"
    #include "Functions\ForceGeneration\CfgFunctions.hpp"
    #include "Functions\Civilian\CfgFunctions.hpp"

    #include "Functions\Objective\CfgFunctions.hpp"


    #include "Functions\Economy\CfgFunctions.hpp"

    #include "Functions\Logistics\CfgFunctions.hpp"

    class Store {
        file = "\z\flo\addons\main\Functions\Store";

        class storeAddInventoryItem {};
        class storeAddKitsWebEventHandler {};
        class storeAddWebEventHandler {};
        class storeAppendCatalogItem {};
        class storeAppendContainerCargoItems {};
        class storeAppendGearMagazine {};
        class storeAppendGearWeapon {};
        class storeAppendSupportItems {};
        class storeAppendUnitGear {};
        class storeApplyKit {};
        class storeApplyGearItems {};
        class storeApplyWeaponLine {};
        class storeBuildCatalog {};
        class storeBuildCatalogItem {};
        class storeBuildCategoryPayload {};
        class storeBuildHydratePayload {};
        class storeBuildKitsPayload {};
        class storeCategoryForVehicle {};
        class storeCategoryForWeapon {};
        class storeCapabilityForCategory {};
        class storeCheckout {};
        class storeClearCargo {};
        class storeCurrentLoadoutKitItems {};
        class storeDeployBase {};
        class storeDropGearItems {};
        class storeDropGearAddCount {};
        class storeGearVisionTraits {};
        class storeHandleUiEvent {};
        class storeHandleKitsUiEvent {};
        class storeIsItemBackedMagazine {};
        class storeIsMineMagazine {};
        class storeCollectVehicleWeapons {};
        class storeKitAccumulateLine {};
        class storeKitAppendCargo {};
        class storeKitCategoryForClass {};
        class storeKitDisplayName {};
        class storeNormalizeRuntimeRadioClass {};
        class storeOpenDialog {};
        class storeOpenKitsDialog {};
        class storePreInit { preInit = 1; };
        class storeMagazineCombatTraits {};
        class storePriceAttachment {};
        class storePriceClass {};
        class storePriceVehicle {};
        class storeReadConfigVisionTree {};
        class storeReadVisionTraits {};
        class storeReceiveResponse {};
        class storeRecruitAI {};
        class storeRequestCategory {};
        class storeRequestCheckout {};
        class storeRequestHydrate {};
        class storeSavedKitsDelete {};
        class storeSavedKitsLoad {};
        class storeSavedKitsPersist {};
        class storeSavedKitsSave {};
        class storeSavedKitValidateItem {};
        class storeSavedKitValidateRecord {};
        class storeSendResponse {};
        class storeSpawnVehicle {};
        class storeSpawnSupplyShipment {};
        class storeThroughputCost {};
        class storeUpdateDialog {};
        class storeUpdateKitsDialog {};
        class storeValidateAccess {};
        class storeVehicleConfigTraits {};
        class storeWeaponCombatPrice {};
        class storeWeaponAttachments {};
        class storeWebAction {};
    };

    class Base {
        file = "\z\flo\addons\main\Functions\Base";

        class baseBindTerminal {};
        class baseCleanupOwnedAssets {};
        class baseConfigureContainerActions {};
        class baseConfigureMainActions {};
        class baseCountSiegeForces {};
        class baseCreateMarker {};
        class baseCreateTriggers {};
        class baseDiscoverTerminal {};
        class baseDeployAddWebEventHandler {};
        class baseDeployBuildSnapshot {};
        class baseDeployClaimFirstFOB {};
        class baseDeployGetCost {};
        class baseDeployHandleUiEvent {};
        class baseDeployInitClient {};
        class baseDeployInitializeState {};
        class baseDeployOpenDialog {};
        class baseDeployPreInit { preInit = 1; };
        class baseDeployReceiveResult {};
        class baseDeployRequest {};
        class baseDeploySerializeState {};
        class baseDeployUpdateDialog {};
        class baseDeployValidateState {};
        class baseDeployWebAction {};
        class baseMonitorSiege {};
    };

    class Factions {
        file = "\z\flo\addons\main\Functions\Factions";

        class factionBuildAutoSelectionCatalog {};
        class factionBuildAutoCivilianCatalog {};
        class factionBuildAutoIndex {};
        class factionBuildMergedAutoCivilianCatalog {};
        class factionBuildMergedAutoMilitaryCatalog {};
        class factionBuildAutoMilitaryCatalog {};
        class factionBuildObjectiveGroupFieldSpecs {};
        class factionBuildTuningFieldSpecsFromIdcs {};
        class factionBuildVehiclePoolFromVariables {};
        class factionClassIsCombatInfantry {};
        class factionClassifyVehicle {};
        class factionCollectDirectUnitVariables {};
        class factionCompactNumericText {};
        class factionCompositionDefaultCaps {};
        class factionCompositionDefaultCounts {};
        class factionCompositionDefaultObjectiveGroups {};
        class factionCreateCompositionDefaultHandle {};
        class factionExtractVehicleClasses {};
        class factionGetCustomDefinition {};
        class factionGetGroupConfigs {};
        class factionGetCompositionDefaults {};
        class factionGetObjectiveGroupFieldSpecs {};
        class factionGetTuningFieldSpecs {};
        class factionGetVariableArray {};
        class factionBuildCompositionDefaultsHandle {};
        class factionBuildCustomCivilianCatalog {};
        class factionBuildCustomMilitaryCatalog {};
        class factionHandleSource {};
        class factionHandleSide {};
        class factionUnitIsOfficer {};
        class factionValidateCatalogSide {};
        class factionIsUnsignedInt {};
        class factionMergePairs {};
        class factionApplyTuningOverrides {};
        class factionApplyAutoFriendlyGlobals {};
        class factionBuildTuningHandle {};
        class factionPickUnitByRole {};
        class factionSanitizeCompositionForCatalog {};
    };

    #include "Functions\Utilities\CfgFunctions.hpp"

    class Misc {
        file = "\z\flo\addons\main\Functions\Misc";

        class disableSystemChat   {};
    };

    #include "Functions\Pathfinding\CfgFunctions.hpp"
};
