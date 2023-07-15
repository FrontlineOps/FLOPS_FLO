

_Reward = _this select 0 ;
_OBJStr = _this select 1 ;

			{playMusic "EventTrack01_F_Curator";  } remoteExec ["call", 0];
			
							[parseText format ["<t color='#FACE00' font='PuristaBold' align = 'right' shadow = '1' size='3'>%1 SECURED</t><br /><t  align = 'right' shadow = '1' size='1.6'>%2 + + + </t>", _OBJStr, _Reward], [0, 0.5, 1, 1], nil, 4, 1.7, 0] remoteExec ["BIS_fnc_textTiles", 0];
