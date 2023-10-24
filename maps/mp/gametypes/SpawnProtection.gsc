#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

// add self thread DoSpawnProtection(); to your scripts

DoSpawnProtection() {
self.spawnprotectiontimer = 0; // DO NOT TOUCH
self notify("DO_SP_TIMER");
self.sptext destroy();
self.sptextvalue destroy();
self.before = "";self.after = "";// DO NOT CHANGE
self.before = self getorigin();
self iPrintlnBold("^1Spawn Protection Active.");
self.spawnprotection = 1;// DO NOT CHANGE
//self thread DoSPWarning();
self thread DoSPTimer();
}


DoSPMoveMent()
{
        self endon("disconnect");
	for(;;)
	{
	wait .15;
	if (self.spawnprotection == 0) { break; }
			self.after = self getorigin();
			if ((distance(self.before, self.after) > 500))
			{
			self iPrintlnBold("^2Spawn Protection Deactivated");
			self.spawnprotection = 0;
			self.sptext destroy();
			self.sptextvalue destroy();
			self notify("DO_SP_WARNING");
			self notify("DO_SP_TIMER");
			break;
			} else { continue; }	
			
	}
	
}

DoSPWarning() {
self endon("disconnect");
self endon("death");
self endon("DO_SP_WARNING");

while(1)
	{
		foreach(player in level.players)
		{
		if (distance(self.origin, player.origin) <= 75 && self.spawnprotection == "1" && player != self) { 
		if (self.team == "axis" && player.team == "axis") { player iPrintlnBold("^2" + self.name + " Has Spawn Protection Activated"); } 
		if (self.team == "allies" && player.team == "allies") { player iPrintlnBold("^2" + self.name + " Has Spawn Protection Activated"); } 
		if (self.team == "allies" && player.team == "axis") { player iPrintlnBold("^1" + self.name + " Has Spawn Protection Activated"); } 
		if (self.team == "axis" && player.team == "allies") { player iPrintlnBold("^1" + self.name + " Has Spawn Protection Activated"); } 
		}
		wait .25;
		}
		wait 5;
	}
}

DoSPTimer() {
self endon("disconnect");
self endon("death");
self endon("DO_SP_TIMER");
self.spawnprotectiontimer = 60;// how long befor spawn protection expires? in seconds.
self.doMovementcheck = 30;// how long befor we check for movement? so we can turn it off.
self thread DrawSpawnProtectionText();
wait .50;
while(self.spawnprotectiontimer > 0)
		{
	
			self.sptextvalue setValue(self.spawnprotectiontimer);
			if (self.spawnprotectiontimer >= self.doMovementcheck) { self thread DoSPMoveMent(); }
			wait 1;
			self.spawnprotectiontimer--;
		}
self iPrintlnBold("^2Spawn Protection Deactivated");
self.spawnprotection = 0;
self.sptext destroy();
self.sptextvalue destroy();
self endon("DO_SP_TIMER");
}


DrawSpawnProtectionText() {
	self.sptext destroy();
	self.sptext = NewClientHudElem( self );
	self.sptext.alignX = "center";
	self.sptext.alignY = "middle";
	self.sptext.horzAlign = "center";
	self.sptext.vertAlign = "middle";
	self.sptext.x = 0;
	self.sptext.y = 30;
	self.sptext.foreground = true;
	self.sptext.fontScale = .8;
	self.sptext.font = "hudbig";
	self.sptext.alpha = 1;
	self.sptext.color = ( 1.0, 0, 0 );
	self.sptext setText("Spawn Protection Expires In: ");
	
	self.sptextvalue destroy();
	self.sptextvalue = NewClientHudElem( self );
	self.sptextvalue.alignX = "center";
	self.sptextvalue.alignY = "middle";
	self.sptextvalue.horzAlign = "center";
	self.sptextvalue.vertAlign = "middle";
	self.sptextvalue.x = 150;
	self.sptextvalue.y = 30;
	self.sptextvalue.foreground = true;
	self.sptextvalue.fontScale = .8;
	self.sptextvalue.font = "hudbig";
	self.sptextvalue.color = ( 1.0, 1.0, 1.0 );
}
