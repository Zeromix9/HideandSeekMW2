#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

checkMap()
{
	self endon("disconnect");
	self thread UnSupportedMaps();
	level.Mapname = getDvar("mapname");
	i = 1;
	while(i < 2)
	{
		if(level.Mapname==level.UnSupp[i].name)
		{
			i = 3;
			level notify("unsupported");
			level.NotSupported = 1;
			self thread EndGame();
		}
		i++;
	}	
	self thread execMapVariables();;
}

EndGame()
{
	self endon("disconnect");
	p = 10;
	for(;;)
	{
		self sayall("^1MAP NOT SUPPORTED! CHANGING MAP IN: " + p);
		if(p==0)
		{
			map("mp_afghan");
		}
		wait 1;
		p--;
	}
}

UnSupportedMaps()
{
	level.UnSupp = [];
	level.UnSupp[1] = supMap("mp_rust");
	level.UnSupp[2] = supMap("mp_brecourt");
}

supMap(Mapname)
{
	Map = spawnstruct();
	Map.name = Mapname;
	return Map;
}

execMapVariables() //This thread sucks but we couldn't find any good alternative
{
	self endon("disconnect");
	self endon("unsupported");
	{
		if(level.Mapname=="mp_afghan")
		{
			self thread mp_afghan();
		}
		else if(level.Mapname=="mp_derail")
		{
			self thread mp_derail();
		}
		else if(level.Mapname=="mp_boneyard")
		{
			self thread mp_boneyard();
		}
		else if(level.Mapname=="mp_underpass")
		{
			self thread mp_underpass();
		}
		else if(level.Mapname=="mp_highrise")
		{
			self thread mp_highrise();
		}
		else if(level.Mapname=="mp_estate")
		{
			self thread mp_estate();
		}
		else if(level.Mapname=="mp_terminal")
		{
			self thread mp_terminal();
		}
		else if(level.Mapname=="mp_subbase")
		{
			self thread mp_subbase();
		}
		else if(level.Mapname=="mp_favela")
		{
			self thread mp_favela();
		}
		else if(level.Mapname=="mp_checkpoint")
		{
			self thread mp_checkpoint();
		}
		else if(level.Mapname=="mp_invasion")
		{
			self thread mp_invasion();
		}
		else if(level.Mapname=="mp_quarry")
		{
			self thread mp_quarry();
		}
		else if(level.Mapname=="mp_nightshift")
		{
			self thread mp_nightshift();
		}
		else if(level.Mapname=="mp_rundown")
		{
			self thread mp_rundown();
		}
		else if(level.Mapname=="mp_crash")
		{
			self thread mp_crash();
		}
		else if(level.Mapname=="mp_complex")
		{
			self thread mp_complex();
		}
		else if(level.Mapname=="mp_overgrown")
		{
			self thread mp_overgrown();
		}
		else if(level.Mapname=="mp_compact")
		{
			self thread mp_compact();
		}
		else if(level.Mapname=="mp_trailerpark")
		{
			self thread mp_trailerpark();
		}
		else if(level.Mapname=="mp_abandon")
		{
			self thread mp_abandon();
		}
		else if(level.Mapname=="mp_storm")
		{
			self thread mp_storm();
		}
		else if(level.Mapname=="mp_vacant")
		{
			self thread mp_vacant();
		}
		else if(level.Mapname=="mp_strike")
		{
			self thread mp_strike();
		}
		else if(level.Mapname=="mp_fuel2")
		{
			self thread mp_fuel2();
		}
	}
}

