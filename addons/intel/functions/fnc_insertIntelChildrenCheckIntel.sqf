/*
 * Author: Alganthe
 * Insert sub-actions for intel interactions
 *
 * Arguments:
 * 0: Target of the new action <OBJECT>
 * 1: Player this is added to <OBJECT>
 *
 * Return value:
 * Children actions added
 *
 * Example:
 *
*/
#include "script_component.hpp"
params ["_target", "_player"];

private _actions = [];

{
    _x params ["_intelID", "_intelName", "", ""];
    private _action = [
        "intel" + str _intelID,
        _intelName,
        "",
        {
            params ["", "", "_args"];

            [_args select 2, false, 15, 0] call ace_common_fnc_displayText;
        },
        {true},
        {},
        _x,
        "",
        nil,
        [false, false, false, true, false]
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach (_player getVariable [QGVAR(intel), []]);

_actions
