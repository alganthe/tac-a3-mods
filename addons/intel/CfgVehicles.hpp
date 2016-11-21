class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class Theseus_Intel {
                    displayName = "Intel";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 0;
                    priority = 2;

                    class Theseus_GetIntel {
                        displayName = "Get intel";//To be localized
                        condition =  QUOTE(!isPlayer _target || (!alive _target) || (_target getVariable [ARR_2('ACE_isUnconscious',false)]));
                        statement = QUOTE([(_this select 0)] call FUNC(getIntel));
                        showDisabled = 0;
                        priority = 2;
                    };

                     class Theseus_ShareIntel {
                        displayName = "Share intel";//To be localized
                        condition = QUOTE(!((_this select 1) getVariable QQGVAR(intel) isEqualTo []));
                        statement = "";
                        showDisabled = 0;
                        priority = 2;

                        class Theseus_ShareIntelHeard {
                            displayName = "Heard intel";//To be localized
                            condition = QUOTE(count (((_this select 1) getVariable QQGVAR(intel)) select {_x select 3 == 0}) > 0 && {isPlayer _target});
                            statement = "";
                            insertChildren = QUOTE([ARR_3(_this select 0, _this select 1, 0)] call FUNC(insertIntelChildren));
                            showDisabled = 0;
                            priority = 2;
                        };

                        class Theseus_ShareIntelObject {
                            displayName = "Objects";//To be localized
                            condition = QUOTE(count (((_this select 1) getVariable QQGVAR(intel)) select {_x select 3 == 1}) > 0 && {isPlayer _target});
                            statement = ""
                            insertChildren = QUOTE([ARR_3(_this select 0, _this select 1, 1)] call FUNC(insertIntelChildren));
                            showDisabled = 0;
                            priority = 2;
                        };
                    };
                };
            };
        };
        class ACE_SelfActions {
            class Theseus_intelSelf {
                displayName = "Intel";//To be localized
                condition = QUOTE(GVAR(enabled));
                statement = "";
                showDisabled = 1;
                priority = 2;

                class Theseus_heardIntel {
                    displayName = "Heard";//To be localized
                    condition = QUOTE(GVAR(enabled));
                    statement = "";
                    showDisabled = 1;
                    priority = 2;
                };

                class Theseus_objectIntel {
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
