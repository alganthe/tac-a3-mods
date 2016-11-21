#include "script_component.hpp"

[QGVAR(removeIntelAction), {[player, 1, _this select 0] call ace_interact_menu_fnc_removeActionFromObject}] call CBA_fnc_addEventHandler;
player setVariable [QGVAR(intel), [], true];

[QGVAR(addIntel), {
    params ["_intelID", "_intelName", "_intelText", "_intelType", "_unit"];
    diag_log str _this;

    private _actionID = [
        "intel" + str _intelID,
        _intelName,
        "",
        {
            params ["", "", "_args"];

            (_args select 0) hintC (_args select 1);
        },
        {true},
        {},
        [_intelName, _intelText]
    ] call ace_interact_menu_fnc_createAction;
    private _actionFullPath = [_unit, 1, ["ACE_SelfActions", "Theseus_intelSelf", (["Theseus_heardIntel", "Theseus_objectIntel"] select _intelType)], _actionID] call ace_interact_menu_fnc_addActionToObject;

    // Add the intel to the intel array with the new action path
    private _ownedIntel = _unit getVariable [QGVAR(intel), []];
    _ownedIntel pushBackUnique [_intelID, _intelName, _intelText,_intelType, _actionFullPath];
    _unit setVariable [QGVAR(intel), _ownedIntel, true];

}] call CBA_fnc_addEventHandler;


