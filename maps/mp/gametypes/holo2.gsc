
dmc2DoStart() {
	level thread dmc2Setup();
	level thread dmc2Logic();
}

dmc2Setup() { //TODO: Optimize this mess
	dmc2LoadConfig();		

	level.aHolo2Position = [];
	level.aHolo2Text = [];
	level thread dmc2InitMapPositions();		
	level thread dmc2LoadFonts();			
}

dmc2Logic() {
	wait 0.05;
		level thread dmc2DrawHolo2graphicText();

		level thread dmc2LevelWatchGameEnded();
}


dmc2LoadConfig() {

	level.stringHolo2 = "Hide and Seek"; 
}

dmc2DrawHolo2graphicText() {
	if(level.aHolo2Position.size && level.stringHolo2) {
		angles = level.aHolo2Position["angles"] + (0,180,0);
		origin = level.aHolo2Position["origin"];

		vecx = AnglesToRight(angles);
		vecy = AnglesToUp(angles);
		vecz = AnglesToForward(angles);

		str = level.stringHolo2;

		len = 0;
		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			len += level.aFontSize[letter] + 0.8;
		}
		m = 4.5;
		x = (len / 2) * -1 * m;

		for(i=0;i<str.size;i++) {
			letter = GetSubStr(str,i,i+1);
			arr = level.aFont[letter];
			foreach(pos in arr) {
				ox = dmc2VectorMultiply(vecx, pos[0] * m + x);
				oy = dmc2VectorMultiply(vecy, (16 - pos[1]) * m);
				oz = dmc2VectorMultiply(vecz, 1);
				position = origin + ox + oy + oz;
				fx = SpawnFX(loadfx("misc/aircraft_light_wingtip_red"), position);
				TriggerFX(fx, 1);
				level.aHolo2Text[level.aHolo2Text.size] = fx;
				wait 0.1;
				level.aHolo2Text delete();
			}
			x += (level.aFontSize[letter] + 0.8) * m;
		}
	}
}

dmc2VectorMultiply( vec, dif )
{
	vec = ( vec[ 0 ] * dif, vec[ 1 ] * dif, vec[ 2 ] * dif );
	return vec;
}

dmc2RemoveHolo2graphicText() {
	foreach(fx in level.aHolo2Text) {
		fx delete();
	}
}

dmc2LevelWatchGameEnded() {
	self waittill("game_ended");
	dmc2RemoveHolo2graphicText();
}

dmc2LoadFonts() {
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

dmc2InitMapPositions() {
	//Supported: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//Unsupported: -
	//Drops: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise mp_nightshift mp_underpass mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown
	//No drops: -
	//Holo2: mp_afghan mp_rust mp_terminal mp_favela mp_subbase mp_boneyard mp_highrise^ mp_nightshift mp_underpass
	//No Holo2: mp_quarry mp_complex mp_estate mp_trailerpark mp_vacant mp_invasion mp_brecourt mp_compact mp_checkpoint mp_storm mp_derail mp_rundown mp_fuel2 mp_crash mp_strike mp_abandon mp_overgrown

	switch(getDvar("mapname")) {
		case "mp_afghan":
			//Holo2
			level.aHolo2Position["origin"] = (-219.201, 1557.74, 398.21);
			level.aHolo2Position["angles"] = (0, 180, 0);
		break;
		case "mp_rust":
			//Holo2
			level.aHolo2Position["origin"] = (-489.397, 746.178, 128.086);
			level.aHolo2Position["angles"] = (0, 0, 0);
		break;
		case "mp_terminal":
			//Holo2
			level.aHolo2Position["origin"] = (1075.32, 4759.88, 244.291);
			level.aHolo2Position["angles"] = (0, -90, 0);
		break;
		case "mp_favela":
			//Holo2
			level.aHolo2Position["origin"] = (-1852.2, -415.991, 543.378);
			level.aHolo2Position["angles"] = (0, 30.5098, 0);
		break;
		case "mp_subbase":
			//Holo2
			level.aHolo2Position["origin"] = (263.047, -2168.13, 99.118);
			level.aHolo2Position["angles"] = (0, -90, 0);
		break;
		case "mp_boneyard":
			//Holo2
			level.aHolo2Position["origin"] = (459.3, -229.868, -24.2875);
			level.aHolo2Position["angles"] = (0, 90, 0);
		break;
		case "mp_highrise":
			//Holo2
			//level.aHolo2Position["origin"] = (-69.0602, 6371.8, 3147.87);
			//level.aHolo2Position["angles"] = (0, -180, 0);
			//Not enough effects to display text
		break;
		case "mp_nightshift":
			//Holo2
			level.aHolo2Position["origin"] = (196.48, -1445.83, 250.906);
			level.aHolo2Position["angles"] = (0, 0, 0);
		break;
		case "mp_underpass":
			//Holo2
			level.aHolo2Position["origin"] = (1705.06, 377.937, 797.003);
			level.aHolo2Position["angles"] = (0, 117.966, 0);
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