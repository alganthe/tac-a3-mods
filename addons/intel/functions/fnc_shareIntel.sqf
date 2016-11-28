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
_intelParams params ["_intelID", "_intelName", "_intelText", "_intelType"];

_player setVariable [QGVAR(intel), (_player getVariable QGVAR(intel)) - [_intelParams], true];

private _ownedIntel = _target getVariable [QGVAR(intel), []];
_ownedIntel pushBackUnique [_intelID, _intelName, _intelText, _intelType];
_target setVariable [QGVAR(intel), _ownedIntel, true];
