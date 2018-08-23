class ZoneWarningTemplate {
	class preRound {
		text="The round hasn't started yet, please go back: %1";
		time=15;
		timeModifier="_this";
		//timeModifier="(CaptureTheFlag_info_roundStartTick-time) min _this";
		expression="\
			player setdamage 0.95;\
			waituntil {lifestate player == 'Incapacitated'};\
			player call CaptureTheFlag_c_medical_forceRespawn;\
		";
	};
	class outsideAO {
		text="You have left the AO, please go back: %1";
		time=15;
		timeModifier="_this";
		expression="\
			player setdamage 0.95;\
			waituntil {lifestate player == 'Incapacitated'};\
			player call CaptureTheFlag_c_medical_forceRespawn;\
		";
	};
	class inEnemySZ {
		text="You have entered the enemy safezone, please go back: %1";
		time=10;
		timeModifier="_this";
		expression="\
			player setdamage 0.95;\
			waituntil {lifestate player == 'Incapacitated'};\
			player call CaptureTheFlag_c_medical_forceRespawn;\
		";
	};
	class inFriendlySZWithFlag {
		text="You have entered your safezone with the flag, please go back: %1";
		time=10;
		timeModifier="_this";
		expression="\
			player setdamage 0.95;\
			waituntil {lifestate player == 'Incapacitated'};\
			player call CaptureTheFlag_c_medical_forceRespawn;\
		";
	};
};