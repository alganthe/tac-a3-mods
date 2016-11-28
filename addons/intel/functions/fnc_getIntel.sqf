/*
 * Author: Alganthe
 * Add intel to a unit
 *
 * Arguments:
 * 0: Unit on which the intel is stored <OBJECT>
 *
 * Return value:
 * Nothing
 *
 * Example:
 *
*/
#include "script_component.hpp"
params ["_target"];

private _intelEntries = _target getVariable QGVAR(intel);
private _ownedIntel = player getVariable [QGVAR(intel), []];
private _addedIntel = [];

// Avoid duplicate intel, needed since action paths should be unique to each player.
_intelEntries = (_intelEntries apply {if (!isNil {_x select 4}) then {[(_x select 0), (_x select 1), (_x select 2), (_x select 3)]} else {_x}}) - _ownedIntel;

// Delete object if type match
{
    _x params ["_intelID", "_intelName", "_intelText", "_intelType"];

    // Delete the intel object if the type match
    if (!isNil "_intelType" && {_intelType}) then {
        deleteVehicle _target;
    };

    _addedIntel pushBackUnique [_intelID, _intelName, _intelText, nil];
} foreach _intelEntries;

_ownedIntel = _ownedIntel + _addedIntel;

private _newIntelCount = (count _addedIntel);
// Notify player and set variables
[format ["%1 new intel obtained", ["No" , _newIntelCount] select (_newIntelCount > 0)], true, 5, 0] call ace_common_fnc_displayText;
player setVariable [QGVAR(intel), _ownedIntel, true];
_target setVariable [QGVAR(intel), [], true];

