class shop {
	class functions {
		class clothing_calculatePrice {};
		class clothing_init {};
		class clothing_itemStats {};
		class clothing_populateBuyButtons {};
		class clothing_populateItemButtons {};
		class clothing_populateSlider {};
		class clothing_purchaseItems {};
		class clothing_selectItem {};
		class skill_equip {};
		class skill_init {};
		class skill_populateContainer {};
		class skill_unequip {};
		class skill_upgrade {};
		class vehicle_init {};
		class vehicle_populateDetails {};
		class vehicle_populateSlider {};
		class vehicle_purchaseVehicle {};
		class vehicle_skinSelected {};
		class vehicle_tabSelect {};
		class weapon_calculatePrice {};
		class weapon_init {};
		class weapon_itemStats {};
		class weapon_populateBuyButtons {};
		class weapon_populateSlider {};
		class weapon_populateTiles {};
		class weapon_purchaseItems {};
		class weapon_selectItem {};
	};
	class configs {
		#include "configs\clothing.cpp"
		#include "configs\vehicles.cpp"
		#include "configs\weapons.cpp"
	};
};

