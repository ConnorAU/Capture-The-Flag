/*
	Modified version of A3\Functions_F\Misc\fn_animateFlag.fsm
	This allows for aborting the animation while its in progress
*/

params [
	["_flag",objNull,[objNull]],
	["_animateDuration",0,[0]],
	["_phaseEnd",-1337,[0]]
];
if (isNull _flag OR _phaseEnd == -1337) exitwith {};

private _phaseStart = flagAnimationPhase _flag;
_phaseEnd = 0 max _phaseEnd min 1;
if (_phaseEnd == _phaseStart) exitwith {};

private _timeStart = diag_ticktime;
private _timeEnd = _timeStart + _animateDuration * abs (_phaseEnd - _phaseStart);
CaptureTheFlag_map_animateFlag_tick = _timeStart;

waituntil {
	_flag setFlagAnimationPhase linearConversion [_timeStart,_timeEnd, diag_ticktime, _phaseStart, _phaseEnd, true];
	flagAnimationPhase _flag == _phaseEnd OR {CaptureTheFlag_map_animateFlag_tick != _timeStart}
};