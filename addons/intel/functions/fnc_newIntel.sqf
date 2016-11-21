/*
 * Author: Alganthe
 * Creates a new intel entry, server / host only.
 *
 * Arguments:
 * 0: Object to add the intel to <OBJECT>
 * 1: Name shown in the interaction menu when checking the intel you have on you <STRING>
 * 2: Text of the intel <STRING>
 * 3: Type of intel <SCALAR> 0: Heard intel; 1: Object intel
 *
 * Return value:
 * Nothing
 *
 * Example:
 * [cursorObject, "Hard drive", parseText "weeeee <br/> Second line"] call tac_intel_fnc_newIntel;
*/
#include "script_component.hpp"
if (!params [["_object", objNull, [objNull]],  ["_intelName", "", [""]], ["_intelText", "", [""]], ["_intelType", 1, [1]]]) exitWith {
    ERROR("Bad Params");
};

if (!isServer) exitWith {
    ERROR("Function is only allowed to be called on the server");
};

GVAR(intelID) = GVAR(intelID) + 1;

if !(_object isKindOf "CAManBase") then {
    [QGVAR(addACEInteraction), [_object], "intel" + str GVAR(intelID)] call CBA_fnc_globalEventJIP;
};

private _ownedIntel = _object getVariable [QGVAR(intel), []];

_ownedIntel pushbackUnique [GVAR(intelID), _intelName, _intelText, _intelType];

_object setVariable [QGVAR(intel), _ownedIntel, true];
