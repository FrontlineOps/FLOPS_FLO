// Background definition
#define GUI_GRID_PX_W 2048 // width in pixels
#define GUI_GRID_PX_H 2048 // hight in pixels

// Base macros to convert pixel space to screen space
#define pxToScreen_X(PIXEL) (PIXEL) / GUI_GRID_PX_W * GUI_GRID_W + GUI_GRID_X
#define pxToScreen_Y(PIXEL) (PIXEL) / GUI_GRID_PX_H * GUI_GRID_H + GUI_GRID_Y
#define pxToScreen_W(PIXEL) (PIXEL) / GUI_GRID_PX_W * GUI_GRID_W
#define pxToScreen_H(PIXEL) (PIXEL) / GUI_GRID_PX_H * GUI_GRID_H

// Map position within background, pixel based
#define cTab_GUI_tablet_MAP_X (257)
#define cTab_GUI_tablet_MAP_Y (491)
#define cTab_GUI_tablet_MAP_W (1341)
#define cTab_GUI_tablet_MAP_H (993)

// Height of header and footer OSD elements
#define cTab_GUI_tablet_OSD_HEADER_H (42)
#define cTab_GUI_tablet_OSD_FOOTER_H (0)

// Screen content (the stuff that changes, so map area - header and footer)
#define cTab_GUI_tablet_SCREEN_CONTENT_X (cTab_GUI_tablet_MAP_X)
#define cTab_GUI_tablet_SCREEN_CONTENT_Y (cTab_GUI_tablet_MAP_Y + cTab_GUI_tablet_OSD_HEADER_H)
#define cTab_GUI_tablet_SCREEN_CONTENT_W (cTab_GUI_tablet_MAP_W)
#define cTab_GUI_tablet_SCREEN_CONTENT_H (cTab_GUI_tablet_MAP_H - cTab_GUI_tablet_OSD_HEADER_H - cTab_GUI_tablet_OSD_FOOTER_H)

// Base macros to convert pixel space to screen space, but for groups (same size as map)
#define pxToGroup_X(PIXEL) (((PIXEL) - cTab_GUI_tablet_SCREEN_CONTENT_X) / GUI_GRID_PX_W * GUI_GRID_W)
#define pxToGroup_Y(PIXEL) (((PIXEL) - cTab_GUI_tablet_SCREEN_CONTENT_Y) / GUI_GRID_PX_H * GUI_GRID_H)

// Task bar absolute size, pixel based (from source)
#define cTab_GUI_tablet_TASKBAR_PX_W (1024)
#define cTab_GUI_tablet_TASKBAR_PX_H (28)

// Translate task bar size to pixel based size in background
#define cTab_GUI_tablet_TASKBAR_W (cTab_GUI_tablet_MAP_W)
#define cTab_GUI_tablet_TASKBAR_H (cTab_GUI_tablet_TASKBAR_W / cTab_GUI_tablet_TASKBAR_PX_W * cTab_GUI_tablet_TASKBAR_PX_H)

// Set task bar position at the bottom of the screen area
#define cTab_GUI_tablet_TASKBAR_X (cTab_GUI_tablet_MAP_X)
#define cTab_GUI_tablet_TASKBAR_Y (cTab_GUI_tablet_MAP_Y + cTab_GUI_tablet_MAP_H - cTab_GUI_tablet_TASKBAR_H)

// Window background (application windows) absolute size, pixel based (from source)
#define cTab_GUI_tablet_WINDOW_BACK_PX_W (293)
#define cTab_GUI_tablet_WINDOW_BACK_PX_H (272)

// Window content (application windows) position within window background, pixel based
#define cTab_GUI_tablet_WINDOW_CONTENT_PX_X (9)
#define cTab_GUI_tablet_WINDOW_CONTENT_PX_Y (30)
#define cTab_GUI_tablet_WINDOW_CONTENT_PX_W (276)
#define cTab_GUI_tablet_WINDOW_CONTENT_PX_H (232)

// Translate window background size to pixel based position in background (heith is 49 % of tablet screen height)
#define cTab_GUI_tablet_WINDOW_BACK_H ((cTab_GUI_tablet_SCREEN_CONTENT_H - cTab_GUI_tablet_TASKBAR_H) * 0.49)
#define cTab_GUI_tablet_WINDOW_BACK_W (cTab_GUI_tablet_WINDOW_BACK_PX_W / cTab_GUI_tablet_WINDOW_BACK_PX_H * cTab_GUI_tablet_WINDOW_BACK_H)

