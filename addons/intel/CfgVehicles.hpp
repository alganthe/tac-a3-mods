class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(intelNodeMain) {
                    displayName = "Intel";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 1;
                    priority = 2;

                    class GVAR(getIntel) {
                        displayName = "Get intel";//To be localized
                        condition =  QUOTE(_target call FUNC(canGetIntel));
                        statement = QUOTE([ARR_2(_this select 0, _this select 1)] call FUNC(getIntel));
                        showDisabled = 1;
                        priority = 2;
                    };

                     class GVAR(shareIntel) {
                        displayName = "Share intel";//To be localized
                        condition = QUOTE(!((_this select 1) getVariable QQGVAR(intel) isEqualTo []));
                        statement = "";
                        insertChildren = QUOTE([ARR_2(_this select 0, _this select 1)] call FUNC(insertIntelChildren))
                        showDisabled = 0;
                        priority = 2;
                    };
                };
            };
        };
        class ACE_SelfActions {
            class GVAR(intelNodeSelf) {
                displayName = "Intel";//To be localized
                condition = QUOTE(GVAR(enabled));
                statement = "";
                insertChildren = QUOTE([ARR_2(_this select 0, _this select 1)] call FUNC(insertIntelChildrenCheckIntel));
                showDisabled = 1;
                priority = 2;
            };

            class GVAR(trackedIntelNode) {
                displayName = "Tracked intel";//To be localized
                condition = QUOTE(GVAR(enabled) && {serverCommandAvailable '#kick'});
                statement = "";
                showDisabled = 0;
                priority = 2;
            };
        };
    };
};
