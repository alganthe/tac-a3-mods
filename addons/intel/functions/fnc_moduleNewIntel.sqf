/*
 * Author: Alganthe
 * Module to add new intel
 *
 * Arguments:
 * 0: Module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 */
 #include "script_component.hpp"
params ["_logic", "_objects", "_activated"];

if ((isNull _logic) || {!_activated}) exitWith {};
if (_objects isEqualTo []) exitWith {
    WARNING_1("tac_intel_moduleAddIntel has no synced objects [%1]", _logic);
};

private _name = _logic getVariable ["Name", ""];
private _text = _logic getVariable ["Text", ""];
private _type = _logic getVariable ["Type", false];

[_objects, _name, _text, _type] call FUNC(newIntel);
