/*
 *	Written by Connor (https://steamcommunity.com/id/_connor)
 *
 *	This work is licensed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) 
 *	License: https://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 *	Please refrain from modifying or removing this comment block.
 */

class holdActionTemplate {
	class defaultAction {
		title="";
		idleIcon="resources\images\holdaction\flag.paa";
		progressIcon="resources\images\holdaction\flag.paa";
		condShow="true";
		condProgress="true";
		codeStart="";
		codeProgress="";
		codeCompleted="";
		codeInterupted="";
		arguments[]={};
		duration=10;
		durationModifier="1";
		priority=5;
		removeCompleted=0;
		distance=2; // max 15 on duration=0 actions
		showUncon=0;
		factions[]={"west","east"};
	};

	class WeaponShop: defaultAction {
		title="<img image='a3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa' />Change My Weapons";
		//idleIcon="resources\images\holdaction\weapon.paa";
		//progressIcon="resources\images\holdaction\weapon.paa";
		codeCompleted="['CaptureTheFlag_UI_WeaponShop'] call CaptureTheFlag_c_ui_createDialog";
		distance=4;
		duration=0;
	};
	class vehicleShop: WeaponShop {
		title="<img image='resources\images\holdaction\car.paa' />Vehicle Shop";
		//idleIcon="resources\images\holdaction\car.paa";
		//progressIcon="resources\images\holdaction\car.paa";
		codeCompleted="['CaptureTheFlag_UI_VehicleShop'] call CaptureTheFlag_c_ui_createDialog";
	};
	class clothingShop: WeaponShop {
		title="<img image='a3\ui_f\data\gui\rsc\rscdisplayarsenal\headgear_ca.paa' />Change My Appearance";
		//idleIcon="resources\images\holdaction\headgear.paa";
		//progressIcon="resources\images\holdaction\headgear.paa";
		codeCompleted="['CaptureTheFlag_UI_ClothingShop'] call CaptureTheFlag_c_ui_createDialog";
	};
	class SkillShop: WeaponShop {
		title="<img image='resources\images\holdaction\skill.paa' />Manage Skills";
		//idleIcon="resources\images\holdaction\skill.paa";
		//progressIcon="resources\images\holdaction\skill.paa";
		codeCompleted="['CaptureTheFlag_UI_SkillShop'] call CaptureTheFlag_c_ui_createDialog";
	};


	class repairAndRearmPlayer: defaultAction {
		title="Rearm Player";
		idleIcon="resources\images\holdaction\weapon.paa";
		progressIcon="resources\images\holdaction\weapon.paa";
		condShow="['condition_p'] call CaptureTheFlag_c_system_repairAndRearm";
		codeCompleted="['perform_p'] call CaptureTheFlag_c_system_repairAndRearm";
		distance=4;
		duration=5;
	};
	class repairAndRearmVehicle: defaultAction {
		title="Repair and Rearm Vehicle";
		idleIcon="resources\images\holdaction\repair.paa";
		progressIcon="resources\images\holdaction\repair.paa";
		condShow="['condition_v'] call CaptureTheFlag_c_system_repairAndRearm";
		codeCompleted="['perform_v'] call CaptureTheFlag_c_system_repairAndRearm";
		distance=40;
		duration=1;
		durationModifier="['modifier',['repairAndRearmVehicle']] call CaptureTheFlag_c_ui_holdAction";
	};


	class lockVehicle: defaultAction {
		title="<img image='resources\images\holdaction\lock.paa' />Lock Vehicle";
		//idleIcon="resources\images\holdaction\lock.paa";
		//progressIcon="resources\images\holdaction\lock.paa";
		condShow="[0,1] call CaptureTheFlag_c_system_canModifyLock";
		codeCompleted="[cursorobject,true] call CaptureTheFlag_c_system_modifyVehicleLock";
		distance=2;
		duration=0;
	};
	class unlockVehicle: defaultAction {
		title="<img image='resources\images\holdaction\unlock.paa' />Unlock Vehicle";
		//idleIcon="resources\images\holdaction\unlock.paa";
		//progressIcon="resources\images\holdaction\unlock.paa";
		condShow="[2,3] call CaptureTheFlag_c_system_canModifyLock";
		codeCompleted="[cursorobject,false] call CaptureTheFlag_c_system_modifyVehicleLock";
		distance=2;
		duration=0;
	};
	class unflipVehicle: defaultAction {
		title="<img image='resources\images\holdaction\unflip.paa' />Unflip Vehicle";
		//idleIcon="resources\images\holdaction\unflip.paa";
		//progressIcon="resources\images\holdaction\unflip.paa";
		condShow="[] call CaptureTheFlag_c_system_canUnflipVehicle";
		codeCompleted="[] call CaptureTheFlag_c_system_unflipVehicle";
		distance=2;
		duration=0;
	};
	class repairVehicle: defaultAction {
		title="Repair Vehicle";
		idleIcon="resources\images\holdaction\repair.paa";
		progressIcon="resources\images\holdaction\repair.paa";
		condShow="[] call CaptureTheFlag_c_system_canRepairVehicle";
		codeCompleted="[cursorTarget] call CaptureTheFlag_c_system_repairVehicle";
		duration=1;
		durationModifier="['modifier',['repairVehicle']] call CaptureTheFlag_c_ui_holdAction";
	};


