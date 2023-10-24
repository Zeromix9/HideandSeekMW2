#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\SpawnProtection;

///////////////////////
///  Hide&Seek Mod  ///
//      by zxz      ///
// Edited by Zeromix //
// Tested by Henker //
///////////////////////

DoInit()
{
level.Timer  = 30;
level thread TimerStart();
level.TimerText = level createServerFontString("objective", 1.5);
level.TimerText setPoint("CENTER", "CENTER", 0, 10);
level deletePlacedEntity("misc_turret"); //Remove Turrets
level thread CountPlayersAlive();
if(!isDefined(level.HidersAlive))
		{
			level.HidersAlive = 0;
		}
		if(!isDefined(level.SeekersAlive))
		{
			level.SeekersAlive = 0;
		}

}


ModIni()
{
	
	self thread ModelDelete();
	self thread CheckInvisibility();
	self thread TeamCheck();
	self thread toggle3Person();
	self thread ShowInfo();
	self thread CreditText();
	self.InfoText = self createFontString("objective", 1.25);
	self.InfoText setPoint("CENTER", "TOP", 0, 10);
	self.InfoText SetText ("^1Press [{+actionslot 4}] to see Info | ^2Press [{+actionslot 3}] to change to 3rd Person");
		level.HostnameXYZ = self.name; //only level.Hostname will conflict with the server value sv_hostname and will display CoD4Host
		self thread changeTeamNames();
		setDvar("ui_gametype", "sd");
		self thread maps\mp\mods\_modellist::checkMap();
		self thread WeaponInit();
	
		self thread CheckTimelimit();
	self thread doDvars();
	self thread HNSHud();
self thread IconBars();
self thread ChangeHudText();
self thread RemoveHudDeath();

}

changeTeamNames()
{
	self endon("disconnect");
	h = "Hiders";
	s = "Seekers";
	for(;;)
	{
		self waittill("spawned_player");
		if(self.pers["team"]==game["defenders"])
		{
			if (self.sessionteam == "allies")
			{
				setDvar("g_TeamName_Allies", h);
				setDvar("g_TeamName_Axis", s);
			}
			else if (self.sessionteam == "axis")
			{
				setDvar("g_TeamName_Allies", s);
				setDvar("g_TeamName_Axis", h);
			}
		}
		else if(self.pers["team"]==game["attackers"])
		{
			if (self.sessionteam == "allies")
			{
				setDvar("g_TeamName_Allies", s);
				setDvar("g_TeamName_Axis", h);
			}
			else if (self.sessionteam == "axis")
			{
				setDvar("g_TeamName_Allies", h);
				setDvar("g_TeamName_Axis", s);
			}
		}
		wait 3;
	}
}

doDvars()
{
	self endon("disconnect");
	setDvar("scr_sd_winlimit", 4);
	setDvar("scr_sd_roundswitch", 1);
	setDvar("scr_game_killstreakdelay", 280);
	setDvar("scr_airdrop_ammo", 9999);
	setDvar("scr_airdrop_mega_ammo", 9999);
	setDvar("cg_drawcrosshair", 0);
	setDvar("aim_automelee_range", 92);
	self setClientDvar("party_hostname", "Hide&Seek _" + level.HostnameXYZ);
	self setClientDvar("cg_scoreboardItemHeight", 13);
	self setClientDvar("lowAmmoWarningNoAmmoColor2", 0, 0, 0, 0);
	self setClientDvar("lowAmmoWarningNoAmmoColor1", 0, 0, 0, 0);
	self setClientDvar("lowAmmoWarningNoReloadColor2", 0, 0, 0, 0);
	self setClientDvar("lowAmmoWarningNoReloadColor1", 0, 0, 0, 0);
	self setClientDvar("lowAmmoWarningColor2", 0, 0, 0, 0);
	self setClientDvar("lowAmmoWarningColor1", 0, 0, 0, 0);
	if(getDvar("sys_cpughz") > 3)
	{
		setDvar("sv_network_fps", 900);
	}
	else if(getDvar("sys_cpughz") > 2.5)
	{
		setDvar("sv_network_fps", 650);
	}
	else if(getDvar("sys_cpughz") > 2)
	{
		setDvar("sv_network_fps", 400);
	}
}

CheckTimelimit()
{
	for(;;)
	{
		self waittill("spawned_player");
		level.TimelimitChanged = 0;
		while(level.TimelimitChanged==0)
		{
			if(level.HidersAlive < ceil(level.AllHiders*2/3))
			{
				setDvar("scr_sd_timelimit", 4);
				level.TimelimitChanged = 1;
			}
			wait 6;
		}
		wait 1;
	}
}