// Translate window content size to pixel based position in background
#define cTab_GUI_tablet_WINDOW_CONTENT_W (cTab_GUI_tablet_WINDOW_CONTENT_PX_W / cTab_GUI_tablet_WINDOW_BACK_PX_W * cTab_GUI_tablet_WINDOW_BACK_W)
#define cTab_GUI_tablet_WINDOW_CONTENT_H (cTab_GUI_tablet_WINDOW_CONTENT_PX_H / cTab_GUI_tablet_WINDOW_BACK_PX_H * cTab_GUI_tablet_WINDOW_BACK_H)

// Translate window content offsets (from edges of window background) to pixel based positions in background
#define cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_X (cTab_GUI_tablet_WINDOW_CONTENT_PX_X / cTab_GUI_tablet_WINDOW_BACK_PX_W * cTab_GUI_tablet_WINDOW_BACK_W)
#define cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_Y (cTab_GUI_tablet_WINDOW_CONTENT_PX_Y / cTab_GUI_tablet_WINDOW_BACK_PX_H * cTab_GUI_tablet_WINDOW_BACK_H)

// Distribute window backgrounds evenly on the available screen space for 2x2 windows
#define cTab_GUI_tablet_WINDOW_BACK_L_X (cTab_GUI_tablet_SCREEN_CONTENT_X + (cTab_GUI_tablet_SCREEN_CONTENT_W - 2 * cTab_GUI_tablet_WINDOW_BACK_W) / 3)
#define cTab_GUI_tablet_WINDOW_BACK_R_X (cTab_GUI_tablet_SCREEN_CONTENT_X + cTab_GUI_tablet_WINDOW_BACK_W + (cTab_GUI_tablet_SCREEN_CONTENT_W - 2 * cTab_GUI_tablet_WINDOW_BACK_W) / 3 * 2)
#define cTab_GUI_tablet_WINDOW_BACK_T_Y (cTab_GUI_tablet_SCREEN_CONTENT_Y + (cTab_GUI_tablet_SCREEN_CONTENT_H - cTab_GUI_tablet_TASKBAR_H - 2 * cTab_GUI_tablet_WINDOW_BACK_H) / 3)
#define cTab_GUI_tablet_WINDOW_BACK_B_Y (cTab_GUI_tablet_SCREEN_CONTENT_Y + cTab_GUI_tablet_WINDOW_BACK_H + (cTab_GUI_tablet_SCREEN_CONTENT_H - cTab_GUI_tablet_TASKBAR_H - 2 * cTab_GUI_tablet_WINDOW_BACK_H) / 3 * 2)

// Place window content within window background
#define cTab_GUI_tablet_WINDOW_CONTENT_L_X (cTab_GUI_tablet_WINDOW_BACK_L_X + cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_X)
#define cTab_GUI_tablet_WINDOW_CONTENT_R_X (cTab_GUI_tablet_WINDOW_BACK_R_X + cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_X)
#define cTab_GUI_tablet_WINDOW_CONTENT_T_Y (cTab_GUI_tablet_WINDOW_BACK_T_Y + cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_Y)
#define cTab_GUI_tablet_WINDOW_CONTENT_B_Y (cTab_GUI_tablet_WINDOW_BACK_B_Y + cTab_GUI_tablet_WINDOW_CONTENT_OFFSET_Y)

// Desktop icon size and offset from tablet screen edge in pixels
#define cTab_GUI_tablet_DESKTOP_ICON_OFFSET_X (25)
#define cTab_GUI_tablet_DESKTOP_ICON_OFFSET_Y (25)
#define cTab_GUI_tablet_DESKTOP_ICON_W (100)
#define cTab_GUI_tablet_DESKTOP_ICON_H (100)

// Message element positions in pixels
#define cTab_GUI_tablet_MESSAGE_MARGIN_OUTER (20)
#define cTab_GUI_tablet_MESSAGE_MARGIN_INNER (10)

#define cTab_GUI_tablet_MESSAGE_BUTTON_W (150)
#define cTab_GUI_tablet_MESSAGE_BUTTON_H (50)

