#include "script_component.hpp"

// Exit on Server
if (!isServer) exitWith {};

// Add Add Object To Chronos (server)
[QGVAR(addObjectToChronos), {_this call FUNC(moduleAddObjectToChronosServer)}] call CBA_fnc_addEventHandler;
