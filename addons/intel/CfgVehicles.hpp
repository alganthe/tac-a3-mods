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

    class ACE_Module;
    class GVAR(module): ACE_module {
        author = ECSTRING(main,Author);
        category = "TAC";
        displayName = "New intel";//To be localized
        function = QFUNC(moduleNewIntel);
        isGlobal = 0;
        isTriggerActivated = 0;
        scope = 2;

        class Arguments {
            class Name {
                displayName = "Intel name";//To be localized
                description = "Name shown in the interaction menu";//To be localized
                typeName = "STRING";
                defaultValue = "";
            };
            class Text {
                displayName = "Intel text";//To be localized
                description = "Content of the intel";//To be localized
                typeName = "STRING";
                defaultValue = "";
            };
            class Type {
                displayName = "Delete object after pick up";//To be localized
                description = "Delete the object the intel is assigned to after a player pick it up";//To be localized
                typeName = "BOOL";
                defaultValue = 1;
            };
        };

        class ModuleDescription {
            description = "Create new intel";//To be localized
        };
    };
};
