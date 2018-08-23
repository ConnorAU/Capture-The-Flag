class VehicleShopInfo {
	class QUADBIKE {
		rank=0;
		price=50;
		animations[]={};
		class west {
			classname="B_QUADBIKE_01_F";
			colorLayers[]={
				"a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_blue_co.paa",
				"a3\soft_f_beta\quadbike_01\data\quadbike_01_wheel_civblue_co.paa"
			};
			camoLayers[]={
				"a3\soft_f\quadbike_01\data\quadbike_01_co.paa",
				"a3\soft_f\quadbike_01\data\quadbike_01_wheel_co.paa"
			};
		};
		class east {
			classname="O_QUADBIKE_01_F";
			colorLayers[]={
				"a3\soft_f_beta\quadbike_01\data\quadbike_01_civ_red_co.paa",
				"a3\soft_f_beta\quadbike_01\data\quadbike_01_wheel_civred_co.paa"
			};
			camoLayers[]={
				"a3\soft_f\quadbike_01\data\quadbike_01_opfor_co.paa",
				"a3\soft_f\quadbike_01\data\quadbike_01_wheel_opfor_co.paa"
			};
		};
	};
	class OFFROAD {
		rank=2;
		price=200;
		animations[]={
			{"HideDoor1",1},
			{"HideDoor2",1},
			{"HideDoor3",1},
			{"HideBackpacks",0},
			{"HideBumper1",1},
			{"HideBumper2",0},
			{"HideConstruction",0}
		};
		class west {
			classname="B_G_Offroad_01_F";
			colorLayers[]={
				"a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa",
				"a3\soft_f\offroad_01\data\offroad_01_ext_base03_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_bootcamp\offroad_01\data\offroad_01_ext_ig_08_co.paa",
				"a3\soft_f_bootcamp\offroad_01\data\offroad_01_ext_ig_08_co.paa"
			};
		};
		class east {
			classname="O_G_Offroad_01_F";
			colorLayers[]={
				"a3\soft_f\offroad_01\data\offroad_01_ext_co.paa",
				"a3\soft_f\offroad_01\data\offroad_01_ext_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_bootcamp\offroad_01\data\offroad_01_ext_ig_06_co.paa",
				"a3\soft_f_bootcamp\offroad_01\data\offroad_01_ext_ig_06_co.paa"
			};
		};
	};
	class OFFROAD_ARMED: OFFROAD {
		rank=4;
		price=900;
		class west: west {
			classname="B_G_Offroad_01_armed_F";
		};
		class east: east {
			classname="O_G_Offroad_01_armed_F";
		};
	};
	class ZAMAK_TRANSPORT {
		rank=4;
		price=400;
		animations[]={};
		class west {
			classname="C_Truck_02_transport_F";
			colorLayers[]={
				"a3\soft_f_beta\truck_02\data\truck_02_kab_blue_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_kuz_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_beta\truck_02\data\truck_02_kab_indp_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_kuz_indp_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"
			};
		};
		class east {
			classname="C_Truck_02_transport_F";
			colorLayers[]={
				"a3\soft_f_beta\truck_02\data\truck_02_kab_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_kuz_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_beta\truck_02\data\truck_02_kab_opfor_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_kuz_opfor_co.paa",
				"a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"
			};
		};
	};
	class PROWLER_UNARMED {
		rank=6;
		price=600;
		animations[]={
			{"hidedoor1",1},
			{"hidedoor2",1},
			{"hidedoor3",1},
			{"hidedoor4",1}			
		};
		class west {
			classname="B_LSV_01_unarmed_F";
			colorName="Black";
			colorLayers[]={
				"a3\soft_f_exp\lsv_01\data\nato_lsv_01_black_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_02_black_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_03_black_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_adds_black_co.paa"
			};
		};
		/*class east {
			classname="B_LSV_01_unarmed_F";
			camoLayers[]={
				"a3\soft_f_exp\lsv_01\data\nato_lsv_01_sand_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_02_sand_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_03_sand_co.paa",
				"a3\soft_f_exp\lsv_01\data\nato_lsv_adds_sand_co.paa"
			};
		};*/
	};
	class QILIN_UNARMED {
		rank=6;
		price=600;
		animations[]={
			{"unarmed_doors_hide",1}		
		};
		/*class west {
			classname="O_LSV_02_unarmed_F";
			colorName="Black";
			colorLayers[]={
				"a3\soft_f_exp\lsv_02\data\csat_lsv_01_black_co.paa",
				"a3\soft_f_exp\lsv_02\data\csat_lsv_02_black_co.paa",
				"a3\soft_f_exp\lsv_02\data\csat_lsv_03_black_co.paa"
			};
		};*/
		class east {
			classname="O_LSV_02_unarmed_F";
			camoLayers[]={
				"a3\soft_f_exp\lsv_02\data\csat_lsv_01_arid_co.paa",
				"a3\soft_f_exp\lsv_02\data\csat_lsv_02_arid_co.paa",
				"a3\soft_f_exp\lsv_02\data\csat_lsv_03_arid_co.paa"
			};
		};
	};
	class VAN {
		rank=7;
		price=400;
		animations[]={};
		class west {
			classname="C_Van_02_transport_F";
			colorLayers[]={
				"a3\soft_f_orange\van_02\data\van_body_blue_co.paa",
				"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa",
				"a3\soft_f_orange\van_02\data\van_glass_transport_ca.paa",
				"a3\soft_f_orange\van_02\data\van_body_blue_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_orange\van_02\data\van_body_fia_01_co.paa",
				"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa",
				"a3\soft_f_orange\van_02\data\van_glass_transport_ca.paa",
				"a3\soft_f_orange\van_02\data\van_body_fia_01_co.paa"
			};
		};
		class east {
			classname="C_Van_02_transport_F";
			colorLayers[]={
				"a3\soft_f_orange\van_02\data\van_body_red_co.paa",
				"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa",
				"a3\soft_f_orange\van_02\data\van_glass_transport_ca.paa",
				"a3\soft_f_orange\van_02\data\van_body_red_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_orange\van_02\data\van_body_fia_02_co.paa",
				"a3\soft_f_orange\van_02\data\van_wheel_transport_co.paa",
				"a3\soft_f_orange\van_02\data\van_glass_transport_ca.paa",
				"a3\soft_f_orange\van_02\data\van_body_fia_02_co.paa"
			};
		};
	};
	class TEMPEST {
		rank=8;
		price=400;
		animations[]={};
		class east {
			classname="O_Truck_03_transport_F";
			camoLayers[]={
				"a3\soft_f_epc\truck_03\data\truck_03_ext01_co.paa",
				"a3\soft_f_epc\truck_03\data\truck_03_ext02_co.paa",
				"a3\soft_f_epc\truck_03\data\truck_03_cargo_co.paa"
			};
		};
	};
	class HEMTT {
		rank=8;
		price=400;
		animations[]={};
		class west {
			classname="B_Truck_01_transport_F";
			camoLayers[]={
				"a3\soft_f_beta\truck_01\data\truck_01_ext_01_co.paa",
				"a3\soft_f_beta\truck_01\data\truck_01_ext_02_co.paa"
			};
		};
	};
	class HUMMINGBIRD {
		rank=7;
		price=800;
		animations[]={};
		class west {
			classname="B_Heli_Light_01_F";
			colorLayers[]={
				"a3\air_f\heli_light_01\data\skins\heli_light_01_ext_jeans_co.paa"
			};
			camoLayers[]={
				"a3\air_f\heli_light_01\data\heli_light_01_ext_blufor_co.paa"
			};
		};
		class east {
			classname="B_Heli_Light_01_F";
			colorLayers[]={
				"a3\air_f\heli_light_01\data\skins\heli_light_01_ext_vrana_co.paa"
			};
			camoLayers[]={
				"a3\air_f\heli_light_01\data\skins\heli_light_01_ext_digital_co.paa"
			};
		};
	};
	class PROWLER_ARMED: PROWLER_UNARMED {
		rank=10;
		price=700;
		class west: west {
			classname="B_LSV_01_armed_F";
		};
		/*class east: east {
			classname="B_LSV_01_armed_F";
		};*/
	};
	class QILIN_ARMED: QILIN_UNARMED {
		rank=10;
		price=700;
		/*class west: west {
			classname="O_LSV_02_armed_F";
		};*/
		class east: east {
			classname="O_LSV_02_armed_F";
		};
	};
	class TARU {
		rank=14;
		price=800;
		animations[]={};
		class west {
			classname="O_Heli_Transport_04_bench_F";
			colorName="Black";
			colorLayers[]={
				"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_01_black_CO.paa",
				"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_02_black_CO.paa"				
			};
		};
		class east {
			classname="O_Heli_Transport_04_bench_F";
			camoLayers[]={
				"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_01_CO.paa",
				"a3\air_f_heli\heli_transport_04\data\heli_transport_04_base_02_CO.paa"
			};
		};
	};
	class ORCA {
		rank=15;
		price=800;
		animations[]={};
		class west {
			classname="O_Heli_Light_02_unarmed_F";
			colorName="Black";
			colorLayers[]={
				"a3\air_f\heli_light_02\data\heli_light_02_ext_co.paa"			
			};
		};
		class east {
			classname="O_Heli_Light_02_unarmed_F";
			camoLayers[]={
				"a3\air_f\heli_light_02\data\heli_light_02_ext_opfor_co.paa"			
			};
		};
	};
	class HATCHBACK {
		rank=20;
		price=200;
		animations[]={};
		class west {
			classname="C_Hatchback_01_F";
			colorLayers[]={
				"a3\soft_f_gamma\hatchback_01\data\hatchback_01_ext_base03_co.paa"
			};
		};
		class east {
			classname="C_Hatchback_01_F";
			colorName="Black";
			colorLayers[]={
				"a3\soft_f_gamma\hatchback_01\data\hatchback_01_ext_base09_co.paa"
			};
		};
	};
	/*class GHOSTHAWK {
		rank=26;
		price=1100;
		animations[]={};
		class west {
			classname="B_Heli_Transport_01_F";
			colorName="Black";
			colorLayers[]={
				"a3\air_f_beta\heli_transport_01\data\heli_transport_01_ext01_co.paa"				
			};
		};
		class east {
			classname="B_Heli_Transport_01_F";
			colorName="Olive";
			colorLayers[]={
				"a3\air_f_beta\heli_transport_01\data\heli_transport_01_ext01_blufor_co.paa"				
			};
		};
	};*/
	class SMALL_VAN_TRANSPORT {
		rank=34;
		price=400;
		animations[]={};
		class west {
			classname="C_Van_01_transport_F";
			colorLayers[]={
				"a3\soft_f_gamma\van_01\data\van_01_ext_black_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_adds_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_bootcamp\van_01\data\van_01_ext_ig_01_co.paa",
				"a3\soft_f_bootcamp\van_01\data\van_01_adds_ig_01_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"
			};
		};
		class east {
			classname="C_Van_01_transport_F";
			colorLayers[]={
				"a3\soft_f_gamma\van_01\data\van_01_ext_red_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_adds_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"
			};
			camoLayers[]={
				"a3\soft_f_bootcamp\van_01\data\van_01_ext_ig_08_co.paa",
				"a3\soft_f_bootcamp\van_01\data\van_01_adds_ig_08_co.paa",
				"a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"
			};
		};
	};
	class JEEP {
		rank=38;
		price=200;
		animations[]={
			{"hideleftdoor",1},
			{"hiderightdoor",1},
			{"hidereardoor",0},
			{"hidebullbar",0},
			{"hidefenders",0},
			{"hideheadsupportfront",1},
			{"hideheadsupportrear",1},
			{"hiderollcage",1},
			{"hideseatsrear",0},
			{"hidesparewheel",1}
		};
		class west {
			classname="C_Offroad_02_unarmed_F";
			colorLayers[]={
				"a3\soft_f_exp\offroad_02\data\offroad_02_ext_blue_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_ext_blue_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_int_blue_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_int_blue_co.paa"
			};
		};
		class east {
			classname="C_Offroad_02_unarmed_F";
			colorLayers[]={
				"a3\soft_f_exp\offroad_02\data\offroad_02_ext_red_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_ext_red_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_int_red_co.paa",
				"a3\soft_f_exp\offroad_02\data\offroad_02_int_red_co.paa"
			};
		};
	};
	class SUV {
		rank=40;
		price=200;
		animations[]={};
		class west {
			classname="C_SUV_01_F";
			colorName="Black";
			colorLayers[]={
				"a3\soft_f_gamma\suv_01\data\suv_01_ext_02_co.paa"
			};
		};
		class east {
			classname="C_SUV_01_F";
			colorLayers[]={
				"a3\soft_f_gamma\suv_01\data\suv_01_ext_co.paa"
			};
		};
	};
	class HATCHBACK_SPORT {
		rank=42;
		price=200;
		animations[]={};
		class west {
			classname="C_Hatchback_01_sport_F";
			colorLayers[]={
				"a3\soft_f_gamma\hatchback_01\data\hatchback_01_ext_sport02_co.paa"
			};
		};
		class east {
			classname="C_Hatchback_01_sport_F";
			colorLayers[]={
				"a3\soft_f_gamma\hatchback_01\data\hatchback_01_ext_sport01_co.paa"
			};
		};
	};
	class KART {
		rank=50;
		price=75;
		animations[]={};
		class west {
			classname="C_Kart_01_F";
			colorLayers[]={
				"a3\soft_f_kart\kart_01\data\kart_01_base_blue_co.paa",
				""
			};
		};
		class east {
			classname="C_Kart_01_F";
			colorLayers[]={
				"a3\soft_f_kart\kart_01\data\kart_01_base_red_co.paa",
				""
			};
		};
	};
};
