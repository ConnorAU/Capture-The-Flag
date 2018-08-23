/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

#include "..\defines.sqf"

private _cfgPth = configFile >> "CfgCTFScripts" >> "map" >> "configs" >> "maps" >> worldname >> (param [0,"",[""]]);
if !(isClass _cfgPth) exitwith {false};
private _mapVersion = getNumber(_cfgPth >> "version");
private _itemsList = [];
private _objectInitQueue = [];
private _moduleInitQueue = [];

// Set pitch bank yaw - https://community.bistudio.com/wiki/BIS_fnc_setPitchBank#Notes
private _setPBY = {
	params [["_object",objNull,[objNull]],["_rotations",[],[[]]]];
	_rotations params [["_aroundX",0,[0]],["_aroundY",0,[0]],["_aroundZ",0,[0]]];
    private _aroundZ = (360 - _aroundZ) - 360;
    private _dirX = 0;
    private _dirY = 1;
    private _dirZ = 0;
    private _upX = 0;
    private _upY = 0;
    private _upZ = 1;
    if (_aroundX != 0) then {
        _dirY = cos _aroundX;
        _dirZ = sin _aroundX;
        _upY = -sin _aroundX;
        _upZ = cos _aroundX;
    };
    if (_aroundY != 0) then {
        _dirX = _dirZ * sin _aroundY;
        _dirZ = _dirZ * cos _aroundY;
        _upX = _upZ * sin _aroundY;
        _upZ = _upZ * cos _aroundY;
    };
    if (_aroundZ != 0) then {
        private _dirXTemp = _dirX;
        _dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
        _dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
        private _upXTemp = _upX;
        _upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
        _upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);	
    };
    _object setVectorDirAndUp [[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];
};

