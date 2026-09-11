class FLO {
    class Functions {
        file = "\z\flo\addons\main\Functions";

        class MissionSave       {};
        class MissionStartup    {};
        class MissionLoad       {preInit = 1;};
        class initializeFOB     {};
        class initializeOP      {};
    };

    #include "Functions\Save\CfgFunctions.hpp"

    // === INITIALIZATION PHASE SYSTEM ===
    #include "Functions\Init\CfgFunctions.hpp"

    // === GTN (Goal Task Network) SYSTEM ===
    #include "Functions\AI\CfgFunctions.hpp"
    #include "Functions\UI\CfgFunctions.hpp"
    #include "Functions\Notifications\CfgFunctions.hpp"

    #include "Functions\Virtualization\CfgFunctions.hpp"
    #include "Functions\Transport\CfgFunctions.hpp"
    #include "Functions\ForceGeneration\CfgFunctions.hpp"
    #include "Functions\Civilian\CfgFunctions.hpp"

    #include "Functions\Objective\CfgFunctions.hpp"

    #include "Functions\Economy\CfgFunctions.hpp"

    #include "Functions\Logistics\CfgFunctions.hpp"

    #include "Functions\Store\CfgFunctions.hpp"

    #include "Functions\Base\CfgFunctions.hpp"

    #include "Functions\Factions\CfgFunctions.hpp"

    #include "Functions\Utilities\CfgFunctions.hpp"

    #include "Functions\Pathfinding\CfgFunctions.hpp"
};