#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_X (cTab_GUI_tablet_SCREEN_CONTENT_X + cTab_GUI_tablet_MESSAGE_MARGIN_OUTER)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_Y (cTab_GUI_tablet_SCREEN_CONTENT_Y + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_W (cTab_GUI_tablet_SCREEN_CONTENT_W - cTab_GUI_tablet_MESSAGE_MARGIN_OUTER * 2)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_H ((cTab_GUI_tablet_SCREEN_CONTENT_H - cTab_GUI_tablet_TASKBAR_H - cTab_GUI_tablet_MESSAGE_MARGIN_INNER * 3) / 2)

#define cTab_GUI_tablet_MESSAGE_MESSAGELIST_X (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_X + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)
#define cTab_GUI_tablet_MESSAGE_MESSAGELIST_Y (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_Y + cTab_GUI_tablet_MESSAGE_MARGIN_OUTER)
#define cTab_GUI_tablet_MESSAGE_MESSAGELIST_W ((cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_W - cTab_GUI_tablet_MESSAGE_MARGIN_INNER * 3) / 3)
#define cTab_GUI_tablet_MESSAGE_MESSAGELIST_H (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_H - cTab_GUI_tablet_MESSAGE_MARGIN_INNER - cTab_GUI_tablet_MESSAGE_MARGIN_OUTER)

#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_X (cTab_GUI_tablet_MESSAGE_MESSAGELIST_X + cTab_GUI_tablet_MESSAGE_MESSAGELIST_W + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_Y (cTab_GUI_tablet_MESSAGE_MESSAGELIST_Y)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_W (cTab_GUI_tablet_MESSAGE_MESSAGELIST_W * 2)
#define cTab_GUI_tablet_MESSAGE_MESSAGETEXT_H (cTab_GUI_tablet_MESSAGE_MESSAGELIST_H - cTab_GUI_tablet_MESSAGE_MARGIN_INNER - cTab_GUI_tablet_MESSAGE_BUTTON_H)

#define cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_X (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_X)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_Y (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_Y + cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_H + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_W (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_W)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_H (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_FRAME_H)

#define cTab_GUI_tablet_MESSAGE_PLAYERLIST_X (cTab_GUI_tablet_MESSAGE_MESSAGELIST_X)
#define cTab_GUI_tablet_MESSAGE_PLAYERLIST_Y (cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_Y + cTab_GUI_tablet_MESSAGE_MARGIN_OUTER)
#define cTab_GUI_tablet_MESSAGE_PLAYERLIST_W (cTab_GUI_tablet_MESSAGE_MESSAGELIST_W)
#define cTab_GUI_tablet_MESSAGE_PLAYERLIST_H (cTab_GUI_tablet_MESSAGE_MESSAGELIST_H)

#define cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_X (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_X)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_Y (cTab_GUI_tablet_MESSAGE_PLAYERLIST_Y)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_W (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_W)
#define cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_H (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_H)

#define cTab_GUI_tablet_MESSAGE_BUTTON_SEND_X (cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_X + cTab_GUI_tablet_MESSAGE_COMPOSE_FRAME_W - cTab_GUI_tablet_MESSAGE_MARGIN_INNER - cTab_GUI_tablet_MESSAGE_BUTTON_W)
#define cTab_GUI_tablet_MESSAGE_BUTTON_SEND_Y (cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_Y + cTab_GUI_tablet_MESSAGE_COMPOSE_TEXT_H + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)

#define cTab_GUI_tablet_MESSAGE_BUTTON_DELETE_X (cTab_GUI_tablet_MESSAGE_BUTTON_SEND_X)
#define cTab_GUI_tablet_MESSAGE_BUTTON_DELETE_Y (cTab_GUI_tablet_MESSAGE_MESSAGETEXT_Y + cTab_GUI_tablet_MESSAGE_MESSAGETEXT_H + cTab_GUI_tablet_MESSAGE_MARGIN_INNER)