// Load dynamic map sqm
switch _mapVersion do {
	case 53:{
		{
			["Load Map","Processing item with ID: "+str getNumber(_x >> "id")] call CaptureTheFlag_c_system_log;
			_dataType = getText(_x >> "dataType");
			switch _dataType do {
				case "Object":{
					_itemType = getText(_x >> "type");
					getArray(_x >> "PositionInfo" >> "position") params ["_itemPosX","_itemPosZ","_itemPosY"];
					getArray(_x >> "PositionInfo" >> "angles") params [["_itemAngleX",0],["_itemAngleZ",0],["_itemAngleY",0]];
					_itemHealth = ["",getNumber(_x >> "attributes" >> "health")] select (isNumber(_x >> "attributes" >> "health"));
					_itemAmmo = ["",getNumber(_x >> "attributes" >> "ammo")] select (isNumber(_x >> "attributes" >> "ammo"));
					_itemInit = getText(_x >> "attributes" >> "init");
					_itemName = getText(_x >> "attributes" >> "name");
					_itemPresence = [1,getNumber(_x >> "attributes" >> "presence")] select (isNumber(_x >> "attributes" >> "presence"));
					_itemPresenceCondition = ["true",getText(_x >> "attributes" >> "presenceCondition")] select (isText(_x >> "attributes" >> "presenceCondition"));
					_itemPlacementRadius = getNumber(_x >> "attributes" >> "placementRadius");
					_itemSimEnabled = getNumber(_x >> "attributes" >> "disableSimulation") == 0;
					_itemDynSimEnabled = getNumber(_x >> "attributes" >> "dynamicSimulation") == 1;
					_itemSimpleObject = getNumber(_x >> "attributes" >> "createAsSimpleObject") == 1;

					if (random 1 <= _itemPresence && {call compile _itemPresenceCondition}) then {
						_createdItem = if _itemSimpleObject then {
							createSimpleObject [_itemType,[_itemPosX,_itemPosY,_itemPosZ]];
						} else {
							createVehicle [_itemType,[_itemPosX,_itemPosY,_itemPosZ],[],_itemPlacementRadius,"CAN_COLLIDE"];
						};
						_createdItem setPosWorld [_itemPosX,_itemPosY,_itemPosZ];
						[_createdItem,[deg _itemAngleX,deg _itemAngleY,deg _itemAngleZ]] call _setPBY;
						if (count _itemName > 0) then {missionNamespace setVariable [_itemName,_createdItem,true];};
						if (_itemAmmo isEqualType 0) then {_createdItem setVehicleAmmo _itemAmmo};
						if (_itemHealth isEqualType 0) then {_createdItem setDamage (1-_itemHealth)};
						_createdItem enableSimulationGlobal _itemSimEnabled;
						_createdItem enableDynamicSimulation _itemDynSimEnabled;
						LMFF_V53_HANDLE_ITEM_CUSTOM_ATTRIBUTES
						if (count _itemInit > 0) then {
							_objectInitQueue pushback [_createdItem,"this = _this;"+_itemInit+";this = nil;"];
						};

						_itemsList set [getNumber(_x >> "id"),_createdItem];
					};
				};
				case "Group":{
					_itemType = getText(_x >> "side");
					if (_itemType in ["Civilian"]) then {
						_createdGroup = createGroup [call compile _itemType,true];
						{
							_itemType = getText(_x >> "type");
							getArray(_x >> "PositionInfo" >> "position") params ["_itemPosX","_itemPosZ","_itemPosY"];
							getArray(_x >> "PositionInfo" >> "angles") params [["_itemAngleX",0],["_itemAngleZ",0],["_itemAngleY",0]];
							_itemInit = getText(_x >> "attributes" >> "init");
							_itemName = getText(_x >> "attributes" >> "name");
							_itemPresence = [1,getNumber(_x >> "attributes" >> "presence")] select (isNumber(_x >> "attributes" >> "presence"));
							_itemPresenceCondition = ["true",getText(_x >> "attributes" >> "presenceCondition")] select (isText(_x >> "attributes" >> "presenceCondition"));
							_itemPlacementRadius = getNumber(_x >> "attributes" >> "placementRadius");
		
							if (random 1 <= _itemPresence && {call compile _itemPresenceCondition}) then {
								_createdItem = _createdGroup createUnit [_itemType,[_itemPosX,_itemPosY,_itemPosZ],[],_itemPlacementRadius,"CAN_COLLIDE"];
								_createdItem setPosWorld [_itemPosX,_itemPosY,_itemPosZ];
								[_createdItem,[deg _itemAngleX,deg _itemAngleY,deg _itemAngleZ]] call _setPBY;
								_createdItem setDir (deg _itemAngleZ);
								_createdItem enableDynamicSimulation false;
								if (count _itemName > 0) then {missionNamespace setVariable [_itemName,_createdItem,true];};
								LMFF_V53_HANDLE_ITEM_CUSTOM_ATTRIBUTES
								if (count _itemInit > 0) then {
									_objectInitQueue pushback [_createdItem,"this = _this;"+_itemInit+";this = nil;"];
								};
		
								_itemsList set [getNumber(_x >> "id"),_createdItem];
							};
						}foreach ("true"configClasses(_x >> "Entities"));
					};
				};
				case "Marker":{
					_itemType = getText(_x >> "type");
					_itemShape = ["ICON",getText(_x >> "markerType")] select (isText(_x >> "markerType"));
					getArray(_x >> "position") params ["_itemPosX","_itemPosZ","_itemPosY"];
					_itemName = getText(_x >> "name");
					_itemText = getText(_x >> "text");
					_itemColor = getText(_x >> "colorName");
					_itemAlpha = [1,getNumber(_x >> "alpha")] select (isNumber (_x >> "alpha"));
					_itemBrush = getText(_x >> "fillName");
					_itemSize = [[1,1],[getNumber(_x >> "a"),getNumber(_x >> "b")]] select (isNumber(_x >> "a") && isNumber(_x >> "b"));
					_itemAngle = getNumber(_x >> "angle");

					_createdItem = createMarker[_itemName,[_itemPosX,_itemPosY,_itemPosZ]];
					_createdItem setMarkerDir _itemAngle;
					_createdItem setMarkerSize _itemSize;
					_createdItem setMarkerText _itemText;
					_createdItem setMarkerAlpha _itemAlpha;
					_createdItem setMarkerShape _itemShape;
					if (isClass(configfile >> "cfgmarkers" >> _itemType)) then {_createdItem setMarkerType _itemType};
					if (count _itemBrush > 0) then {_createdItem setMarkerBrush _itemBrush};
					if (count _itemColor > 0) then {_createdItem setMarkerColor _itemColor};

					_itemsList set [getNumber(_x >> "id"),_createdItem];
				};
				case "Trigger":{
					_itemType = getText(_x >> "type");
					getArray(_x >> "position") params ["_itemPosX","_itemPosZ","_itemPosY"];
					_itemAngle = deg getNumber(_x >> "angle");
					_itemSizeA = getNumber(_x >> "attributes" >> "sizeA");
					_itemSizeB = getNumber(_x >> "attributes" >> "sizeB");
					_itemSizeC = getNumber(_x >> "attributes" >> "sizeC");
					_itemName = getText(_x >> "attributes" >> "name");
					_isRectangle = getNumber(_x >> "attributes" >> "isRectangle") == 1;

					_createdItem = createTrigger [getText(_x >> "type"),[_itemPosX,_itemPosY],true];
					_createdItem setTriggerArea [_itemSizeA,_itemSizeB, _itemAngle, _isRectangle, [-1,_itemSizeC] select (isNumber(_x >> "attributes" >> "sizeC"))];
					if (count _itemName > 0) then {missionNamespace setVariable [_itemName,_createdItem,true];};

					_itemsList set [getNumber(_x >> "id"),_createdItem];
				};
				case "Logic":{
					_itemType = getText(_x >> "type");
					getArray(_x >> "PositionInfo" >> "position") params ["_itemPosX","_itemPosZ","_itemPosY"];
					getArray(_x >> "PositionInfo" >> "angles") params [["_itemAngleX",0],["_itemAngleZ",0],["_itemAngleY",0]];
					_itemName = getText(_x >> "name");
					_itemFunction = getText(configFile >> "cfgvehicles" >> _itemType >> "function");
					_itemCategory = getText(configFile >> "cfgvehicles" >> _itemtype >> "category");
					_createdItem = (missionNameSpace getVariable ["bis_fnc_initModules_"+_itemCategory,group bis_functions_mainscope]) createUnit [_itemType,[_itemPosX,_itemPosY,_itemPosZ],[],0,"CAN_COLLIDE"];
					_createdItem setPosWorld [_itemPosX,_itemPosY,_itemPosZ];
					[_createdItem,[deg _itemAngleX,deg _itemAngleY,deg _itemAngleZ]] call _setPBY;
					if (count _itemName > 0) then {missionNamespace setVariable [_itemName,_createdItem,true];};
					switch _itemType do { 
						case "ModuleCoverMap_F":{
							getArray(_x >> "areaSize") params [["_itemAreaX",0,[0]],"",["_itemAreaY",0,[0]]];
							_createdItem setvariable ["objectArea",[_itemAreaX,_itemAreaY,deg _itemAngleZ,false,0]];
							if (count _itemFunction > 0) then {
    							_moduleInitQueue pushback [_createdItem,"[_this,0,true] call "+_itemFunction];
							};
						};
						case "ModuleHideTerrainObjects_F":{
							getArray(_x >> "areaSize") params [["_itemAreaX",0,[0]],"",["_itemAreaY",0,[0]]];
							_createdItem setvariable ["objectarea",[_itemAreaX,_itemAreaY,deg _itemAngleZ,getNumber(_x >> "areaIsRectangle") == 1,-1]];
							LMFF_V53_HANDLE_ITEM_CUSTOM_ATTRIBUTES
							if (count _itemFunction > 0) then {
    							_moduleInitQueue pushback [_createdItem,"['init',[_this]] call "+_itemFunction];
							};
						};
						case "ModuleEditTerrainObject_F":{
							LMFF_V53_HANDLE_ITEM_CUSTOM_ATTRIBUTES
							if (count _itemFunction > 0) then {
    							_moduleInitQueue pushback [_createdItem,"['init',[],_this] call "+_itemFunction];
							};
						};
						case "Logic":{
							this = _createdItem;
							call compile getText(_x >> "init");
							this = nil;
						};
						default {
							if (count _itemFunction > 0) then {
    							_moduleInitQueue pushback [_createdItem,"[_this] call "+_itemFunction];
							};
						};
					};
					_itemsList set [getNumber(_x >> "id"),_createdItem];
				};
				default {};
			};
		} foreach ("true" configClasses (_cfgPth >> "Mission" >> "Entities"));
	};
	default {};
};

