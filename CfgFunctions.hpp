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
        class airDrone              {};
        class executeAttackPattern  {};
        class fireObserver          {};
    };
};
