#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

if (isServer) then {
    GVAR(intelID) = 0;
    GVAR(intelTracked) = [];
};

ADDON = true;