mp_afghan()
{
		level.ModelList = [];
		level.MaxModels = 14;
		// Modelname
		level.ModelList[1] = createModel("machinery_oxygen_tank01", "Oxygen Tank orange");
		level.ModelList[2] = createModel("foliage_pacific_bushtree02_animated", "Big bush");
		level.ModelList[3] = createModel("foliage_cod5_tree_jungle_02_animated", "Tree");
		level.ModelList[4] = createModel("machinery_oxygen_tank02", "Oxygen Tank green");
		level.ModelList[5] = createModel("com_barrel_russian_fuel_dirt", "Fuel barrel");
		level.ModelList[6] = createModel("com_locker_double", "Locker");
		level.ModelList[7] = createModel("foliage_pacific_bushtree02_halfsize_animated", "Small desert bush");
		level.ModelList[8] = createModel("com_plasticcase_black_big_us_dirt", "Ammo crate");
		level.ModelList[9] = createModel("foliage_pacific_bushtree01_halfsize_animated", "Small green bush");
		level.ModelList[10] = createModel("vehicle_uaz_open_destructible", "Military vehicle open");
		level.ModelList[11] = createModel("vehicle_hummer_destructible", "Hummer");
		level.ModelList[12] = createModel("foliage_cod5_tree_pine05_large_animated", "Tree 2");
		level.ModelList[13] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[14] = createModel("utility_water_collector", "Water collector");
}

