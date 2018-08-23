class Events {
	class Default {
		text="";
		currency=0;
		currencyModifier="1";
		experience=0;
		experienceModifier="1";
		statCondition="true";
		statExpression="";
	};

	class rank: Default {
		text="You have ranked up!";
		currency=500;
		statExpression="\
			playSound 'RankUp';\
			CaptureTheFlag_statistic_rank=CaptureTheFlag_statistic_rank+1;\
			player setVariable ['rank',CaptureTheFlag_statistic_rank,true];\
			['updateRank'] call CaptureTheFlag_c_ui_HUD_Main;\
		";
	};
	class round_victory: Default {
		text="Victory Bonus";
		currency=500;
		currencyModifier="['round_victory_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=1000;
		experienceModifier="['round_victory_e'] call CaptureTheFlag_c_session_eventModifier";
	};
	class round_defeat: Default {};
	class refund_vehicles: Default {
		text="Alive Vehicles Refunded";
		currency=1;
		currencyModifier="['refund_vehicles_c'] call CaptureTheFlag_c_session_eventModifier";
		statCondition="false";
	};


	class kills_normal: Default {
		text="Killed Enemy";
		currency=150;
		experience=250;
		statExpression="[] call CaptureTheFlag_c_events_killStreak";
	};


	class kills_assist: Default {
		text="Kill Assist";
		currency=50;
		experience=100;
	};
	class kills_assist_driver: Default {
		text="Driver Kill Assist";
		currency=50;
		experience=100;
	};
	class kills_roadkill: Default {
		text="Road Kill";
		currency=50;
		experience=100;
	};
	class kills_headshot: Default {
		text="Headshot";
		currency=50;
		experience=100;
	};
	class kills_longdistance: Default {
		text="Long Distance Kill";
		currency=50;
		experience=100;
	};
	class kills_avenger: Default {
		text="Avenger";
		currency=50;
		experience=100;
	};


	class kills_doublekill: Default {
		text="Double Kill";
		currency=20;
		experience=100;
	};
	class kills_triplekill: Default {
		text="Triple Kill";
		currency=40;
		experience=120;
	};
	class kills_quadkill: Default {
		text="Quad Kill";
		currency=60;
		experience=140;
	};
	class kills_pentakill: Default {
		text="Penta Kill";
		currency=80;
		experience=160;
	};
	class kills_killfeed: Default {
		text="Insane Kill Feed";
		currency=100;
		experience=180;
	};



	class deaths: Default {};
	class revive_player: Default {
		text="Revive Teammate";
		currency=50;
		experience=100;
	};
	class revived: Default {};
	class heal_player: Default {
		//text="Heal Teammate";
		//currency=50;
		//currencyModifier="['heal_player_c',_this] call CaptureTheFlag_c_session_eventModifier";
		//experience=100;
		//experienceModifier="['heal_player_e',_this] call CaptureTheFlag_c_session_eventModifier";
	};
	class healed: Default {};
	class execute_player: Default {
		text="Executed Enemy";
		currency=50;
		experience=100;
	};
	class executed: Default {};
	class repaired_vehicle: Default {
		text="Repaired Vehicle";
		currency=50;
		currencyModifier="['repaired_vehicle_c',_this] call CaptureTheFlag_c_session_eventModifier";
		experience=100;
		experienceModifier="['repaired_vehicle_e',_this] call CaptureTheFlag_c_session_eventModifier";
		statExpression="_this setVariable ['repaired',true];";
	};
	class player_delivered_to_ao_ground: Default {
		text="Teammate Transported";
		currency=100;
		currencyModifier="['player_delivered_to_ao_ground_c',_this] call CaptureTheFlag_c_session_eventModifier";
		experience=150;
		experienceModifier="['player_delivered_to_ao_ground_e',_this] call CaptureTheFlag_c_session_eventModifier";
		statCondition="!(_this in CaptureTheFlag_session_unitsDeliveredToAO)";
		statExpression="CaptureTheFlag_session_unitsDeliveredToAO=CaptureTheFlag_session_unitsDeliveredToAO-[objNull];CaptureTheFlag_session_unitsDeliveredToAO pushback _this";
	};
	class player_delivered_to_ao_air: player_delivered_to_ao_ground {
		text="Paratrooper Transported";
		currency=50;
		currencyModifier="['player_delivered_to_ao_air_c',_this] call CaptureTheFlag_c_session_eventModifier";
		experience=100;
		experienceModifier="['player_delivered_to_ao_air_e',_this] call CaptureTheFlag_c_session_eventModifier";
	};
	class enemy_vehicles_destroyed: Default {
		text="Enemy Vehicle Destroyed";
		currency=50;
		experience=100;
	};



	class flag_captures: Default {
		text="Flag Captured";
		currency=200;
		currencyModifier="['flag_captures_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=400;
		experienceModifier="['flag_captures_e'] call CaptureTheFlag_c_session_eventModifier";
	};
	class flag_steals: Default {
		text="Flag Steal";
		currency=150;
		currencyModifier="['flag_steals_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=300;
		experienceModifier="['flag_steals_e'] call CaptureTheFlag_c_session_eventModifier";
	};
	class flag_pickups: Default {
		text="Flag Pickup";
		currency=100;
		currencyModifier="['flag_pickups_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=200;
		experienceModifier="['flag_pickups_e'] call CaptureTheFlag_c_session_eventModifier";
	};
	class flag_returns: Default {
		text="Flag Returned";
		currency=100;
		currencyModifier="['flag_returns_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=200;
		experienceModifier="['flag_returns_e'] call CaptureTheFlag_c_session_eventModifier";
	};
	class flag_drops: Default {};
	class flag_team_capture_bonus: Default {
		text="Team Capture Bonus";
		currency=50;
		currencyModifier="['flag_team_capture_bonus_c'] call CaptureTheFlag_c_session_eventModifier";
		experience=100;
		experienceModifier="['flag_team_capture_bonus_e'] call CaptureTheFlag_c_session_eventModifier";
		statCondition="false";
	};

};