	class forceRespawn: defaultAction {
		title="Force Respawn";
		idleIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_forcerespawn_ca.paa";
		progressIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_forcerespawn_ca.paa";
		condShow="lifeState player == 'Incapacitated'";
		codeCompleted="player call CaptureTheFlag_c_medical_forceRespawn";
		duration=3;
		priority=1000;
		removeCompleted=1;
		distance=2;
		showUncon=1;
	};
	class executeTarget: defaultAction {
		title="Execute Enemy";
		idleIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_forcerespawn_ca.paa";
		progressIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_forcerespawn_ca.paa";
		condShow="lifeState cursorTarget == 'Incapacitated' && {(cursorTarget getvariable ['side',side cursorTarget]) != (player getvariable ['side',side player]) && {cursorTarget iskindof 'CAManBase' && {player distance cursorTarget < 2}}}";
		codeCompleted="cursorTarget call CaptureTheFlag_c_medical_executeTarget";
		duration=3;
		priority=1000;
		removeCompleted=0;
		distance=2;
		showUncon=1;
	};
	class reviveTeammate: defaultAction {
		title="Revive Teammate";
		idleIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_revive_ca.paa";
		progressIcon="\a3\ui_f\data\igui\cfg\holdactions\holdaction_revivemedic_ca.paa";
		condShow="[] call CaptureTheFlag_c_medical_canReviveUnit";
		//codeStart="CaptureTheFlag_medical_revivingTarget = [player,5] call CaptureTheFlag_c_system_getNearestUnit;";
		codeStart="CaptureTheFlag_medical_revivingTarget = cursorTarget;";
		codeCompleted="[] call CaptureTheFlag_c_medical_reviveTarget";
		arguments[]={};
		duration=10;
		durationModifier="['modifier',['reviveTeammate']] call CaptureTheFlag_c_ui_holdAction";
		priority=1000;
		removeCompleted=0;
		distance=2;
	};


	class stealFlag: defaultAction {
		title="Steal Flag";
		duration=10;
		durationModifier="['modifier',['stealFlag']] call CaptureTheFlag_c_ui_holdAction";

		condShow="['checkStealConditionShow',[_target]] call CaptureTheFlag_c_map_modifyFlag";
		condProgress="['checkProgressCondition',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
		codeStart="['StartSteal',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
		codeCompleted="['CompletedSteal',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
		codeInterupted="['InteruptSteal',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
	};
	class pickUpFlag: defaultAction {
		title="Pickup Flag";
		duration=5;
		distance=3;
		durationModifier="['modifier',['pickUpFlag']] call CaptureTheFlag_c_ui_holdAction";

		condShow="['checkPickupConditionShow',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag";
		condProgress="['checkProgressCondition',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag;";
		codeCompleted="['CompletedPickup',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag;";
	};
	class returnFlag: defaultAction {
		title="Return Flag";
		duration=5;
		distance=3;
		durationModifier="['modifier',['returnFlag']] call CaptureTheFlag_c_ui_holdAction";

		condShow="['checkReturnConditionShow',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag";
		condProgress="['checkProgressCondition',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag;";
		codeCompleted="['CompletedReturn',[[] call CaptureTheFlag_c_map_getDroppedFlagObject]] call CaptureTheFlag_c_map_modifyFlag;";
	};
	class captureFlag: defaultAction {
		title="Capture Flag";
		duration=10;
		durationModifier="['modifier',['captureFlag']] call CaptureTheFlag_c_ui_holdAction";

		condShow="['checkCaptureConditionShow',[_target]] call CaptureTheFlag_c_map_modifyFlag";
		condProgress="['checkProgressCondition',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
		codeCompleted="['CompletedCapture',[_target]] call CaptureTheFlag_c_map_modifyFlag;";
	};
};