mp_derail()
{
		level.ModelList = [];
		level.MaxModels = 14;
		// Modelname
		level.ModelList[1] = createModel("com_roofvent2_animated", "Roof ventilator");
		level.ModelList[2] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[3] = createModel("com_tv1_testpattern", "TV");
		level.ModelList[4] = createModel("usa_gas_station_trash_bin_02", "Trash bin");
		level.ModelList[5] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[6] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[7] = createModel("com_trashbin01", "Trash bin 2");
		level.ModelList[8] = createModel("vehicle_pickup_destructible_mp", "Pickup");
		level.ModelList[9] = createModel("furniture_gaspump01_damaged", "Gas pump");
		level.ModelList[10] = createModel("vehicle_uaz_winter_destructible", "Winter vehicle");
		level.ModelList[11] = createModel("com_propane_tank02", "Big propane tank");
		level.ModelList[12] = createModel("crashed_satellite", "Crashed satellite");
		level.ModelList[13] = createModel("vehicle_bm21_cover_destructible", "Military truck");
		level.ModelList[14] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_boneyard()
{
		level.ModelList = [];
		level.MaxModels = 14;
		// Modelname
		level.ModelList[1] = createModel("foliage_tree_oak_1_animated2", "Tree");
		level.ModelList[2] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[4] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[5] = createModel("com_electrical_transformer_large_dam", "Large transformer");
		level.ModelList[6] = createModel("vehicle_moving_truck_destructible", "Truck");
		level.ModelList[7] = createModel("foliage_pacific_bushtree02_animated", "Bush");
		level.ModelList[8] = createModel("vehicle_pickup_destructible_mp", "Pickup");
		level.ModelList[9] = createModel("com_trashbin02", "Trash bin");
		level.ModelList[10] = createModel("vehicle_bm21_mobile_bed_destructible", "Military truck");
		level.ModelList[11] = createModel("foliage_cod5_tree_jungle_02_animated", "Tree 2");
		level.ModelList[12] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[13] = createModel("machinery_generator", "Generator");
		level.ModelList[14] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_underpass()
{
		level.ModelList = [];
		level.MaxModels = 19;
		// Modelname
		level.ModelList[1] = createModel("foliage_pacific_bushtree01_halfsize_animated", "Small green bush");
		level.ModelList[2] = createModel("utility_water_collector", "Water collector");
		level.ModelList[3] = createModel("com_propane_tank02", "Large propane tank");
		level.ModelList[4] = createModel("foliage_pacific_bushtree01_animated", "Big green bush");
		level.ModelList[5] = createModel("vehicle_van_slate_destructible", "Blue van");
		level.ModelList[6] = createModel("com_locker_double", "Locker");
		level.ModelList[7] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[8] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[9] = createModel("usa_gas_station_trash_bin_02", "Trash bin");
		level.ModelList[10] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[11] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[12] = createModel("vehicle_pickup_destructible_mp", "White pickup");
		level.ModelList[13] = createModel("foliage_cod5_tree_jungle_02_animated", "Tall tree");
		level.ModelList[14] = createModel("foliage_tree_oak_1_animated2", "Tree");
		level.ModelList[15] = createModel("foliage_pacific_palms08_animated", "Small green bush 2");
		level.ModelList[16] = createModel("chicken_black_white", "Chicken black-white");
		level.ModelList[17] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[18] = createModel("utility_transformer_small01", "Small transformer");
		level.ModelList[19] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_highrise()
{
		level.ModelList = [];
		level.MaxModels = 12;
		// Modelname
		level.ModelList[1] = createModel("ma_flatscreen_tv_wallmount_01", "Flatscreen TV");
		level.ModelList[2] = createModel("com_trashbin02", "Black trash bin");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[4] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[5] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[6] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[7] = createModel("com_electrical_transformer_large_dam", "Large electrical transformer");
		level.ModelList[8] = createModel("com_roofvent2_animated", "Roof ventilator");
		level.ModelList[9] = createModel("com_propane_tank02", "Large propane tank");
		level.ModelList[10] = createModel("highrise_fencetarp_04", "Large green fence");
		level.ModelList[11] = createModel("highrise_fencetarp_05", "Small orange fence");
		level.ModelList[12] = createModel("com_barrel_benzin", "Benzin barrel");
		level.ModelList[13] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}


mp_estate() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 10;
		// Modelname
		level.ModelList[1] = createModel("machinery_generator", "Small generator");
		level.ModelList[2] = createModel("vehicle_pickup_destructible_mp", "White pickup");
		level.ModelList[3] = createModel("vehicle_coupe_white_destructible", "Small white car");
		level.ModelList[4] = createModel("vehicle_suburban_destructible_dull", "Big black car");
		level.ModelList[5] = createModel("vehicle_luxurysedan_2008_destructible", "Small black car");
		level.ModelList[6] = createModel("com_electrical_transformer_large_dam", "Large electrical transformer");
		level.ModelList[7] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[8] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[9] = createModel("ma_flatscreen_tv_on_wallmount_02", "Flatscreen TV");
		level.ModelList[10] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_terminal() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 13;
		// Modelname
		level.ModelList[1] = createModel("com_tv1", "TV");
		level.ModelList[2] = createModel("com_barrel_benzin", "Benzin barrel");
		level.ModelList[3] = createModel("foliage_pacific_fern01_animated", "Small Bush");
		level.ModelList[4] = createModel("ma_flatscreen_tv_wallmount_02", "Flatscreen TV");
		level.ModelList[5] = createModel("com_roofvent2_animated", "Roof ventilator");
		level.ModelList[6] = createModel("ma_flatscreen_tv_on_wallmount_02_static", "Flatscreen TV On");
		level.ModelList[7] = createModel("vehicle_policecar_lapd_destructible", "Police car");
		level.ModelList[8] = createModel("com_vending_can_new2_lit", "Vending machine");
		level.ModelList[9] = createModel("usa_gas_station_trash_bin_01", "Trash bin");
		level.ModelList[10] = createModel("foliage_cod5_tree_pine05_large_animated", "Tree");
		level.ModelList[11] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[12] = createModel("com_plasticcase_black_big_us_dirt", "Ammo crate");
		level.ModelList[13] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_subbase()
{
		level.ModelList = [];
		level.MaxModels = 8;
		// Modelname
		level.ModelList[1] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[2] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[3] = createModel("com_trashcan_metal_closed", "Metal trash bin");
		level.ModelList[4] = createModel("com_tv1", "TV");
		level.ModelList[5] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[6] = createModel("com_locker_double", "Locker");
		level.ModelList[7] = createModel("vehicle_uaz_winter_destructible", "Military vehicle");
		level.ModelList[8] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_checkpoint() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 8;
		// Modelname
		level.ModelList[1] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[2] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[3] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[4] = createModel("com_newspaperbox_red", "Red newspaper box");
		level.ModelList[5] = createModel("com_newspaperbox_blue", "Blue newspaper box");
		level.ModelList[6] = createModel("com_tv1", "TV");
		level.ModelList[7] = createModel("vehicle_moving_truck_destructible", "Truck");
		level.ModelList[8] = createModel("chicken_black_white", "Chicken black-white");
		level.ModelList[9] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_invasion() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 13;
		// Modelname
		level.ModelList[1] = createModel("com_trashbin01", "Green trash bin");
		level.ModelList[2] = createModel("com_trashbin02", "Black trash bin");
		level.ModelList[3] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[4] = createModel("com_newspaperbox_blue", "Blue newspaper box");
		level.ModelList[5] = createModel("com_newspaperbox_red", "Red newspaper box");
		level.ModelList[6] = createModel("furniture_gaspump01_damaged", "Gas pump");
		level.ModelList[7] = createModel("vehicle_80s_wagon1_red_destructible_mp", "Red car");
		level.ModelList[8] = createModel("vehicle_hummer_destructible", "Hummer");
		level.ModelList[9] = createModel("vehicle_taxi_yellow_destructible", "Taxi");
		level.ModelList[10] = createModel("vehicle_uaz_open_destructible", "Military vehicle open");
		level.ModelList[11] = createModel("utility_transformer_small01", "Transformer");
		level.ModelList[12] = createModel("foliage_tree_palm_tall_1", "Palm tree tall");
		level.ModelList[13] = createModel("foliage_tree_palm_bushy_1", "Palm tree bushy");
}

mp_quarry() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 20;
		// Modelname
		level.ModelList[1] = createModel("foliage_pacific_bushtree02_animated", "Small bush");
		level.ModelList[2] = createModel("foliage_tree_oak_1_animated2", "Big bush");
		level.ModelList[3] = createModel("foliage_cod5_tree_jungle_02_animated", "Tree");
		level.ModelList[4] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[5] = createModel("machinery_generator", "Small generator");
		level.ModelList[6] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[7] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[8] = createModel("utility_transformer_small01", "Small transformer");
		level.ModelList[9] = createModel("com_locker_double", "Locker");
		level.ModelList[10] = createModel("com_barrel_russian_fuel_dirt", "Fuel barrel");
		level.ModelList[11] = createModel("com_tv1", "TV");
		level.ModelList[12] = createModel("vehicle_van_green_destructible", "Green van");
		level.ModelList[13] = createModel("vehicle_van_white_destructible", "White van");
		level.ModelList[14] = createModel("vehicle_pickup_destructible_mp", "White pickup");
		level.ModelList[15] = createModel("vehicle_small_hatch_turq_destructible_mp", "Small white car");
		level.ModelList[16] = createModel("vehicle_uaz_open_destructible", "Military vehicle");
		level.ModelList[17] = createModel("vehicle_moving_truck_destructible", "White truck");
		level.ModelList[18] = createModel("usa_gas_station_trash_bin_02", "Trash bin");
		level.ModelList[19] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[20] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_nightshift() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 10;
		// Modelname
		level.ModelList[1] = createModel("com_trashbin01", "Green trash bin");
		level.ModelList[2] = createModel("com_trashbin02", "Black trash bin");
		level.ModelList[3] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[4] = createModel("com_newspaperbox_red", "Red newspaper box");
		level.ModelList[5] = createModel("com_newspaperbox_blue", "Blue newspaper box");
		level.ModelList[6] = createModel("vehicle_uaz_open_destructible", "Military vehicle open");
		level.ModelList[7] = createModel("vehicle_van_white_destructible", "White car");
		level.ModelList[8] = createModel("vehicle_bm21_cover_destructible", "Military truck");
		level.ModelList[9] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[10] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}

mp_favela() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 15;
		// Modelname
		level.ModelList[1] = createModel("utility_transformer_small01", "Small Transformer");
		level.ModelList[2] = createModel("vehicle_small_hatch_white_destructible_mp", "Small white car");
		level.ModelList[3] = createModel("vehicle_small_hatch_blue_destructible_mp", "Small blue car");
		level.ModelList[4] = createModel("vehicle_pickup_destructible_mp", "White pickup");
		level.ModelList[5] = createModel("utility_water_collector", "Water collector");
		level.ModelList[6] = createModel("com_tv2", "TV");
		level.ModelList[7] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[8] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[9] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[10] = createModel("foliage_tree_palm_bushy_3", "Palm tree");
		level.ModelList[11] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[12] = createModel("com_newspaperbox_red", "Red newspaperbox");
		level.ModelList[13] = createModel("com_newspaperbox_blue", "Blue newspaperbox");
		level.ModelList[14] = createModel("com_trashbin01", "Green trash bin");
		level.ModelList[15] = createModel("com_trashbin02", "Black trash bin");
}

mp_rundown() //Thanks to ezr
{
		level.ModelList = [];
		level.MaxModels = 18;
		// Modelname
		level.ModelList[1] = createModel("com_tv1", "TV");
		level.ModelList[2] = createModel("com_tv2", "TV 2");
		level.ModelList[3] = createModel("com_trashbin01", "Green trash bin");
		level.ModelList[4] = createModel("com_trashbin02", "Black trash bin");
		level.ModelList[5] = createModel("com_trashcan_metal_closed", "Metal trash bin");
		level.ModelList[6] = createModel("vehicle_small_hatch_white_destructible_mp", "White car");
		level.ModelList[7] = createModel("vehicle_small_hatch_blue_destructible_mp", "Blue car");
		level.ModelList[8] = createModel("vehicle_uaz_open_destructible", "Russian military vehicle");
		level.ModelList[9] = createModel("vehicle_bm21_mobile_bed_destructible", "Military truck");
		level.ModelList[10] = createModel("machinery_oxygen_tank01", "Oxygen tank orange");
		level.ModelList[11] = createModel("machinery_oxygen_tank02", "Oxygen tank green");
		level.ModelList[12] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[13] = createModel("foliage_tree_palm_bushy_1", "Palm tree");
		level.ModelList[14] = createModel("foliage_pacific_fern01_animated", "Small bush");
		level.ModelList[15] = createModel("utility_transformer_small01", "Small transformer");
		level.ModelList[16] = createModel("utility_water_collector", "Water collector");
		level.ModelList[17] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[18] = createModel("chicken_black_white", "Chicken black-white");
}

//DLC MAPS, Thanks to ezr

mp_crash()
{
		level.ModelList = [];
		level.MaxModels = 13;
		//Modelname
		level.ModelList[1] = createModel("com_tv1", "TV");
		level.ModelList[2] = createModel("com_tv2", "TV 2");
		level.ModelList[3] = createModel("ma_flatscreen_tv_wallmount_01", "Flatscreen");
		level.ModelList[4] = createModel("ma_flatscreen_tv_wallmount_02", "Flatscreen 2");
		level.ModelList[5] = createModel("foliage_tree_river_birch_xl_a_animated", "Birch Tree Tall");
		level.ModelList[6] = createModel("foliage_tree_palm_bushy_3", "Palm Tree");
		level.ModelList[7] = createModel("foliage_tree_river_birch_med_a_animated", "Birch Tree Small");
		level.ModelList[8] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[9] = createModel("utility_transformer_small01", "Small Transformer");
		level.ModelList[10] = createModel("vehicle_80s_sedan1_brn_destructible_mp", "Brown Sedan");
		level.ModelList[11] = createModel("vehicle_80s_sedan1_green_destructible_mp", "Green Sedan");
		level.ModelList[12] = createModel("vehicle_80s_sedan1_red_destructible_mp", "Red Sedan");
		level.ModelList[13] = createModel("vehicle_pickup_destructible_mp", "White Pickup");
}

mp_complex()
{
		level.ModelList = [];
		level.MaxModels = 19;
		//Modelname
		level.ModelList[1] = createModel("usa_gas_station_trash_bin_02", "Trashbin");
		level.ModelList[2] = createModel("usa_gas_station_trash_bin_02_base", "Trashbin 2");
		level.ModelList[3] = createModel("ma_flatscreen_tv_on_02", "Flatscreen");
		level.ModelList[4] = createModel("ma_flatscreen_tv_on_wallmount_02_static", "Flatscreen static");
		level.ModelList[5] = createModel("arcade_machine_1", "Arcade Machine");
		level.ModelList[6] = createModel("arcade_machine_2", "Arcade Machine 2");
		level.ModelList[7] = createModel("pinball_machine_1", "Pinball Machine");
		level.ModelList[8] = createModel("pinball_machine_2", "Pinball Machine 2");
		level.ModelList[9] = createModel("foliage_tree_green_pine_lg_b_animated", "Pine");
		level.ModelList[10] = createModel("foliage_tree_green_pine_lg_a_animated", "Pine 2");
		level.ModelList[11] = createModel("foliage_pacific_palms06_animated", "Small Palm");
		level.ModelList[12] = createModel("foliage_pacific_tropic_shrub01_animated", "Tropic Palms");
		level.ModelList[13] = createModel("vehicle_subcompact_black_destructible", "Black Car");
		level.ModelList[14] = createModel("vehicle_subcompact_slate_destructible", "Blue Car");
		level.ModelList[15] = createModel("vehicle_pickup_destructible_mp", "White Pickup");
		level.ModelList[16] = createModel("vehicle_coupe_blue_destructible", "Blue Coupe");
		level.ModelList[17] = createModel("vehicle_coupe_white_destructible", "White Coupe");
		level.ModelList[18] = createModel("vehicle_policecar_lapd_destructible", "Police Car");
		level.ModelList[19] = createModel("vehicle_moving_truck_destructible", "White Truck");
}

mp_overgrown()
{
		level.ModelList = [];
		level.MaxModels = 8;
		//Modelname
		level.ModelList[1] = createModel("foliage_tree_river_birch_xl_a_animated", "Birch");
		level.ModelList[2] = createModel("foliage_tree_river_birch_lg_a_animated", "Birch 2");
		level.ModelList[3] = createModel("foliage_red_pine_xl_animated", "Pine");
		level.ModelList[4] = createModel("foliage_red_pine_xxl_animated", "Pine Tall");
		level.ModelList[5] = createModel("foliage_red_pine_med_animated", "Pine Small");
		level.ModelList[6] = createModel("foliage_tree_grey_oak_xl_a_animated", "Tall Tree");
		level.ModelList[7] = createModel("com_propane_tank02", "Big Propane Tank");
		level.ModelList[8] = createModel("furniture_gaspump01_damaged", "Gaspump");
}

mp_compact()
{
		level.ModelList = [];
		level.MaxModels = 9;
		//Modelname
		level.ModelList[1] = createModel("com_locker_double", "Locker");
		level.ModelList[2] = createModel("machinery_generator", "Small Generator");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File Cabinet");
		level.ModelList[4] = createModel("com_propane_tank02", "Big Propane Tank");
		level.ModelList[5] = createModel("machinery_oxygen_tank01", "Oxygentank Orange");
		level.ModelList[6] = createModel("me_rooftop_tank_01", "Tank rooftop");
		level.ModelList[7] = createModel("com_electrical_transformer_large_dam", "Large Transformer");
		level.ModelList[8] = createModel("com_tv1", "TV");
		level.ModelList[9] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
}


mp_trailerpark()
{
		level.ModelList = [];
		level.MaxModels = 17;
		//Modelname
		level.ModelList[1] = createModel("prop_trailerpark_beer_keg", "Beer keg");
		level.ModelList[2] = createModel("foliage_dead_pine_med_animated", "Tree");
		level.ModelList[3] = createModel("foliage_dead_pine_lg_animated", "Tree 2");
		level.ModelList[4] = createModel("com_propane_tank02", "Big Propane Tank");
		level.ModelList[5] = createModel("com_propane_tank03", "Propane Tank");
		level.ModelList[6] = createModel("machinery_oxygen_tank01", "Orange Oxygen Tank");
		level.ModelList[7] = createModel("machinery_oxygen_tank02", "Green Oxygen Tank");
		level.ModelList[8] = createModel("com_trashbin02", "Trashbin");
		level.ModelList[9] = createModel("machinery_generator", "Generator");
		level.ModelList[10] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[11] = createModel("utility_transformer_ratnest01", "Transformer");
		level.ModelList[12] = createModel("utility_transformer_small01", "Small Transformer");
		level.ModelList[13] = createModel("vehicle_subcompact_gray_destructible", "Gray Car");
		level.ModelList[14] = createModel("vehicle_coupe_white_destructible", "White Coupe");
		level.ModelList[15] = createModel("vehicle_80s_hatch1_green_destructible_mp", "Green Car");
		level.ModelList[16] = createModel("vehicle_80s_sedan1_red_destructible_mp", "Red Car");
		level.ModelList[17] = createModel("vehicle_delivery_truck_white", "White Truck");
}

mp_abandon()
{
		level.ModelList = [];
		level.MaxModels = 13;
		//Modelname
		level.ModelList[1] = createModel("popcorn_cart", "Popcorn cart");
		level.ModelList[2] = createModel("prop_trailerpark_beer_keg", "Beer keg");
		level.ModelList[3] = createModel("usa_gas_station_trash_bin_01", "Trashbin");
		level.ModelList[4] = createModel("trashcan_clown", "Clown trashbin");
		level.ModelList[5] = createModel("foliage_tree_river_birch_xl_a_animated", "Birch");
		level.ModelList[6] = createModel("arcade_machine_1", "Arcade Machine");
		level.ModelList[7] = createModel("arcade_machine_1_des", "Destroyed Arcade Machine");
		level.ModelList[8] = createModel("arcade_machine_2", "Arcade Machine 2");
		level.ModelList[9] = createModel("pinball_machine_1", "Pinball Machine");
		level.ModelList[10] = createModel("pinball_machine_2", "Pinball Machine 2");
		level.ModelList[11] = createModel("pinball_machine_2_des", "Destroyed Pinball Machine 2");
		level.ModelList[12] = createModel("fortune_machine", "Fortune Machine");
		level.ModelList[13] = createModel("vehicle_theme_park_truck", "Park Truck");
}

mp_storm()
{
		level.ModelList = [];
		level.MaxModels = 12;
		//Modelname
		level.ModelList[1] = createModel("com_tv1", "TV");
		level.ModelList[2] = createModel("com_trashbin01", "Trash bin");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[4] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
		level.ModelList[5] = createModel("foliage_dead_pine_lg_animated", "Tree");
		level.ModelList[6] = createModel("foliage_dead_pine_med_animated", "Tree 2");
		level.ModelList[7] = createModel("foliage_tree_oak_1_animated2", "Tree 3");
		level.ModelList[8] = createModel("vehicle_80s_wagon1_green_destructible_mp", "Green car");
		level.ModelList[9] = createModel("vehicle_80s_sedan1_silv_destructible_mp", "Silver car");
		level.ModelList[10] = createModel("vehicle_80s_hatch2_yel_destructible_mp", "Yellow car");
		level.ModelList[11] = createModel("vehicle_moving_truck_destructible", "White Truck");
		level.ModelList[12] = createModel("vehicle_mack_truck_short_white_destructible", "Big Truck");
}

mp_vacant()
{
		level.ModelList = [];
		level.MaxModels = 14;
		//Modelname
		level.ModelList[1] = createModel("machinery_generator", "Generator");
		level.ModelList[2] = createModel("machinery_oxygen_tank02", "Green Oxygen tank");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[4] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
		level.ModelList[5] = createModel("foliage_tree_birch_red_1_animated", "Birch");
		level.ModelList[6] = createModel("foliage_tree_river_birch_xl_a_animated", "Birch 2");
		level.ModelList[7] = createModel("com_locker_double", "Locker");
		level.ModelList[8] = createModel("utility_transformer_small01", "Small transformer");
		level.ModelList[9] = createModel("vehicle_80s_sedan1_silv_destructible_mp", "Silver car");
		level.ModelList[10] = createModel("vehicle_80s_sedan1_green_destructible_mp", "Green car");
		level.ModelList[11] = createModel("vehicle_80s_sedan1_red_destructible_mp", "Red car");
		level.ModelList[12] = createModel("vehicle_80s_sedan1_yel_destructible_mp", "Yellow car");
		level.ModelList[13] = createModel("vehicle_uaz_hardtop_destructible_mp", "Military vehicle");
		level.ModelList[14] = createModel("com_propane_tank02", "Big Propane tank");
}

mp_fuel2()
{
		level.ModelList = [];
		level.MaxModels = 13;
		//Modelname
		level.ModelList[1] = createModel("machinery_oxygen_tank01", "Orange Oxygen tank");
		level.ModelList[2] = createModel("machinery_oxygen_tank02", "Green Oxygen tank");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "File cabinet");
		level.ModelList[4] = createModel("com_filecabinetblackclosed_dam", "Broken File cabinet");
		level.ModelList[5] = createModel("com_trashbin02", "Trashbin");
		level.ModelList[6] = createModel("machinery_generator", "Generator");
		level.ModelList[7] = createModel("foliage_tree_palm_med_2", "Palm");
		level.ModelList[8] = createModel("foliage_tree_palm_bushy_2", "Bushy palm");
		level.ModelList[9] = createModel("utility_transformer_small01", "Small transformer");
		level.ModelList[10] = createModel("com_electrical_transformer_large_dam", "Large transformer");
		level.ModelList[11] = createModel("com_propane_tank02_small", "Small Propane tank");
		level.ModelList[12] = createModel("vehicle_uaz_hardtop_destructible_mp", "Military vehicle");
		level.ModelList[13] = createModel("vehicle_bm21_mobile_bed_destructible", "Military truck");
}

