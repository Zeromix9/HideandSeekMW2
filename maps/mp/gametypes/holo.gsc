// website: RepZ [www.repz.eu]

dmcDoStart() {
	level thread dmcSetup();
	level thread dmcLogic();
}

dmcSetup() { //TODO: Optimize this mess
	dmcLoadConfig();		// 

	level.aHoloPosition = [];
	level.aHoloText = [];
	level thread dmcInitMapPositions();		// 
	level thread dmcLoadFonts();			// 
}

dmcLogic() {
	wait 0.05;
		level thread dmcDrawHolographicText();

		level thread dmcLevelWatchGameEnded();
}


dmcLoadConfig() {

	level.stringHolo = "Welcome to"; //
}

dmcDrawHolographicText() {
	if(level.aHoloPosition.size && level.stringHolo) {
		angles = level.aHoloPosition["angles"] + (0,180,0);
		origin = level.aHoloPosition["origin"];

		vecx = AnglesToRight(angles);
		vecy = AnglesToUp(angles);
		vecz = AnglesToForward(angles);

		str = level.stringHolo;

		len = 0;
		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			len += level.aFontSize[letter] + 2;
		}
		m = 4.5;
		x = (len / 2) * -1 * m;

		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			arr = level.aFont[letter];
			foreach(pos in arr) {
				ox = dmcVectorMultiply(vecx, pos[0] * m + x);
				oy = dmcVectorMultiply(vecy, (16 - pos[1]) * m);
				oz = dmcVectorMultiply(vecz, 1);
				position = origin + ox + oy + oz;
				fx = SpawnFX(loadfx("misc/aircraft_light_wingtip_green"), position);
				TriggerFX(fx, 1);
				level.aHoloText[level.aHoloText.size] = fx;

			}
			x += (level.aFontSize[letter] + 2) * m;
		}
	}
}

dmcVectorMultiply( vec, dif )
{
	vec = ( vec[ 0 ] * dif, vec[ 1 ] * dif, vec[ 2 ] * dif );
	return vec;
}

dmcRemoveHolographicText() {
	foreach(fx in level.aHoloText) {
		fx delete();
	}
}

dmcLevelWatchGameEnded() {
	self waittill("match_start_timer_beginning");
	wait 10;
	dmcRemoveHolographicText();
}

dmcLoadFonts() {
	level.aFont = [];
	level.aFontSize = [];

	font_letters = "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!#^&*()-=+[]{}\\\/,.'\"?$:;_";
	font = [];
	font[font.size] = "....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x...x....x....x....x....x...x...x....x....x...x...x....x...x.....x....x.....x....x.....x....x...x...x....x...x.....x...x...x...x..x...x...x....x...x...x...x...x...x...x.x.....x...x.....x...x..x..x...x...x...x..x..x...x...x...x...x..x.x#x#.#x...x...x.x..x...x";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. #.. ..# .. . # #.# ... .#. . .. ... ";
	font[font.size] = ".##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### ... .##. ###. .##. ###. ### ### .##. #..# ### ### #..# #.. .#.#. #..# .###. ###. .###. ###. ### ### #..# #.# #.#.# #.# #.# ### .# ##. ### ..#. ### ### ### ### ### ### # .#.#. .#. .##.. .#. #. .# ... ... ... #. .# .#. .#. #.. ..# .. . . ... ### ### . .. ... ";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ... #..# #..# #..# #..# #.. #.. #... #..# .#. .#. #.#. #.. #.#.# ##.# #...# #..# #...# #..# #.. .#. #..# #.# #.#.# #.# #.# ..# ## ..# ..# .##. #.. #.. ..# #.# #.# #.# # ##### #.# #..#. ### #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ..# #.. # .# ... ";
	font[font.size] = "#### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. ... #### ###. #... #..# ##. ##. #.## #### .#. .#. ###. #.. #.#.# #.## #...# #..# #.#.# #..# ### .#. #..# #.# #.#.# .#. .#. .#. .# .#. ### #.#. ##. ### ..# ### ### #.# # .#.#. ... .##.. .#. #. .# ### ... ### #. .# #.. ..# .#. .#. .. . . ... .## ### . .. ... ";
	font[font.size] = "#..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. ... #..# #..# #..# #..# #.. #.. #..# #..# .#. .#. #.#. #.. #.#.# #..# #...# ###. #..#. ###. ..# .#. #..# #.# #.#.# #.# .#. #.. .# #.. ..# #### ..# #.# .#. #.# ..# #.# . ##### ... #..#. #.# #. .# ... ### .#. #. .# .#. .#. .#. .#. .. . . ... ... ..# # .# ... ";
	font[font.size] = "#..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### ... #..# ###. .##. ###. ### #.. .##. #..# ### #.. #..# ### #.#.# #..# .###. #... .##.# #..# ### .#. .### .#. .#.#. #.# #.. ### .# ### ### ..#. ##. ### .#. ### ### ### # .#.#. ... .##.# ... #. .# ... ... ... #. .# .#. .#. ..# #.. .# # . ... .#. ### . #. ### ";
	font[font.size] = ".... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... ... .... .... .... .... ... ... .... .... ... ... .... ... ..... .... ..... .... ..... .... ... ... .... ... ..... ... ... ... .. ... ... .... ... ... ... ... ... ... . ..... ... ..... ... .# #. ... ... ... ## ## ..# #.. ..# #.. #. . . ... ... .#. . .. ... ";

	pos1 = 0;
	index = 0;
	for(i=0;i<font[0].size;i++) {
		if(GetSubStr(font[0], i, i+1) == "x") {
			pos2 = i;
			letter = GetSubStr(font_letters, index, index+1);
			level.aFont[letter] = [];
			level.aFontSize[letter] = pos2 - pos1;
			for(x=pos1;x<pos2;x++) {
				for(y=0;y<font.size;y++) {
					if(GetSubStr(font[y], x, x+1) == "#") level.aFont[letter][level.aFont[letter].size] = (x - pos1, y, 0);
				}
			}
			index++;
			pos1 = pos2+1;
		}
	}
}