// On-screen edge positions (left, right, top, bottom)
#define cTab_GUI_tablet_OSD_MARGIN (10)
#define cTab_GUI_tablet_OSD_EDGE_L (cTab_GUI_tablet_OSD_MARGIN + cTab_GUI_tablet_SCREEN_CONTENT_X)
#define cTab_GUI_tablet_OSD_EDGE_R (-cTab_GUI_tablet_OSD_MARGIN + cTab_GUI_tablet_SCREEN_CONTENT_X + cTab_GUI_tablet_SCREEN_CONTENT_W)
#define cTab_GUI_tablet_OSD_EDGE_T (cTab_GUI_tablet_OSD_MARGIN + cTab_GUI_tablet_SCREEN_CONTENT_Y)
#define cTab_GUI_tablet_OSD_EDGE_B (-cTab_GUI_tablet_OSD_FOOTER_H + cTab_GUI_tablet_MAP_Y + cTab_GUI_tablet_MAP_H)

// On-screen element base width and height
#define cTab_GUI_tablet_OSD_ELEMENT_STD_W ((cTab_GUI_tablet_SCREEN_CONTENT_W - cTab_GUI_tablet_OSD_MARGIN * 8) / 7)
#define cTab_GUI_tablet_OSD_ELEMENT_STD_H (cTab_GUI_tablet_OSD_HEADER_H - cTab_GUI_tablet_OSD_MARGIN)

// On-screen element X-coord for left, center and right elements
#define cTab_GUI_tablet_OSD_LEFT_X (cTab_GUI_tablet_OSD_EDGE_L)
#define cTab_GUI_tablet_OSD_CENTER_X (cTab_GUI_tablet_OSD_EDGE_L + cTab_GUI_tablet_OSD_MARGIN + cTab_GUI_tablet_OSD_ELEMENT_STD_W)
#define cTab_GUI_tablet_OSD_RIGHT_X (cTab_GUI_tablet_OSD_EDGE_R - cTab_GUI_tablet_OSD_ELEMENT_STD_W)

// On-screen element X-coord for left, center and right elements
#define cTab_GUI_tablet_OSD_X(ITEM) (cTab_GUI_tablet_OSD_EDGE_L + (cTab_GUI_tablet_OSD_MARGIN + cTab_GUI_tablet_OSD_ELEMENT_STD_W) * (ITEM - 1))

// On-screen text sizes, hight in pixels
// Standard text elements
#define cTab_GUI_tablet_OSD_TEXT_STD_SIZE (27)
#define cTab_GUI_tablet_OSD_ICON_STD_SIZE (35)

// On-screen map centre cursor
#define cTab_GUI_tablet_CURSOR (32)

// set IDC counter to 0
__EXEC(cTab_IDC = 0);
#define IDC_COUNTER __EXEC(cTab_IDC = cTab_IDC + 1); idc = __EVAL(cTab_IDC);

