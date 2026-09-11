/* airLock=1 also permits ground targets: many ATGMs use it. Require an
 * air-only missile or an exclusively anti-air AI usage profile. A generic
 * all-target usage mask is insufficient evidence for an AA assignment.
 */
params ["_ammo"];
if (toLower getText (_ammo >> "simulation") != "shotmissile") exitWith { false };
if (getNumber (_ammo >> "airLock") == 2) exitWith { true };
private _usage = getNumber (_ammo >> "aiAmmoUsageFlags");
getNumber (_ammo >> "airLock") > 0 && {(floor (_usage / 256)) mod 2 == 1} && {(floor (_usage / 64)) mod 2 == 0} && {(floor (_usage / 128)) mod 2 == 0} && {(floor (_usage / 512)) mod 2 == 0} && {getNumber (_ammo >> "manualControl") == 0}
