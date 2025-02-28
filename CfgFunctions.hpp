class FLO {
    class Functions {
        file = "Functions";

        class MissionSave       {};
        class MissionFrontline  {};
        class MissionStartup    {};
        class CDVS              {};
        class ICS               {};
        class MissionLoad       {preInit = 1;};
    };

    class AI {
        file = "Functions\AI";

        class artilleryPrep         {};
        class airRecon              {};
        class airSupport            {};
        class executeAttackPattern  {};
        class fireObserver          {};
        class calculateQRFResponse  {};
        class requestQRF            {};
        class requestOffensiveOps   {};
        class heliInsert            {};
    };

    class Logistics {
        file = "Functions\Logistics";

        class opforResources {};
        class intelSystem {};
    };

    class Arsenal {
        file = "Functions\Arsenal";

        class restrictedArsenal {};
    };
    
    class Garrison {
        file = "Functions\Garrison";
        
        class garrisonManager     {};
        class logisticsNetwork    {};
        class vehicleGarrison     {};
    };
};
