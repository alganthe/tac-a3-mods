#include "script_component.hpp"

[QGVAR(removeIntelAction), {[player, 1, _this select 0] call ace_interact_menu_fnc_removeActionFromObject}] call CBA_fnc_addEventHandler;

[QGVAR(addIntel), {
    params ["_intelID", "_intelName", "_intelText", "_intelType", "_unit"];

    private _actionID = [
        "intel" + str _intelID,
        _intelName,
        "",
        {
            params ["", "", "_args"];

            (_args select 0) hintC (_args select 1);
        },
        {(isPlayer _target)},
        {},
        [_intelName, _intelText]
    ] call ace_interact_menu_fnc_createAction;
    private _actionFullPath = [_unit, 1, ["ACE_SelfActions", QGVAR(intelNodeSelf)], _actionID] call ace_interact_menu_fnc_addActionToObject;

    // Add the intel to the intel array with the new action path
    private _ownedIntel = _unit getVariable [QGVAR(intel), []];
    _ownedIntel pushBackUnique [_intelID, _intelName, _intelText,_intelType, _actionFullPath];
    _unit setVariable [QGVAR(intel), _ownedIntel, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(addACEInteraction), {
    params ["_object", "_intelID"];

    if !(hasInterface) exitWith {};
    if (isNull _object) exitWith {
        ["", [], "intel" + _intelID] call CBA_fnc_globalEventJIP;
    };

    private _actionID = [QGVAR(intelNodeMain), "Intel", "", {}, {GVAR(enabled)},
    {
        private _action = [
            QGVAR(getIntel),
            "Get intel",
            "",
            {
                [(_this select 0)] call FUNC(getIntel);
            },
            {!isPlayer _target || (!alive _target) || {_target getVariable ["ACE_isUnconscious", false]}}
        ] call ace_interact_menu_fnc_createAction;

        private _return = [[_action, [], _target]];
        _return
    }] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _actionID] call ace_interact_menu_fnc_addActionToObject;
}] call CBA_fnc_addEventHandler;

player setVariable [QGVAR(intel), [], true];
