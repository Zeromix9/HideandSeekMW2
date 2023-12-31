/***************************************************************************
Map Vote Menu Mod
Created by |UzD|GaZa
Site / Support: http://www.uzd-zombies.com/viewtopic.php?f=29&t=33
**************************************************************************/

init(){maps = undefined;gametypes = undefined;votetime = undefined;winnertime = undefined;	
	/******************README********************************
	Thanks for viewing my mod... all configurable
	options are listed below I've tried my best to explain
	which each setting is for and how to change them, any
	questions view the support thread at the website above.
	********************************************************/
	
	/********************************IW4X VOTE MODE***********************************************************************/
	standalone = true;
	/*
	IF STANDALONE IS TRUE MAP VOTE WILL RELY ON AN INTERMISSION TIMER (Usually fine on a stock iw4x dedicated server)
	
	STANDALONE FALSE WILL RELY ON A CALL FROM maps\gametypes\_gamelogic.gsc (Usually required on a mod or private match)
	-Find "processLobbyData();" in maps\gametypes\_gamelogic.gsc
	-Add "vote\_vote_menu::BeginVoteForMatch(); underneath above line
	
	Vote mod will now run at the end of the kill cam / game.
	*/
	/*********************************************************************************************************************/
	
	/******************************MAP SETTINGS (9 OR MORE)***************************************************************/
	maps = "Afghan,Derail,Estate,Favela,Highrise,Invasion,Karachi,Quarry,Rundown,Scrapyard,Skidrow,SubBase,Terminal,Underpass";
	
	/*
	-Must use 9 or more maps separated by a comma
	-Add custom maps by adding e.g 'mp_waw_castle'
	or
	Use the following stock iw4x maps below:
	
	Afghan				Bailout				Bloc				Bog
	Carnival			ChemicalPlant		Crash				CrashTropical
	Crossfire			DerailEstate 		EstateTropical		Favela
	FavelaTropical		FiringRange			ForgottenCity		Freighter
	Fuel				Highrise			Invasion			Karachi
	Killhouse			Nuketown			OilRig				Overgrown
	Quarry				Rundown				Rust				RustLong
	Salvage				Scrapyard			Shipment			ShipmentLong
	Skidrow				Storm				Strike				SubBase
	Terminal			TrailerPark			Underpass			Vacant
	Village				Wasteland			WetWork
	*/
	/******************************************************************************************************************/
	
	/****************************GAME TYPE SETTINGS*******************************************************************/
	gametypes = "";
	
	/*
	Add game types to the line above if you would to give the choice to vote on game types as well.
	
	MW2 Stock Game modes: "dm,war,sd,sab,dom,koth,ctf,dd,vip,gtnw,oneflag,arena"
	MW2:R Party Game modes: "gg,csgg,oitc,rgg,ultgg"
	*/
	/*****************************************************************************************************************/
	
	/******************************MAIN SETTINGS***********************************************************************/
	/*NOTE- IF YOU EXCEED THESE TIME LIMITATIONS BELOW THE VOTE MOD WILL BE DISABLED.*/
	//Total time of votetime + winnertime will take up the intermission time.
	//Any remaining seconds will be used to view scoreboard
	
	if(!getDvarInt( "party_host" ))
	{
		/**DEDICATED SERVER - MAX 30 SECONDS (votetime + winnertime)**/
		votetime = 20.0; //Time available to vote
		winnertime = 5.0; //Time the winning map is displayed for
	}
	else if(getDvarInt( "party_host" ))
	{
		/**PRIVATE MATCH - MAX 10 SECONDS (votetime + winnertime)**/
		votetime = 7.0; //Time available to vote
		winnertime = 3.0; //Time the winning map is displayed for
	}
	/***************************************************************************************************************/
	
	/******************************RUN VOTE MOD********************************************************************/
	vote\_vote_menu::init(standalone,maps,gametypes,votetime,winnertime);
	/***************************************************************************************************************/
}