/* Dropped-gear containers do not belong to the cargo-less object snapshot. */
params ["_className"];

(_className isKindOf "WeaponHolder") || {_className isKindOf "WeaponHolderSimulated"}
