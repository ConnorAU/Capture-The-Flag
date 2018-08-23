class evh {
	class functions {
		class addGlobalEVHs {};
		class dammaged {};
		class firedMan {};
		class getInMan {};
		class getOutMan {};
		class handleDamage {
			compileOnServer=1;
		};
		class handleHeal {};
		class hitPart {};
		class keyDown {};
		class keyUp {};
		class respawn {};
		class inventoryOpened {};
		class killed {
			compileOnServer=1;
		};
	};
	class configs {
		#include "configs\KeyDown.cpp"
		#include "configs\KeyUp.cpp"
	};
};