// I think I had this for testing but it isn't actually used. I'd leave it here just to be safe.
{
	_linkItem0 = _itemsList param [getNumber(_x >> "item0"),objNull];
	_linkItem1 = _itemsList param [getNumber(_x >> "item1"),objNull];
	_linkType = getText(_x >> "customData" >> "type");
	switch _linkType do {
		case "Sync":{
			_linkItem0 synchronizeObjectsAdd [_linkItem1];
		};
		default {};
	};
}foreach ("true" configClasses (_cfgPth >> "Mission" >> "Connections" >> "Links"));

// Run dynamic map sqm object init queue
{
	_x params ["_object","_expression"];
	_object call compile _expression;
}foreach (_objectInitQueue+_moduleInitQueue);

// Set vehicle spawn info
missionNamespace setVariable ["CaptureTheFlag_mapSetting_westLandSpawns",getNumber(_cfgPth >> "CTF_Info" >> "westLandSpawns"),true];
missionNamespace setVariable ["CaptureTheFlag_mapSetting_westAirSpawns",getNumber(_cfgPth >> "CTF_Info" >> "westAirSpawns"),true];
missionNamespace setVariable ["CaptureTheFlag_mapSetting_eastLandSpawns",getNumber(_cfgPth >> "CTF_Info" >> "eastLandSpawns"),true];
missionNamespace setVariable ["CaptureTheFlag_mapSetting_eastAirSpawns",getNumber(_cfgPth >> "CTF_Info" >> "eastAirSpawns"),true];

