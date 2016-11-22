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

// Only allow to pick object intel if target is unconscious or dead
if (_target getVariable ['ACE_isUnconscious', false] || {!alive _target}) then {
    _intelEntries = (_target getVariable QGVAR(intel)) select {_x select 3 == 1};
};

// Avoid duplicate intel, needed since action paths should be unique to each player.
_intelEntries = (_intelEntries apply {if (!isNil {_x select 4}) then {[(_x select 0), (_x select 1), (_x select 2), (_x select 3)]} else {_x}}) - _ownedIntel;

// Add check interactions
{
    _x params ["_intelID", "_intelName", "_intelText", "_intelType"];

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

    private _actionFullPath = [player, 1, ["ACE_SelfActions", QGVAR(intelNodeSelf), ([QGVAR(heardIntel), QGVAR(objectIntel)] select _intelType)], _actionID] call ace_interact_menu_fnc_addActionToObject;

    _addedIntel pushBackUnique [_intelID, _intelName, _intelText, _intelType, _actionFullPath];
} foreach _intelEntries;

_ownedIntel = _ownedIntel + _addedIntel;

// Notify player and set variable
hintSilent parseText format ["%1 new heard intel obtained <br/> %2 new objects obtained", [({_x select 3 == 0} count _addedIntel), 0] select (isNil "_intelEntries"), [({_x select 3 == 1} count _addedIntel), 0] select (isNil "_intelEntries")];
player setVariable [QGVAR(intel), _ownedIntel, true];

// Remove var from target, object only for players, also remove check interactions
if (isPlayer _target) then {
    {
        _x params ["", "", "", "", "_actionFullPath"];

        if !(isNil "_actionFullPath") then {
            [QGVAR(removeIntelAction), [_actionFullPath], _target] call CBA_fnc_targetEvent;
        };
    } foreach (_intelEntries select {_x select 3 == 1});

    _target setVariable [QGVAR(intel), _intelEntries - (_intelEntries select {_x select 3 == 1}), true];

} else {
    _target setVariable [QGVAR(intel), [], true];
};

