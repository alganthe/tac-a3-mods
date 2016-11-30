#include "script_component.hpp"

[QGVAR(addACEInteraction), {
    params ["_object", "_intelID"];

    if !(hasInterface) exitWith {};
    if (isNull _object) exitWith {
        ["", [], "intel" + _intelID] call CBA_fnc_globalEventJIP;
    };

    private _actionID = [QGVAR(intelNodeMain), "Intel", "", {}, {GVAR(enabled)},
    {
        private _action = [
            QGVAR(getIntel),
            "Get intel",
            "",
            {
                [(_this select 0), (_this select 1)] call FUNC(getIntel);
            },
            {!isPlayer _target || (!alive _target) || {_target getVariable ["ACE_isUnconscious", false]}}
        ] call ace_interact_menu_fnc_createAction;

        private _return = [[_action, [], _target]];
        _return
    }] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _actionID] call ace_interact_menu_fnc_addActionToObject;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(updateTrackedIntel), {
        params ["_newIntel"];

        private _intel = GVAR(intelTracked);
        {
           _x params ["_intelID", "_intelName", "_intelText", "", "_picked", "_owner"];

            _intel = _intel apply {
                if (_x select 0 == _intelID) then {
                    [_intelID, _intelName, _intelText, nil, _picked, _owner]
                } else {
                    _x
                };
            };
        } foreach _newIntel;

        GVAR(intelTracked) = _intel;
        publicVariable QGVAR(intelTracked);
    }] call CBA_fnc_addEventHandler;
};

player setVariable [QGVAR(intel), [], true];