mp_strike()
{
		level.ModelList = [];
		level.MaxModels = 17;
		// Modelname
		level.ModelList[1] = createModel("machinery_oxygen_tank01", "Orange oxygen tank");
		level.ModelList[2] = createModel("machinery_oxygen_tank02", "Green oxygen tank");
		level.ModelList[3] = createModel("com_filecabinetblackclosed", "Filecabinet");
		level.ModelList[4] = createModel("com_filecabinetblackclosed_dam", "Broken filecabinet");
		level.ModelList[5] = createModel("machinery_generator", "Generator");
		level.ModelList[6] = createModel("foliage_tree_river_birch_xl_a_animated", "Tree");
		level.ModelList[7] = createModel("foliage_tree_palm_bushy_2", "Tall palm tree");
		level.ModelList[8] = createModel("usa_gas_station_trash_bin_01", "Trashbin");
		level.ModelList[9] = createModel("com_locker_double", "Locker");
		level.ModelList[10] = createModel("com_trashcan_metal_closed", "Metal trashcan");
		level.ModelList[11] = createModel("com_firehydrant", "Fire hydrant");
		level.ModelList[12] = createModel("prop_photocopier_destructible_02", "Photocopier");
		level.ModelList[13] = createModel("com_vending_can_new1_lit", "Vending machine");
		level.ModelList[14] = createModel("com_vending_can_new2_lit", "Vending machine 2");
		level.ModelList[15] = createModel("vehicle_80s_sedan1_green_destructible_mp", "Green car");
		level.ModelList[16] = createModel("vehicle_80s_sedan1_brn_destructible_mp", "Brown car");
		level.ModelList[17] = createModel("vehicle_hummer_destructible", "Hummer");
}

createModel(modelname, RName)
{
	model = spawnstruct();
	model.name = modelname;
	model.RName = RName;
	return Model;
}
