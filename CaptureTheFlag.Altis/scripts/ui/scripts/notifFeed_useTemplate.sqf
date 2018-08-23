/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

params [["_notifCfgDir","",[""]],["_textParams",[],[[]]]];

private _notifCfgDir = (missionConfigFile >> "CfgScripts" >> "ui" >> "configs" >> "NotificationTemplates" >> _notifCfgDir);
if !(isClass _notifCfgDir) exitwith {};

private _text = format([getText(_notifCfgDir >> "text")] + _textParams);
private _textSize = if (count gettext(_notifCfgDir >> "textSize") > 0) then {format["size='%1'",gettext(_notifCfgDir >> "textSize")]} else {""};
private _textFont = if (count gettext(_notifCfgDir >> "textFont") > 0) then {format["font='%1'",gettext(_notifCfgDir >> "textFont")]} else {""};
private _textAlign = if (count gettext(_notifCfgDir >> "textAlign") > 0) then {format["align='%1'",gettext(_notifCfgDir >> "textAlign")]} else {""};
private _textColour = if (count gettext(_notifCfgDir >> "textColour") > 0) then {format["color='%1'",gettext(_notifCfgDir >> "textColour")]} else {""};
private _textShadow = if (count gettext(_notifCfgDir >> "textShadow") > 0) then {format["shadow='%1'",gettext(_notifCfgDir >> "textShadow")]} else {""};

private _text = format["<t %1 %2 %3 %4 %5 >%6</t>",_textSize,_textFont,_textAlign,_textColour,_textShadow,_text];

[_text] call CaptureTheFlag_c_ui_notifFeed_add;