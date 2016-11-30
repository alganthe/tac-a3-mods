/*
 * Author: Alganthe
 * Condition for the getIntel action
 *
 * Arguments:
 * 0: Interaction target <OBJECT>
 *
 * Return value:
 * BOOL
 *
*/
params ["_target"];
!alive _target ||
{_target getVariable ["ACE_captives_isHandcuffed", false]} ||
{_target getVariable ["ACE_captives_isSurrendering", false]} ||
{_target getVariable ["ACE_isUnconscious", false]}


