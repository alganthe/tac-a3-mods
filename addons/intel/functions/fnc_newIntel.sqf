/*
 * Author: Alganthe
 * Creates a new intel entry, server / host only.
 *
 * Arguments:
 * 0: Object to add the intel to <OBJECT>
 * 1: Name shown in the interaction menu when checking the intel you have on you <STRING>
 * 2: Text of the intel <STRING>
 * 3: Delete object when picked up <BOOL>
 *
 * Return value:
 * Nothing
 *
 * Example:
 * [cursorObject, "Hard drive", parseText "weeeee <br/> Second line"] call tac_intel_fnc_newIntel;
*/
#include "script_component.hpp"
if (!params [["_objects", []],  ["_intelName", "", [""]], ["_intelText", "", [""]], ["_intelType", false, [false]]]) exitWith {
    ERROR("Bad Params");
};

if (!isServer) exitWith {
    ERROR("Function is only allowed to be called on the server");
};

private _newIntel = GVAR(intelTracked);

{
    GVAR(intelID) = GVAR(intelID) + 1;

    if !(_x isKindOf "CAManBase") then {
        [QGVAR(addACEInteraction), [_x, GVAR(intelID)], "intel" + str GVAR(intelID)] call CBA_fnc_globalEventJIP;
    };

    private _ownedIntel = _x getVariable [QGVAR(intel), []];

    _ownedIntel pushbackUnique [GVAR(intelID), _intelName, _intelText, _intelType];
    _newIntel pushbackUnique [GVAR(intelID), _intelName, _intelText, _intelType, false, _x];

    _x setVariable [QGVAR(intel), _ownedIntel, true];

} foreach _objects;

GVAR(intelTracked) = _newIntel;
publicVariable QGVAR(intelTracked);
