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


// Add check interactions and delete Object if type matches.
{
    _x params ["_intelID", "_intelName", "_intelText", "_intelType"];

    // Delete the intel object if the type match
    if (!isNil "_intelType" && {_intelType}) then {
        deleteVehicle _target;
    };

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

    private _actionFullPath = [player, 1, ["ACE_SelfActions", QGVAR(intelNodeSelf), QGVAR(objectIntel)], _actionID] call ace_interact_menu_fnc_addActionToObject;

    _addedIntel pushBackUnique [_intelID, _intelName, _intelText, nil, _actionFullPath];
} foreach _intelEntries;

_ownedIntel = _ownedIntel + _addedIntel;

// Notify player and set variable
hintSilent parseText format ["%1 new intel obtained", count _addedIntel];
player setVariable [QGVAR(intel), _ownedIntel, true];

// Remove var from target, object only for players, also remove check interactions
if (isPlayer _target) then {
    {
        _x params ["", "", "", "", "_actionFullPath"];

        if !(isNil "_actionFullPath") then {
            [QGVAR(removeIntelAction), [_actionFullPath], _target] call CBA_fnc_targetEvent;
        };
    } foreach _intelEntries;

    _target setVariable [QGVAR(intel), _intelEntries - _intelEntries, true];

} else {
    _target setVariable [QGVAR(intel), [], true];
};