TeamCheck()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		setDvar("scr_sd_timelimit", 4.0);
		level.TimelimitChanged = 0;
		self setClientDvar("cg_thirdperson", 0);
		if (self.pers["team"]==game["defenders"])
		{
			self thread HidersIni();
		
		}
		else if (self.pers["team"]==game["attackers"])
		{
			self thread SeekersIni();

		}
		wait 0.5;
	}
}

CountPlayersAlive() {

	for(;;)
	{
	level.SeekersAlive = 0;
	level.HidersAlive = 0;
		foreach(player in level.players) {
		if (player.pers["team"]==game["defenders"]) {
		if(isAlive(player))  { level.HidersAlive++; }
		level.AllHiders = level.HidersAlive;
		} else if (self.pers["team"]==game["attackers"]) {
		
		if(isAlive(player))  { level.SeekersAlive++; }
		}
		}
		wait 1;
	}
}



HidersIni()
{
	self endon("disconnect");
	self endon("unsupported");
	self.InfoText SetText ("^3Press [{+smoke}] to open Model Menu | ^1Press [{+actionslot 4}] to see Info | ^2Press [{+actionslot 3}] to change to 3rd Person");
	self _clearPerks();
	self takeAllWeapons();
	self maps\mp\perks\_perks::givePerk("specialty_quieter");
	self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
	self maps\mp\perks\_perks::givePerk("specialty_falldamage");
	self giveWeapon("deserteagle_tactical_mp", 0, false);
	self switchtoWeapon("deserteagle_tactical_mp");

	
	self thread InfoText();
	self thread RotatingModelSlow();
	self thread HiderWeaponCheck();
	self freezeControlsWrapper(false);
	self thread RotatingModelFast();
	self thread monitor();
	self thread changeRotation();
	wait 1;
	notifyHiders = spawnstruct();
	notifyHiders.titleText = "Hider";
	notifyHiders.notifyText = "Hide yourself from the Seekers!";
	notifyHiders.glowColor = (0.0, 0.0, 1.0);
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyHiders );
	while(level.Timer > 0)
	{
		setDvar("g_speed", 290);
		setDvar("player_sprintUnlimited", 1);
		wait 1;
	}
	setDvar("g_speed", 190);
	setDvar("player_sprintUnlimited", 0);
	self thread notifyRelease();
}

HiderWeaponCheck()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self setWeaponAmmoClip("deserteagle_tactical_mp", 0);
		self setWeaponAmmoStock("deserteagle_tactical_mp", 0);
		if(self getCurrentWeapon() != "deserteagle_tactical_mp")
		{
			self takeAllWeapons();
			self giveWeapon("deserteagle_tactical_mp", 0, false);
			self switchToWeapon("deserteagle_tactical_mp");
			self setWeaponAmmoClip("deserteagle_tactical_mp", 0);
			self setWeaponAmmoStock("deserteagle_tactical_mp", 0);
		}
		wait 0.75;
	}
}

SeekersIni()
{
	self endon("disconnect");
	self notifyOnPlayerCommand("weapnext", "weapnext");
	self.InfoText SetText ("^1Press [{+actionslot 4}] to see Info | ^2Press [{+actionslot 3}] to change to 3rd Person");
	self _clearPerks();
	self takeAllWeapons();
	self.maxhealth = 280;
	self.health = 280;
	self maps\mp\perks\_perks::givePerk("specialty_lightweight");
	self maps\mp\perks\_perks::givePerk("specialty_coldblooded");
	self maps\mp\perks\_perks::givePerk("specialty_marathon");
	self maps\mp\perks\_perks::givePerk("specialty_falldamage");
	self maps\mp\perks\_perks::givePerk("specialty_fastreload");
	self giveWeapon("deserteagle_tactical_mp", 0, false);
	self GiveMaxAmmo("deserteagle_tactical_mp");
	self thread WeaponInit();
	wait 1;
	notifySeekers = spawnstruct();
	notifySeekers.titleText = "Seeker";
	notifySeekers.notifyText = "Search and kill the hiders!";
	notifySeekers.glowColor = (0.0, 0.0, 1.0);
	self thread maps\mp\gametypes\_hud_message::notifyMessage( notifySeekers );
	while(level.Timer > 0)
	{
		self freezeControls(true);
		self VisionSetNakedForPlayer("blacktest", 0);
		self hide();
		wait 1;
	}
	self thread notifyRelease();
	self freezeControls(false);
	self VisionSetNakedForPlayer(getDvar("mapname"), 2.5);
	self show();
	wait 1;
	self switchToWeapon(self.Primary + "_reflex_mp");
	self.InfoText SetText ("^3Press [{+actionslot 1}] to attach Silencer | ^1Press [{+actionslot 4}] to see Info | ^2Press [{+actionslot 3}] to change to 3rd Person");
	self thread Silencer();
}

