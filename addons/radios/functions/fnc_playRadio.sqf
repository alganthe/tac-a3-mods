/*
 * Author: DaC, Jonpas
 * Attaches a radio to a vehicle and starts playing the selected track on it.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Music Track <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle, player] call tac_radios_fnc_playRadio;
 *
 * Public: No
 */
#include "script_component.hpp"

PARAMS_2(_vehicle,_track);

private ["_radio"];

// Create and Attach the radio object to the helicopter
_radio = "Sign_Sphere10cm_F" createVehicle position _vehicle; // Non-collidable
_radio attachTo [_vehicle, [0, 0, 0]];

// Make the radio object invisible (MP and SP support)
if (isMultiplayer) then {
    ["TAC_hideRadio", [_radio]] call ace_common_fnc_serverEvent; // hideObjectGlobal must be executed on server
} else {
    hideObject _radio;
};

// Set Variable for menu conditions
_vehicle setVariable [QGVAR(playingRadio), _radio, true];

// Star playing music on radio object
[_radio,_track] call cba_fnc_globalSay3d;