class cTab_RscText_Tablet: cTab_RscText
{
	style = ST_CENTER;
	w = pxToScreen_W(cTab_GUI_tablet_OSD_ELEMENT_STD_W);
	h = pxToScreen_H(cTab_GUI_tablet_OSD_ELEMENT_STD_H);
	font = GUI_FONT_MONO;
	colorText[] = COLOR_WHITE;
	sizeEx = pxToScreen_H(cTab_GUI_tablet_OSD_TEXT_STD_SIZE);
	colorBackground[] = COLOR_TRANSPARENT;
	shadow = 0;
};
class cTab_RscListbox_Tablet: cTab_RscListbox
{
	sizeEx = pxToScreen_H(cTab_GUI_tablet_OSD_TEXT_STD_SIZE * 1.2);
};
class cTab_RscEdit_Tablet: cTab_RscEdit
{
	sizeEx = pxToScreen_H(cTab_GUI_tablet_OSD_TEXT_STD_SIZE * 1.2);
};
class cTab_RscButton_Tablet: cTab_RscButton
{
	font = GUI_FONT_MONO;
	sizeEx = pxToScreen_H(cTab_GUI_tablet_OSD_TEXT_STD_SIZE);
};
class cTab_Tablet_background: cTab_RscPicture
{
	idc = IDC_CTAB_BACKGROUND;
	text = "";
	x = GUI_GRID_X;
	y = GUI_GRID_Y;
	w = GUI_GRID_W;
	h = GUI_GRID_H;
};
class cTab_tablet_header: cTab_RscPicture
{
	IDC_COUNTER
	text = "#(argb,8,8,3)color(0,0,0,1)";
	x = pxToScreen_X(cTab_GUI_tablet_MAP_X);
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y);
	w = pxToScreen_W(cTab_GUI_tablet_MAP_W);
	h = pxToScreen_H(cTab_GUI_tablet_OSD_HEADER_H);
};
class cTab_Tablet_OSD_battery: cTab_RscPicture
{
	IDC_COUNTER
	text = "\cTab\img\icon_battery_ca.paa";
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(1));
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y + (cTab_GUI_tablet_OSD_HEADER_H - cTab_GUI_tablet_OSD_ICON_STD_SIZE) / 2);
	w = pxToScreen_W(cTab_GUI_tablet_OSD_ICON_STD_SIZE);
	h = pxToScreen_H(cTab_GUI_tablet_OSD_ICON_STD_SIZE);
	colorText[] = COLOR_WHITE;
};
class cTab_Tablet_OSD_time: cTab_RscText_Tablet
{
	idc = IDC_CTAB_OSD_TIME;
	style = ST_CENTER;
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(4));
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y + (cTab_GUI_tablet_OSD_HEADER_H - cTab_GUI_tablet_OSD_TEXT_STD_SIZE) / 2);
};
class cTab_Tablet_OSD_signalStrength: cTab_Tablet_OSD_battery
{
	IDC_COUNTER
	text = "\cTab\img\icon_signalStrength_ca.paa";
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(7) + cTab_GUI_tablet_OSD_ELEMENT_STD_W - cTab_GUI_tablet_OSD_ICON_STD_SIZE * 2);
	colorText[] = COLOR_WHITE;
};
class cTab_Tablet_OSD_satellite: cTab_Tablet_OSD_battery
{
	IDC_COUNTER
	text = "\a3\ui_f\data\map\Diary\signal_ca.paa";
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(7) + cTab_GUI_tablet_OSD_ELEMENT_STD_W - cTab_GUI_tablet_OSD_ICON_STD_SIZE);
	colorText[] = COLOR_WHITE;
};
class cTab_Tablet_OSD_dirDegree: cTab_Tablet_OSD_time
{
	idc = IDC_CTAB_OSD_DIR_DEGREE;
	style = ST_LEFT;
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(2));
};
class cTab_Tablet_OSD_grid: cTab_Tablet_OSD_dirDegree
{
	idc = IDC_CTAB_OSD_GRID;
	style = ST_RIGHT;
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(6));
};
class cTab_Tablet_OSD_dirOctant: cTab_Tablet_OSD_dirDegree
{
	idc = IDC_CTAB_OSD_DIR_OCTANT;
	style = ST_RIGHT;
	x = pxToScreen_X(cTab_GUI_tablet_OSD_X(1));
};
class cTab_Tablet_window_back_TL: cTab_RscPicture
{
	text = "\cTab\img\window_2.jpg";
	x = pxToScreen_X(cTab_GUI_tablet_WINDOW_BACK_L_X);
	y = pxToScreen_Y(cTab_GUI_tablet_WINDOW_BACK_T_Y);
	w = pxToScreen_W(cTab_GUI_tablet_WINDOW_BACK_W);
	h = pxToScreen_H(cTab_GUI_tablet_WINDOW_BACK_H);
};
class cTab_Tablet_window_back_BL: cTab_Tablet_window_back_TL
{
	y = pxToScreen_Y(cTab_GUI_tablet_WINDOW_BACK_B_Y);
};
class cTab_Tablet_window_back_TR: cTab_Tablet_window_back_TL
{
	x = pxToScreen_X(cTab_GUI_tablet_WINDOW_BACK_R_X);
};
class cTab_Tablet_window_back_BR: cTab_Tablet_window_back_TR
{
	y = pxToScreen_Y(cTab_GUI_tablet_WINDOW_BACK_B_Y);
};
class cTab_Tablet_btnF1: cTab_RscButtonInv
{
	x = pxToScreen_X(506);
	y = pxToScreen_Y(1545);
	w = pxToScreen_W(52);
	h = pxToScreen_H(52);
};
class cTab_Tablet_btnF2: cTab_Tablet_btnF1
{
	x = pxToScreen_X(569);
};
class cTab_Tablet_btnF3: cTab_Tablet_btnF1
{
	x = pxToScreen_X(639);
};
class cTab_Tablet_btnF4: cTab_Tablet_btnF1
{
	x = pxToScreen_X(703);
};
class cTab_Tablet_btnF5: cTab_Tablet_btnF1
{
	x = pxToScreen_X(768);
};
class cTab_Tablet_btnF6: cTab_Tablet_btnF1
{
	x = pxToScreen_X(833);
};
class cTab_Tablet_btnFn: cTab_Tablet_btnF1
{
	x = pxToScreen_X(970);
};
class cTab_Tablet_btnPower: cTab_Tablet_btnFn
{
	x = pxToScreen_X(1034);
};
class cTab_Tablet_btnBrtDn: cTab_Tablet_btnFn
{
	x = pxToScreen_X(1100);
};
class cTab_Tablet_btnBrtUp: cTab_Tablet_btnFn
{
	x = pxToScreen_X(1163);
};
class cTab_Tablet_btnTrackpad: cTab_Tablet_btnFn
{
	x = pxToScreen_X(1262);
	y = pxToScreen_Y(1550);
	w = pxToScreen_W(48);
	h = pxToScreen_H(43);
};
class cTab_Tablet_btnMouse: cTab_Tablet_btnFn
{
	x = pxToScreen_X(1401);
	w = pxToScreen_W(91);
};
class cTab_Tablet_btnHome: cTab_Tablet_btnMouse
{
	x = pxToScreen_X(897);
	y = pxToScreen_Y(1534);
	w = pxToScreen_W(61);
	h = pxToScreen_H(49);
};
class cTab_Tablet_notificationLight
{
	x = pxToScreen_X(1353);
	y = pxToScreen_Y(1557);
	w = pxToScreen_W(28);
	h = pxToScreen_H(28);
};
class cTab_Tablet_OSD_hookGrid: cTab_RscText_Tablet
{
	idc = IDC_CTAB_OSD_HOOK_GRID;
	style = ST_CENTER;
	x = pxToScreen_X(cTab_GUI_tablet_OSD_RIGHT_X);
	y = pxToScreen_Y(cTab_GUI_tablet_OSD_EDGE_B - cTab_GUI_tablet_OSD_MARGIN - cTab_GUI_tablet_OSD_ELEMENT_STD_H * 4);
	colorText[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,0.25};
};
class cTab_Tablet_OSD_hookElevation: cTab_Tablet_OSD_hookGrid
{
	idc = IDC_CTAB_OSD_HOOK_ELEVATION;
	y = pxToScreen_Y(cTab_GUI_tablet_OSD_EDGE_B - cTab_GUI_tablet_OSD_MARGIN - cTab_GUI_tablet_OSD_ELEMENT_STD_H * 3);
};
class cTab_Tablet_OSD_hookDst: cTab_Tablet_OSD_hookGrid
{
	idc = IDC_CTAB_OSD_HOOK_DST;
	y = pxToScreen_Y(cTab_GUI_tablet_OSD_EDGE_B - cTab_GUI_tablet_OSD_MARGIN - cTab_GUI_tablet_OSD_ELEMENT_STD_H * 2);
};
class cTab_Tablet_OSD_hookDir: cTab_Tablet_OSD_hookGrid
{
	idc = IDC_CTAB_OSD_HOOK_DIR;
	y = pxToScreen_Y(cTab_GUI_tablet_OSD_EDGE_B - cTab_GUI_tablet_OSD_MARGIN - cTab_GUI_tablet_OSD_ELEMENT_STD_H);
};
class cTab_Tablet_loadingtxt: cTab_RscText_Tablet
{
	idc = IDC_CTAB_LOADINGTXT;
	style = ST_CENTER;
	text = "Loading"; //--- ToDo: Localize;
	x = pxToScreen_X(cTab_GUI_tablet_SCREEN_CONTENT_X);
	y = pxToScreen_Y(cTab_GUI_tablet_SCREEN_CONTENT_Y);
	w = pxToScreen_W(cTab_GUI_tablet_SCREEN_CONTENT_W);
	h = pxToScreen_H(cTab_GUI_tablet_SCREEN_CONTENT_H);
	colorBackground[] = COLOR_LIGHT_BLUE;
};
// Define areas around the screen as interaction areas to allow screen movement
class cTab_Tablet_movingHandle_T: cTab_RscText_Tablet
{
	IDC_COUNTER
	moving = 1;
	colorBackground[] = COLOR_TRANSPARENT;
	x = pxToScreen_X(0);
	y = pxToScreen_Y(0);
	w = pxToScreen_W(GUI_GRID_PX_W);
	h = pxToScreen_H(cTab_GUI_tablet_MAP_Y);
};
class cTab_Tablet_movingHandle_B: cTab_Tablet_movingHandle_T
{
	IDC_COUNTER
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y + cTab_GUI_tablet_MAP_H);
	h = pxToScreen_H(GUI_GRID_PX_H - (cTab_GUI_tablet_MAP_Y + cTab_GUI_tablet_MAP_H));
};
class cTab_Tablet_movingHandle_L: cTab_Tablet_movingHandle_T
{
	IDC_COUNTER
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y);
	w = pxToScreen_W(cTab_GUI_tablet_MAP_X);
	h = pxToScreen_H(cTab_GUI_tablet_MAP_H);
};
class cTab_Tablet_movingHandle_R: cTab_Tablet_movingHandle_L
{
	IDC_COUNTER
	x = pxToScreen_X(cTab_GUI_tablet_MAP_X + cTab_GUI_tablet_MAP_W);
	w = pxToScreen_W(GUI_GRID_PX_W - (cTab_GUI_tablet_MAP_X + cTab_GUI_tablet_MAP_W));
};