Silencer()
{
	self endon("disconnect");
	self endon("death");
	self notifyOnPlayerCommand("N", "+actionslot 1");
	self.Silenced = 0;
	for(;;)
	{
		self waittill("N");
		if(self getCurrentWeapon()=="deserteagle_tactical_mp")
		{
			self iPrintLnBold("You can't attach silencer to Desert Eagle!");
		}
		else
		{
			if(self.Silenced==0)
			{
				curweap = self getCurrentWeapon();
				beforeAmmo = self getWeaponAmmoClip(curweap);
				beforeStock = self getWeaponAmmoStock(curweap);
				self TakeWeapon(self.Primary + "_reflex_mp");
				self giveWeapon(self.Primary + "_reflex_silencer_mp", randomInt(9), false);
				self switchToWeapon(self.Primary + "_reflex_silencer_mp");
				self setWeaponAmmoClip(self.Primary + "_reflex_silencer_mp", beforeAmmo);
				self setWeaponAmmoStock(self.Primary + "_reflex_silencer_mp", beforeStock);
				self.Silenced = 1;
				self.InfoText SetText ("Press [{+actionslot 1}] to detach Silencer | Press [{+actionslot 4}] to see Info | Press [{+actionslot 3}] to change to 3rd Person");
			}
			else if(self.Silenced==1)
			{
				curweap = self getCurrentWeapon();
				beforeAmmo = self getWeaponAmmoClip(curweap);
				beforeStock = self getWeaponAmmoStock(curweap);
				self TakeWeapon(self.Primary + "_reflex_silencer_mp");
				self giveWeapon(self.Primary + "_reflex_mp", randomInt(9), false);
				self switchToWeapon(self.Primary + "_reflex_mp");
				self setWeaponAmmoClip(self.Primary + "_reflex_mp", beforeAmmo);
				self setWeaponAmmoStock(self.Primary + "_reflex_mp", beforeStock);
				self.Silenced = 0;
				self.InfoText SetText ("^3Press [{+actionslot 1}] to attach Silencer | ^1Press [{+actionslot 4}] to see Info | ^2Press [{+actionslot 3}] to change to 3rd Person");
			}
		}
	}
}

notifyRelease()
{
	self endon("death");
	self endon("disconnect");
	notifyData = spawnstruct();
	notifyData.titleText = "Seekers released";
	notifyData.notifyText = "Let the hunt begin!";
	notifyData.glowColor = (0.0, 0.0, 1.0);
	notifyData.sound = "mp_defeat";
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}





ShowInfo()
{
	self endon("disconnect");
	self notifyOnPlayerCommand( "4", "+actionslot 4" );
	for(;;)
	{
		self waittill("4");
		if (self.pers["team"]==game["defenders"])
		{
			self iPrintlnBold("^4You are a Hider");
			wait 2;
			self iPrintlnBold("^4Press [{+smoke}] to change Model");
			wait 2;
			self iPrintlnBold("^4Hold [{+frag}] to spin Model");
			wait 2;
			self iPrintlnBold("^4You can kill the Seeker, but you will need 3 hits!");
		}
		else
		{
			self iPrintlnBold("^4You are a Seeker");
			wait 2;
			self iPrintlnBold("^4Search and kill the Hiders");
			wait 2;
			self iPrintlnBold("^4The Hiders have the form of a model");
		}
		wait 1;
	}
}

