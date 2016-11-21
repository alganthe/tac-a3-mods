/*
 * Author: Alganthe
 * Insert sub-actions for intel interactions
 *
 * Arguments:
 * 0: Target of the new action <OBJECT>
 * 1: Player this is added to <OBJECT>
 * 2: Type of intel <SCALAR> 0: Heard intel; 1: Object intel
 *
 *
 * Return value:
 * Children actions added
 *
 * Example:
 *
*/
#include "script_component.hpp"
params ["_target", "_player", "_type"];

private _actions = [];

{
    _x params ["_intelID", "_intelName", "", ""];
    private _action = [
        "intel" + str _intelID,
        _intelName,
        "",
        {
            _this call FUNC(shareIntel);
        },
        {alive _target && {isPlayer _target}},
        {},
        _x
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach ((_player getVariable [QGVAR(intel), []]) select {_x select 3 == _type});

_actions
