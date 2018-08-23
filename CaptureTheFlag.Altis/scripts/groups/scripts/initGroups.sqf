// Modified BIS_fnc_dynamicGroups

#include "\A3\Functions_F_MP_Mark\DynamicGroupsCommonDefines.inc"
CHECK(!hasInterface)

[] spawn {
	scriptName "DynamicGroups: AddKeyEvents";
	disableSerialization;

	waitUntil{ !isNull (findDisplay 46) };

	private _display = (findDisplay 46);
	private _varName = "BIS_dynamicGroups_key";

	if (!isNil { missionNamespace getVariable _varName }) then
	{
		private _index = missionNamespace getVariable _varName;
		_index params ["_down","_up"];

		// Reset event handlers
		_display displayRemoveEventHandler ["KeyDown", _down];
		_display displayRemoveEventHandler ["KeyUp", _up];
		missionNamespace setVariable [_varName, nil];
	};

	// Add event handlers to display
	private ["_down", "_up"];
	_down   = _display displayAddEventHandler ["KeyDown", "["OnKeyDown", _this] call BIS_fnc_dynamicGroups;"];
	//_up     = _display displayAddEventHandler ["KeyUp", "["OnKeyUp", _this] call BIS_fnc_dynamicGroups;"];
	_up     = _display displayAddEventHandler ["KeyUp", "uiNamespace setVariable ["BIS_dynamicGroups_keyDownTime", nil]"];

	// Store in ui namespace
	missionNamespace setVariable [_varName, [_down, _up]];

	// Log
	if (LOG_ENABLED) then
	{
		["AddKeyEvents: Key down event added for (%1)", _varName] call BIS_fnc_logFormat;
	};
};

// The updating function
if !(isNil "CaptureTheFlag_c_ui_groupMenuUpdate") exitwith {endmission "genericError"};
CaptureTheFlag_c_ui_groupMenuUpdate = compilefinal ("[] call " + str{
	// Compiled this way so the macros are still preprocessed
	if (!isNull (uiNamespace getVariable [VAR_UI_DISPLAY, displayNull])) then {
		if ((time - (missionNamespace getVariable [VAR_LAST_UPDATE_TIME, 0])) >= INTERFACE_UPDATE_DELAY) then{
			["Update", [false]] call DISPLAY;
			missionNamespace setVariable [VAR_LAST_UPDATE_TIME, time, IS_LOCAL];
		};
	};
});