// Replace defined map objects with new, invincible objects
private _objects = getArray(_cfgPth >> "CTF_Info" >> "replaceObjectsList");
private _placedObjects = [];
private _objectCount = count _objects;
{
	_x params ["_class","_model","_position"];
	_originalObject = (nearestObjects[_position,[],20,true] select {(getmodelinfo _x select 1) == _model && !(_x in _placedObjects)}) param [0,objNull];
	if (!isNull _originalObject && {!isObjectHidden _originalObject}) then {
		["Load Map","Replacing object with index: "+(str _forEachIndex)] call CaptureTheFlag_c_system_log;
		_dir = getDirVisual _originalObject;
		_vectorDU = [vectorDirVisual _originalObject,vectorUpVisual _originalObject];

		_originalObject hideObjectGlobal true;
		_replacementObject = if (_class != "") then {
			createVehicle[_class,getPosATL _originalObject,[],0,"CAN_COLLIDE"];
		} else {
			createSimpleObject[_model,getPosVisual _originalObject];
		};
		_replacementObject setPosATL (getPosATL _originalObject);
		_replacementObject allowDamage false;
		_replacementObject setDir _dir;
		_replacementObject setVectorDirAndUp _vectorDU;
		_placedObjects pushback _replacementObject;
	};
} foreach _objects;

// Very true
true;