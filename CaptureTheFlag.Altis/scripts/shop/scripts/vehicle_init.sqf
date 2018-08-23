/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params ["_display"];
uiNameSpace setVariable ["CaptureTheFlag_UI_VehicleShop",_display];
_display displayAddEventHandler ["KeyDown",{(_this select 1)in([57]+actionKeys"MoveForward" + actionKeys"MoveBack" + actionKeys"TurnLeft" + actionKeys"TurnRight")}];

private _exitButton = _display displayCtrl 1;
private _buttonTop1 = _display displayCtrl 10;
private _buttonTop2 = _display displayCtrl 11;
private _buttonTop3 = _display displayCtrl 12;
private _selectedDetails = _display displayCtrl 21;
private _selectedSkinSide = _display displayCtrl 22;
private _selectedSkinCamo = _display displayCtrl 23;
private _selectedPurchase = _display displayCtrl 24;

_exitButton ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0)) closeDisplay 2}];
{_x ctrlAddEventHandler ["ButtonClick",{_this call CaptureTheFlag_c_shop_vehicle_tabSelect}];} foreach [_buttonTop1,_buttonTop2,_buttonTop3];
_selectedPurchase ctrlAddEventHandler ["ButtonClick",{[ctrlParent(_this select 0)] call CaptureTheFlag_c_shop_vehicle_purchaseVehicle}];
_selectedSkinSide ctrlEnable false;
_selectedSkinCamo ctrlEnable false;
//_selectedPurchase ctrlEnable false;
_selectedDetails ctrlEnable false;
_buttonTop3 ctrlEnable (count CaptureTheFlag_setting_vehicles > 0);

_selectedSkinSide ctrlAddEventHandler ["ButtonClick",{["color",_this select 0] call CaptureTheFlag_c_shop_vehicle_skinSelected;}];
_selectedSkinCamo ctrlAddEventHandler ["ButtonClick",{["camo",_this select 0] call CaptureTheFlag_c_shop_vehicle_skinSelected;}];

_buttonTop1 setVariable ["type","Land"];
_buttonTop2 setVariable ["type","Air"];
_buttonTop3 setVariable ["type","Recent"];

[[_buttonTop1,_buttonTop3] select (count CaptureTheFlag_setting_vehicles > 0)] call CaptureTheFlag_c_shop_vehicle_tabSelect;