WeaponInit()
{
	switch(RandomInt(8))
	{
	
		case 0:
			self giveWeapon("m16_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("m16_reflex_mp");
			self.Primary = "m16";
			break;
		case 1:
			self giveWeapon("m4_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("m4_reflex_mp");
			self.Primary = "m4";
			break;
		case 2:
			self giveWeapon("ump45_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("ump45_reflex_mp");
			self.Primary = "ump45";
			break;
		case 3:
			self giveWeapon("fal_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("fal_reflex_mp");
			self.Primary = "fal";
			break;
		case 4:
			self giveWeapon("scar_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("scar_reflex_mp");
			self.Primary = "scar";
			break;
		case 5:
			self giveWeapon("ak47_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("ak47_reflex_mp");
			self.Primary = "ak47";
			break;
		case 6:
			self giveWeapon("p90_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("p90_reflex_mp");
			self.Primary = "p90";
			break;
		case 7:
			self giveWeapon("famas_reflex_mp", randomInt(9), false);
			self giveMaxAmmo("famas_reflex_mp");
			self.Primary = "famas";
			break;
	}
}

TimerStart() {


	level.Timer = 30;
	setDvar("scr_sd_timelimit", 3.30);
		while(level.Timer > 0)
		{
			level.TimerText setText("");
			level.TimerText setText("^2Seekers released in: " + level.Timer);
			
			wait 1;
			level.Timer--;
		}
		level.TimerText setText("");
}

ModelDelete()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		self.customModel Delete();
		wait 0.5;
	}
}

toggle3Person()
{
	self endon("disconnect");
	self notifyOnPlayerCommand("3", "+actionslot 3");
	i = getDvar("cg_thirdperson");
	for(;;)
	{
		self waittill("3");
		i++;
		if(i > 1)
		{
			i = 0;
		}
		self setClientDvar("cg_thirdperson", i);
		wait 0.5;
	}
}

CheckInvisibility()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self show();
		wait 1;
	}
}

changeRotation()
{
	self endon("disconnect");
	self endon("death");
	self notifyOnPlayerCommand("E", "+melee");
	self.rotationside = 1;
	for(;;)
	{
		self waittill("E");
		if (self.rotationside==1)
		{
			self.rotationside = 2;
		}
		else
		{
			self.rotationside = 1;
		}
		wait 0.5;
	}
}	

RotatingModelSlow()
{
	self endon("disconnect");
	self endon("death");
	self notifyOnPlayerCommand("N", "+actionslot 1");
	for(;;)
	{
		self waittill("N");
		self thread doSpinSlow();
		wait 0.5;
	}
}

doSpinSlow() //checked by selectcheck()
{
	self notifyOnPlayerCommand("-N", "-actionslot 1");
	self endon("-N");
	for(;;)
	{
		if (self.rotationside==1)
		{
			self.customModel RotateYaw(2.5,0.01);
			wait 0.1;
		}
		if (self.rotationside==2)
		{
			self.customModel RotateYaw(-2.5,0.01);
			wait 0.1;
		}
	}
}

CreditText()
{
	self endon("disconnect");
	self notifyOnPlayerCommand("showScore", "+scores");
	self.CreditText1 = self createFontString("objective", 1.75);
	self.CreditText1 setPoint("CENTER", "CENTER", 0, 130);
	self.CreditText1.glowColor = (0.0, 0.0, 1.0);
	self.CreditText1.glowAlpha = 1;
	self.CreditText1.alpha = 1;
	self.CreditText2 = self createFontString("objective", 1.25);
	self.CreditText2 setPoint("CENTER", "CENTER", 0, 147);
	self.CreditText3 = self createFontString("objective", 1.25);
	self.CreditText3 setPoint("CENTER", "CENTER", 0, 160);
	for(;;)
	{
		self waittill("showScore");
		self thread ShowCredits();
		wait 2;
	}
}

ShowCredits()
{
	self notifyOnPlayerCommand("stopScore", "-scores");
	self.CreditText1 setText("Mod created by zxz");
	self.CreditText2 setText("Mod edited by Zeromix");
	self.CreditText3 setText("Tested by Henker");
	for(;;)
	{
		self waittill("stopScore");
		self.CreditText1 setText("");
		self.CreditText2 setText("");
		self.CreditText3 setText("");
		wait 2;
	}
}



InfoText()
{
		  self endon("disconnect");
	self endon("death");
		displayText = self createFontString( "objective", 1.1 );
        displayText setPoint( "CENTER", "BOTTOM", 0, -10);
		displayText.glowColor = (1.0, 0.0, 0.0);
		displayText.glowAlpha = 1;
		displayText.alpha = 1;
		displayText setText("^3Press [{+actionslot 2}] to switch Model. Press [{+actionslot 1}] to rotate Model slowly, [{+frag}] to rotate fast.");
        i = 0;
        for( ;; )
        {
                if(i == -280) {
                        i = 280;
                }
				 displayText setPoint( "CENTER", "BOTTOM", i, -10);
                wait .001;
                i--;
        }
}


RotatingModelFast()
{
	self endon("disconnect");
	self endon("death");
	self notifyOnPlayerCommand( "startSpinFast", "+frag" );
	for(;;)
	{
		self waittill( "startSpinFast" );
		self thread doSpinFast();
		wait 0.5;
	}
}

doSpinFast()
{
	self notifyOnPlayerCommand("stopSpinFast", "-frag");
	self endon("stopSpinFast");
	for(;;)
	{
		if (self.rotationside==1)
		{
			self.customModel RotateYaw(10,0.01);
			wait 0.1;
		}
		if (self.rotationside==2)
		{
			self.customModel RotateYaw(-10,0.01);
			wait 0.1;
		}
	}
}

monitor2()
{
	self endon("disconnect");
	self endon("unsupported");
	self endon("death");
	{
		if(level.notSupported != 1)
		{
			self thread wait5();
			self thread ModelMenuIni();
			self setClientDvar("cg_thirdperson", 1);
			self setClientDvar("cg_thirdPersonRange", 160);
			self.customModel = spawn( "script_model", self.origin );
			wait 0.5;
			self.changeModel = 1;
			self hide();
			for(;;)
			{
				self.customModel MoveTo( self.origin, 0.075);
				wait 0.05;
			}
		}
	}
}

monitor()
{
	self endon("disconnect");
	self endon("death");
	{
		self thread monitor2();
		self thread changeModel();
	}
}

wait5()
{
        self endon ("disconnect");
        self endon ("death");
        self notifyOnPlayerCommand("5", "+actionslot 2");
	for(;;)
	{
        	self waittill("5");
        	self.changeModel = 1;
		wait 0.25;
	}
}

changeModel()
{
	self endon("disconnect");
	self endon("death");
	self.changeModel = 0;
	self.curModel = 1;
	for(;;)
	{
		if (self.changeModel==1)
		{
			self.customModel setModel(level.ModelList[self.curModel].name);
			self.changeModel = 0;
			self.curModel++;
		}
		if (self.curModel > level.MaxModels)
		{
			self.curModel = 1;
		}
		wait 0.25;
	}
		

}

ModelMenuIni()
{
	self endon("disconnect");
	self endon("death");
	self.DisplayisOpen = 0;
	self thread CreatethefuckingMenu();
	self thread DisplaythefuckingMenu();
	self thread RemovethefuckingMenu();
	self thread OpenthefuckingMenu();
	self notifyOnPlayerCommand("Q", "+smoke");
	self notifyOnPlayerCommand("Space", "+gostand");
	self notifyOnPlayerCommand("Reload", "+reload");
	self notifyOnPlayerCommand("Sprint", "+breath_sprint");
	self.selected = 1;
}

CreatethefuckingMenu()
{
	self endon("disconnect");
	self endon("death");
	self.displayMenuTitel = self createFontString("objective", 1.6);
	self.displayMenuTitel setPoint("TOPCENTER", "TOPCENTER", 0, 45);
	for(i=1;i < level.MaxModels + 1;i++)
	{
		self.displayModelName[i] = self createFontString( "objective", 1.5 );
		self.displayModelName[i] setPoint( "TOPCENTER", "TOPCENTER", -35, 70 + 17*i);
	}
}

DisplaythefuckingMenu()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		while(self.DisplayisOpen==1)
		{
			self.displayMenuTitel setText("Press^3 [{+reload}] ^7to go up,^3 [{+breath_sprint}] ^7to go down and^3 [{+activate}] ^7to select model");
			for(i=1;i<level.MaxModels + 1;i++)
			{
				if(i==self.selected)
				{
				self.displayModelName[i] setText("^3" + level.ModelList[i].RName);
				}
				else
				{
				self.displayModelName[i] setText(level.ModelList[i].RName);
				}
			}
			wait 0.1;
		}
		wait 0.1;
	}
}

RemovethefuckingMenu()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		while(self.DisplayisOpen==0)
		{
			self.displayMenuTitel setText("");
			for(i=1;i<level.MaxModels + 1;i++)
			{
				self.displayModelName[i] setText("");
			}	
			wait 0.1;
		}
		wait 0.1;
	}
}

