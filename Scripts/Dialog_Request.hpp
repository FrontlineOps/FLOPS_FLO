class supr_RequestsMenu
{
	idd = 1599;
	movingenable = true;
	
	class RscTextsupr_Request: RscText
	{
		colorText[] = {1,1,1,0.2};
		shadow=1;
		font="PuristaMedium";
		sizeEx = 0.75 * GUI_GRID_H;
	};
	class RscButtonsupr_Request: RscButton
	{
		colorText[] = {0.2,0.6,0.99,1};
		colorBackground[] = {0.08,0.08,0.08,1};
		shadow="0";
		y = 20.25 * GUI_GRID_H + GUI_GRID_Y;
		font="PuristaMedium";
	};
	
	class RscListboxsupr_Request: RscListbox
	{
		colorText[] = {0.88,0.88,0.88,1};
		colorBackground[] = {0.15,0.15,0.15,1};
		shadow=1;
		colorActive[]={1,1,1,1};
		colorPictureRightSelected[] = {1,1,1,1};
		colorSelect[]={1,1,1,1};
		colorSelectBackground[]={0.2,0.6,0.99,1};
		colorSelectBackground2[]={0.15,0.15,0.15,1};
		sizeEx = 0.475 * GUI_GRID_H;
		h = 10.5 * GUI_GRID_H;
		font="EtelkaMonospacePro";
	};
	
	class RscTextResourceBar: RscText
	{
		colorText[] = {1,1,1,1};
		colorBackground[] = {0.08,0.08,0.08,1};
		shadow=1;
		font="PuristaMedium";
		sizeEx = 0.7 * GUI_GRID_H;
	};
	
	
class controls
{
	
// Large black background

class supr_requestbg: RscText
{
	idc = -1;
	x = -50 * GUI_GRID_W + GUI_GRID_X;
	y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 200 * GUI_GRID_W;
	h = 16.5 * GUI_GRID_H;
	colorBackground[] = {0.08,0.08,0.08,1};
};

class supr_requestclose: RscButtonsupr_Request
{
	idc = 1600;
	text = "Close"; 
	x = 36.5 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 3 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.15,0.15,0.15,1};
	action="closeDialog 0";
	shadow=0;
	font="PuristaMedium";
};

class supr_requesttitlebar: RscTextsupr_Request
{
	idc = 1004;
	x = -50 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 50 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.2,0.6,0.99,1};
	colorText[] = {1,1,1,1};
	font="PuristaMedium";
	sizeEx = 0.75 * GUI_GRID_H;
};

class supr_requesttitlebarText: RscTextsupr_Request
{
	idc = 1004;
	text = "Request Menu"; 
	x = -2 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 20 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.2,0.6,0.99,1};
	colorText[] = {1,1,1,1};
	font="PuristaMedium";
	sizeEx = 0.95 * GUI_GRID_H;
};

class supr_requestmanpowertext: RscTextResourceBar   ///Resources
{
	idc = 1000;
	text = "Resources : x"; 
	x = 9 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 9.8 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.1,0.1,0.1,1};
};

class supr_requestsupplytext: RscTextResourceBar    ///Resistance
{
	idc = 1001;
	text = "Resistance : x"; 
	x = 17 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 9.8 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.1,0.1,0.1,1};
};

class supr_requestinteltext: RscTextResourceBar    ///Aggression
{
	idc = 1002;
	text = "Aggression : x"; 
	x = 25 * GUI_GRID_W + GUI_GRID_X;
	y = 6 * GUI_GRID_H + GUI_GRID_Y;
	w = 9.8 * GUI_GRID_W;
	h = 1.3 * GUI_GRID_H;	
	colorBackground[] = {0.1,0.1,0.1,1};
};



/* INFANTRY */
class supr_requestunitsbox: RscListboxsupr_Request
{
	idc = 2100;
	x = -6 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	
};
class supr_requestunitstitle: RscTextsupr_Request
{
	idc = -1;
	text = "INFANTRY"; 
	x = -6 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class supr_requestunitsbutton: RscButtonsupr_Request
{
	idc = 1601;
	text = "Request"; 
	x = -6 * GUI_GRID_W + GUI_GRID_X;	
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "[2100] call INF_REQUEST";

};





/* GROUND */


class supr_requestsquadsbox: RscListboxsupr_Request
{
	idc = 2101;
	x = 7 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	
};
class supr_requestsquadtext: RscTextsupr_Request
{
	idc = 1005;
	text = "GROUND VEHICLES"; 
	x = 7 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class supr_requestsquadbutton: RscButtonsupr_Request
{
	idc = 1602;
	text = "Request"; 
	x = 7 * GUI_GRID_W + GUI_GRID_X;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "[2101] call VEH_REQUEST"; 
};

class supr_requestFOBbutton: RscButtonsupr_Request
{
	idc = 1888;
	text = "New <FOB> Container <2000$>"; 
	x = 7 * GUI_GRID_W + GUI_GRID_X;
	y = 22 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "execVM 'Scripts\FOBHQ.sqf'"; 
};




/* AIR\SEA */


class supr_requestvehiclesbox: RscListboxsupr_Request
{
	idc = 2102;
	x = 20 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	
};
class supr_requestvehiclestext: RscTextsupr_Request
{
	idc = 1006;
	text = "AIR | SEA VEHICLES"; 
	x = 20 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};
class supr_requestvehiclebutton: RscButtonsupr_Request
{
	idc = 1603;
	text = "Request"; 
	x = 20 * GUI_GRID_W + GUI_GRID_X;
	h = 1 * GUI_GRID_H;
	w = 12 * GUI_GRID_W;
	
	action = "[2102] call VEH_REQUEST";
};
class supr_requestBRIBEbutton: RscButtonsupr_Request
{
	idc = 1999;
	text = "New <OP> Container <100$>"; 
	x = 20 * GUI_GRID_W + GUI_GRID_X;
	y = 22 * GUI_GRID_H + GUI_GRID_Y;
	h = 1 * GUI_GRID_H;
	w = 12 * GUI_GRID_W;
	
	action = "execVM 'Scripts\OPHQ.sqf'";
};


/* SUPPLIES */

class supr_requestsupportsbox: RscListboxsupr_Request
{
	idc = 2103;
	x = 33 * GUI_GRID_W + GUI_GRID_X;
	y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;

};

class supr_requestsupportstext: RscTextsupr_Request
{
	idc = 1007;
	text = "SUPPLIES"; 
	x = 33 * GUI_GRID_W + GUI_GRID_X;
	y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
};

class supr_unlocksupportsbutton: RscButtonsupr_Request
{
	idc = 1604;
	text = "Request"; 
	x = 33 * GUI_GRID_W + GUI_GRID_X;
	w = 12 * GUI_GRID_W;
	h = 1 * GUI_GRID_H;
	action = "[2103] call VEH_REQUEST";

};




};
};