dmcInitMapPositions() {
	//Supported: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//Unsupported: -
	//Drops: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//No drops: -
	//Holo: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise^ mp_nightshift mp_underpass
	//No holo: mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown

	switch(getDvar("mapname")) {
		case "mp_afghan":
			//Holo
			level.aHoloPosition["origin"] = (-219.201, 1557.74, 438.21);
			level.aHoloPosition["angles"] = (0, 180, 0);
		break;
		case "mp_rust":
			//Holo
			level.aHoloPosition["origin"] = (-489.397, 746.178, 168.086);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
		case "mp_terminal":
			//Holo
			level.aHoloPosition["origin"] = (1075.32, 4759.88, 284.291);
			level.aHoloPosition["angles"] = (0, -90, 0);
		break;
		case "mp_favela":
			//Holo
			level.aHoloPosition["origin"] = (-1852.2, -415.991, 583.378);
			level.aHoloPosition["angles"] = (0, 30.5098, 0);
		break;
		case "mp_subbase":
			//Holo
			level.aHoloPosition["origin"] = (263.047, -2168.13, 139.118);
			level.aHoloPosition["angles"] = (0, -90, 0);
		break;
		case "mp_boneyard":
			//Holo
			level.aHoloPosition["origin"] = (459.3, -239.868, 28.2875);
			level.aHoloPosition["angles"] = (0, 90, 0);
		break;
		case "mp_highrise":
			//Holo
			//level.aHoloPosition["origin"] = (-69.0602, 6371.8, 3187.87);
			//level.aHoloPosition["angles"] = (0, -180, 0);
			//Not enough effects to display text
		break;
		case "mp_nightshift":
			//Holo
			level.aHoloPosition["origin"] = (196.48, -1445.83, 290.906);
			level.aHoloPosition["angles"] = (0, 0, 0);
		break;
		case "mp_underpass":
			//Holo
			level.aHoloPosition["origin"] = (1705.06, 377.937, 837.003);
			level.aHoloPosition["angles"] = (0, 117.966, 0);
		break;
		case "mp_quarry":
		break;
		case "mp_complex":
		break;
		case "mp_estate":
		break;
		case "mp_trailerpark":
		break;
		case "mp_vacant":
		break;
		case "mp_brecourt":
		break;
		case "mp_invasion":
		break;
		case "mp_compact":
		break;
		case "mp_checkpoint":
		break;
		case "mp_storm":
		break;
		case "mp_rundown":
		break;
		case "mp_derail":
		break;
		case "mp_fuel2":
		break;
		case "mp_crash":
		break;
		case "mp_strike":
		break;
		case "mp_overgrown":
		break;
		case "mp_abandon":
		break;
	}
}