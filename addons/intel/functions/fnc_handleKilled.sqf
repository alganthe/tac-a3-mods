/*
 * Author: Alganthe
 * Remove heard intel on players upon death
 *
 * Arguments:
 * 0: Corpse of the player <OBJECT>
 *
 * Return value:
 * Nothing
 *
 * Example:
 *
*/
#include "script_component.hpp"
params ["_unit"];

private _intelEntries = _unit getVariable [QGVAR(intel), []];

{
    _x params ["", "", "", "", "_actionFullPath"];

    if !(isNil "_actionFullPath") then {
        [player, 1, _actionFullPath] call ace_interact_menu_fnc_removeActionFromObject;
    };
} foreach _intelEntries;
