class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class GVAR(intelNodeMain) {
                    displayName = "Intel";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 0;
                    priority = 2;

                    class GVAR(getIntel) {
                        displayName = "Get intel";//To be localized
                        condition =  QUOTE(!isPlayer _target || (!alive _target) || (_target getVariable [ARR_2('ACE_isUnconscious',false)]));
                        statement = QUOTE([(_this select 0)] call FUNC(getIntel));
                        showDisabled = 0;
                        priority = 2;
                    };

                     class GVAR(shareIntel) {
                        displayName = "Share intel";//To be localized
                        condition = QUOTE(!((_this select 1) getVariable QQGVAR(intel) isEqualTo []));
                        statement = "";
                        showDisabled = 0;
                        priority = 2;

                        class GVAR(shareIntelHeard) {
                            displayName = "Heard intel";//To be localized
                            condition = QUOTE(count (((_this select 1) getVariable QQGVAR(intel)) select {_x select 3 == 0}) > 0 && {isPlayer _target});
                            statement = "";
                            insertChildren = QUOTE([ARR_3(_this select 0, _this select 1, 0)] call FUNC(insertIntelChildren));
                            showDisabled = 0;
                            priority = 2;
                        };

                        class GVAR(shareIntelObject) {
                            displayName = "Objects";//To be localized
                            condition = QUOTE(count (((_this select 1) getVariable QQGVAR(intel)) select {_x select 3 == 1}) > 0 && {isPlayer _target});
                            statement = "";
                            insertChildren = QUOTE([ARR_3(_this select 0, _this select 1, 1)] call FUNC(insertIntelChildren));
                            showDisabled = 0;
                            priority = 2;
                        };
                    };
                };
            };
        };
        class ACE_SelfActions {
            class GVAR(intelNodeSelf) {
                displayName = "Intel";//To be localized
                condition = QUOTE(GVAR(enabled));
                statement = "";
                showDisabled = 1;
                priority = 2;

                class GVAR(heardIntel) {
                    displayName = "Heard";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 1;
                    priority = 2;
                };

                class GVAR(objectIntel) {
                    displayName = "Objects";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 1;
                    priority = 2;
                };
            };
        };
    };
};
