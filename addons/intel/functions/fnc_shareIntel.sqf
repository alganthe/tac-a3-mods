/*
 * Author: Alganthe
 * Share intel with another player, do not call manually this is intended for interactions use only
 *
 * Arguments:
 * 0: Player receiving the intel <OBJECT>
 * 1: Player on which the intel is stored <OBJECT>
 * 2: Intel being shared <ARRAY>
 *
 * Return value:
 * Nothing
 *
 * Example:
 *
*/
#include "script_component.hpp"
params ["_target", "_player", "_intelParams"];
_intelParams params ["_intelID", "_intelName", "_intelText", "_intelType", "_actionFullPath"];


_player setVariable [QGVAR(intel), (_player getVariable QGVAR(intel)) - [_intelParams], true];
[_player, 1, _actionFullPath] call ace_interact_menu_fnc_removeActionFromObject;

// Add check interaction on the receiving unit
[QGVAR(addIntel), [_intelID, _intelName, _intelText, _intelType, _target], _target] call CBA_fnc_targetEvent;
