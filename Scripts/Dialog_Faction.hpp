
class factionselect_dialog2
{
	idd = 999;
	movingenable = false;
	onLoad = "escKeyEH = (_this select 0) displayAddEventHandler [""KeyDown"", ""if (((_this select 1) == 1)) then {true} else {false};""];";

	class suprChooseFactionCombo: RscCombo
	{
		w = 16.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		wholeHeight = 12 * GUI_GRID_H;
		font="PuristaMedium";
		sizeEx = "0.030";
	};
	
	
class controls
{
	
	
	class longboi: RscText
	{
		idc = -1;
		text = ""; //titlebar
		x = -40 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 80 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0.2,0.6,0.99,1};
		sizeEx = 0.8 * GUI_GRID_H;
		shadow = 1;
		colorShadow[] = {0,0,0,0.5};
		font="PuristaMedium";
		align="right";
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = "CHOOSE FACTIONS"; //titlebar
		x = 2 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 10.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0.2,0.6,0.99,1};
		sizeEx = 0.8 * GUI_GRID_H;
		shadow = 1;
		colorShadow[] = {0,0,0,0.5};
		font="PuristaMedium";
		align="right";
	};

	class RscText_1001: RscText // black next to titlebar
	{
		idc = 1001;
		x = 12.5 * GUI_GRID_W + GUI_GRID_X;
		y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 400 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorBackground[] = {0,0,0,1};
	};
	class RscText_1002: RscText //black box behind everything
	{
		idc = 1002;
		x = -40 * GUI_GRID_W + GUI_GRID_X;
		y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
		w = 400 * GUI_GRID_W;
		h = 8.5 * GUI_GRID_H;
		colorBackground[] = {0,0,0,0.9};
	};
	class RscButton_1600: RscButton			//START MISSION
	{
		idc = 1600;
		text = "START MISSION"; 
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0.15,0.15,0.15,1};
		sizeEx = 0.8 * GUI_GRID_H;
		action = "_nul = [true] execvm ""Scripts\Dialog_Faction_Done.sqf""";
		tooltip = "";
		font="PuristaBold";
	};

	
		class RscFrame_1803: RscText //
	{
		idc = 1803;
		text = "Starting Zones"; 
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
		tooltip = "";
	};
	
			class RscFrame_1804: RscText //
	{
		idc = 1804;
		text = "Starting Resources"; 
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
		tooltip = "";
	};
	
				class RscFrame_1805: RscText //
		{
		idc = 1805;
		text = "Starting Difficulty"; 
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
		tooltip = "";
	};

				class RscFrame_1806: RscText //
		{
		idc = 1806;
		text = "Starting Reputation"; 
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
		tooltip = "";
	};
	
	class RscFrame_1800: RscText //
	{
		idc = 1800;
		text = "Player Faction"; 
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 17.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
		tooltip = "";
	};

	class RscFrame_1801: RscText //
	{
		idc = 1801;
		text = "Enemy Faction"; 
		x = 12 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 17.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
	};

	class RscFrame_1802: RscText //
	{
		idc = 1802;
		text = "Civilian Faction"; 
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 17.5 * GUI_GRID_W;
		h = 2.5 * GUI_GRID_H;
		colorText[] = {0.2,0.6,0.99,1};
		sizeEx = 0.7 * GUI_GRID_H;
		font="PuristaMedium";
	};
	
	
	class faction_selection_listbox: suprChooseFactionCombo 		//player
	{
		idc = 1955;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
	};
		
	
	class faction_selection_enemy_listbox: suprChooseFactionCombo		//enemy
	{
		idc = 1956;
		x = 12 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
	};
	
		
	class faction_selection_civilian_listbox: suprChooseFactionCombo		//Civilian
	{
		idc = 1957;
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
	};
	
		class faction_selection_presence_listbox: suprChooseFactionCombo		//Enemy Presence
	{
		idc = 1958;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
	};
	
			class faction_selection_Resources_listbox: suprChooseFactionCombo		//Starting Resources
	{
		idc = 1959;
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
	};
	
			class Reputation_selection_listbox: suprChooseFactionCombo 		//Reputation
	{
		idc = 1960;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 14 * GUI_GRID_H + GUI_GRID_Y;
	};
	
				class Difficulty_selection_listbox: suprChooseFactionCombo 		//Difficulty
	{
		idc = 1961;
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 14 * GUI_GRID_H + GUI_GRID_Y;
	};
};
};