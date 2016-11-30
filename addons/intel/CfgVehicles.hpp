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
                        condition =  QUOTE(!isPlayer _target || (!alive _target) || (_target getVariable [ARR_2('ACE_isUnconscious',false)]));
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
        };
    };
};