OpenthefuckingMenu()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("Q");
		if(self.DisplayisOpen==0)
		{
			self.DisplayisOpen = 1;
			self thread SelectCheck();
			self thread monitorReload();
			self thread monitorSprint();
		}
		else if(self.DisplayisOpen==1)
		{
			self.DisplayisOpen = 0;
			self notify("closeMenu");
		}
	}
}

SelectCheck()
{
	self endon("disconnect");
	self endon("death");
	self notifyOnPlayerCommand("+active", "+activate");
	for(;;)
	{
		self waittill("+active");
		if(self.DisplayisOpen==1)
		{
			self.customModel setModel(level.ModelList[self.selected].name);
			self.DisplayisOpen = 0;
			self notify("closeMenu");
		}
		wait 1;
	}
}

monitorReload()
{
	self endon("disconnect");
	self endon("death");
	self endon("closeMenu");
	for(;;)
	{
		self waittill("Reload");
		self.selected--;
		if(self.selected < 1)
		{
			self.selected = level.MaxModels;
		}
	}
}

monitorSprint()
{
	self endon("death");
	self endon("disconnect");
	self endon("closeMenu");
	for(;;)
	{
		self waittill("Sprint");
		self.selected++;
		if(self.selected > level.MaxModels)
		{
			self.selected = 1;
		}
	}
}