// transparent control that gets placed on top of the GUI to adjust brightness
class cTab_Tablet_brightness: cTab_RscText_Tablet
{
	idc = IDC_CTAB_BRIGHTNESS;
	x = pxToScreen_X(cTab_GUI_tablet_MAP_X);
	y = pxToScreen_Y(cTab_GUI_tablet_MAP_Y);
	w = pxToScreen_W(cTab_GUI_tablet_MAP_W);
	h = pxToScreen_H(cTab_GUI_tablet_MAP_H);
	colorBackground[] = COLOR_TRANSPARENT;
};
class cTab_Tablet_RscMapControl: cTab_RscMapControl
{
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = pxToScreen_X(cTab_GUI_tablet_SCREEN_CONTENT_X);
	y = pxToScreen_Y(cTab_GUI_tablet_SCREEN_CONTENT_Y);
	w = pxToScreen_W(cTab_GUI_tablet_SCREEN_CONTENT_W);
	h = pxToScreen_H(cTab_GUI_tablet_SCREEN_CONTENT_H);
	maxSatelliteAlpha = 10000;
	alphaFadeStartScale = 10;
	alphaFadeEndScale = 10;

	// Rendering density coefficients
	ptsPerSquareSea = 8 / (0.86 / GUI_GRID_H);		// seas
	ptsPerSquareTxt = 8 / (0.86 / GUI_GRID_H);		// textures
	ptsPerSquareCLn = 8 / (0.86 / GUI_GRID_H);		// count-lines
	ptsPerSquareExp = 8 / (0.86 / GUI_GRID_H);		// exposure
	ptsPerSquareCost = 8 / (0.86 / GUI_GRID_H);		// cost

	// Rendering thresholds
	ptsPerSquareFor = 3 / (0.86 / GUI_GRID_H);		// forests
	ptsPerSquareForEdge = 100 / (0.86 / GUI_GRID_H);	// forest edges
	ptsPerSquareRoad = 1.5 / (0.86 / GUI_GRID_H);		// roads
	ptsPerSquareObj = 4 / (0.86 / GUI_GRID_H);		// other objects
};
class cTab_Tablet_notification: cTab_RscText_Tablet {
    idc = IDC_CTAB_NOTIFICATION;
    x = pxToScreen_X(cTab_GUI_tablet_SCREEN_CONTENT_X + (cTab_GUI_tablet_SCREEN_CONTENT_W * 0.5) / 2);
    y = pxToScreen_Y(cTab_GUI_tablet_SCREEN_CONTENT_Y + cTab_GUI_tablet_SCREEN_CONTENT_H - 2 * cTab_GUI_tablet_OSD_TEXT_STD_SIZE);
    w = pxToScreen_W(cTab_GUI_tablet_SCREEN_CONTENT_W * 0.5);
    colorBackground[] = COLOR_BLACK;
};