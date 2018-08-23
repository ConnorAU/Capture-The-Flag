/*-------------------------------------------------------
|														|
| ~ Vehicle Shop 	 									|
|														|
-------------------------------------------------------*/
#define VEHICLE_SHOP_CONFIG_PATH missionconfigfile >> "CfgScripts" >> "Shop" >> "configs" >> "VehicleShopInfo"


/*-------------------------------------------------------
|														|
| ~ Clothing Shop 	 									|
|														|
-------------------------------------------------------*/
#define CLOTHING_SHOP_CONFIG_PATH missionconfigfile >> "CfgScripts" >> "Shop" >> "configs" >> "ClothingShopInfo"
#define CLOTHING_SHOP_CURRENT_LOADOUT [uniform player,vest player,headgear player,goggles player]
#define CLOTHING_SHOP_LOADOUT_ORDER ["uniform","vest","hat","eyes"]
#define CLOTHING_SHOP_BUY_MULTIPLIER 1
#define CLOTHING_SHOP_SAVE_MULTIPLIER 7


/*-------------------------------------------------------
|														|
| ~ Weapon Shop 	 									|
|														|
-------------------------------------------------------*/
#define WEAPON_SHOP_CONFIG_PATH missionconfigfile >> "CfgScripts" >> "Shop" >> "configs" >> "WeaponShopInfo"
#define WEAPON_SHOP_CFGWEP_DIR(WEAPON) configFile >> "CfgWeapons" >> WEAPON >> "WeaponSlotsInfo"
#define WEAPON_SHOP_WEP_ORDER ["primary","launcher","pistol"]
#define WEAPON_SHOP_BUY_MULTIPLIER 1
#define WEAPON_SHOP_SAVE_MULTIPLIER 7
#define WEAPON_SHOP_PWEP_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\primaryweapon_ca.paa"
#define WEAPON_SHOP_SWEP_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\secondaryweapon_ca.paa"
#define WEAPON_SHOP_HWEP_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\handgun_ca.paa"
#define WEAPON_SHOP_OATT_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\itemoptic_ca.paa"
#define WEAPON_SHOP_PATT_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\itemacc_ca.paa"
#define WEAPON_SHOP_MATT_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\itemmuzzle_ca.paa"
#define WEAPON_SHOP_BATT_IMG "a3\ui_f\data\gui\rsc\rscdisplayarsenal\itembipod_ca.paa"


/*-------------------------------------------------------
|														|
| ~ Skill Shop											|
|														|
-------------------------------------------------------*/
#define SKILLS_SHOP_CONFIG_PATH missionconfigfile >> "CfgScripts" >> "Skill" >> "configs" >> "SkillsInfo"