IconBars()
{
	self endon("disconnect");
	self.bar1 = self createBar((0, 0, 0), 120, 14);
	self.bar1 setShader("white", 120, 14);
	self.bar1.alignX = "LEFT";
	self.bar1.x = 20;
	self.bar1.y = 335;
	self.bar1.alpha = 0.275;
	self.bar1.HideWhenInMenu = true;
	self.bar1.foreground = false;
	self.bar2 = self createBar((0, 0, 0), 120, 14);
	self.bar2 setShader("white", 120, 14);
	self.bar2.alignX = "LEFT";
	self.bar2.x = 20;
	self.bar2.y = 355;
	self.bar2.alpha = 0.275;
	self.bar2.hideWhenInMenu = true;
	self.bar2.foreground = false;
	// self.bar3 = self createBar((0, 0, 0), 120, 14);
	// self.bar3 setShader("white", 120, 14);
	// self.bar3.alignX = "LEFT";
	// self.bar3.horzAlign = "RIGHT";
	// self.bar3.vertAlign = "MIDDLE";
	// self.bar3.x = -100;
	// self.bar3.y = 183;
	// self.bar3.alpha = 0.275;
	// self.bar3.HideWhenInMenu = true;
	// self.bar3.foreground = false;
	// self.bar4 = self createBar((0, 0, 0), 120, 14);
	// self.bar4 setShader("white", 120, 14);
	// self.bar4.horzAlign = "RIGHT";
	// self.bar4.vertAlign = "MIDDLE";
	// self.bar4.x = -100;
	// self.bar4.y = 200;
	// self.bar4.alignX = "LEFT";
	// self.bar4.alpha = 0.275;
	// self.bar4.hideWhenInMenu = true;
	// self.bar4.foreground = false;
}


RemoveHudDeath()
{
	self endon("disconnected");
	for(;;)
	{
		self waittill("death");
		if(isDefined(self.TeamIconHider))
		{
			self.TeamIconHider destroyElem();
		}
		else if(isDefined(self.TeamIconSeeker))
		{
			self.TeamIconSeeker destroyElem();
		}
		self.bar1 destroyElem();
		self.bar1Text destroyElem();
		self.bar2 destroyElem();
		self.bar2Text destroyElem();
		self.bar3 destroyElem();
		self.bar4 destroyElem();
		self.Gametype destroyElem();
		self.GlobalIcon destroyElem();
		self.RoundsWon destroyElem();
		self.ShowTime destroyElem();
		self notify("YesDisplayOpen");
		wait 1;
	}
}

HNSHud()
{
	self endon("disconnect");
	self.bar1Text = self createFontString("default", 1.35);
	self.bar1Text setPoint("LEFT", "LEFT", 30, 100);
	self.bar1Text setText("Hiders alive: " + level.HidersAlive);
	self.bar1Text.HideWhenInMenu = true;
	self.bar1Text.foreground = true;
	self.bar2Text = self createFontString("default", 1.35);
	self.bar2Text setPoint("LEFT", "LEFT", 30, 120);
	self.bar2Text setText("Seekers alive: " + level.SeekersAlive);
	self.bar2Text.HideWhenInMenu = true;
	self.bar2Text.foreground = true;
}

ChangeHudText()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		self.bar1Text setText("Hiders alive: " + level.HidersAlive);
		self.bar2Text setText("Seekers alive: " + level.SeekersAlive);
		wait 2;
	}
}



///////////////////////
///  Hide&Seek Mod  ///
//      by zxz      ///
// Edited by Zeromix //
// Tested by Henker //
///////////////////////
