_Civl = _this select 0 ;

_ChanceN = selectRandom [1, 2, 3]; 

if ((_Civl getUnitTrait "engineer" == true) && (_ChanceN > 1)) then {	
_complMessage = selectRandom ["We Don't Need Your Help Outsider, Move away, GOD Dawn you ALL !!!", "Wanna Help ? make  alive My little Brother that you Killed, Fuck off you Bastard, GOD kill you ALL !!!","You will Pay for what you have done to our Country, I dont tell you shit !!!","We Dont need your Help, JUST FUCK OFF !!!","Your Men Caused my Innocent brothers and sisters Suffer and Die, Fuck you, FUCK YOU ALL !!!"];
["Civilian", _complMessage] remoteExec ["BIS_fnc_showSubtitle"];

		}else{

				_Chance = selectRandom [1, 2, 3, 4]; 

				if (_Chance == 1) then {
					
							execVM "Scripts\CIVM_1.sqf";
							["Civilian", "Ive heard some of you are Engineers, One of Locals Troubled his Vehicle somewhere Along the Road, Think You can Help?"] remoteExec ["BIS_fnc_showSubtitle", 0];
							};

				if (_Chance == 2) then {
					
							execVM "Scripts\CIVM_2.sqf";
							["Civilian", "This Neighborhood Runs low on Supplies and the IDAP does not Accept the Risk, Can your Guys help them?"] remoteExec ["BIS_fnc_showSubtitle", 0];
							};

				if (_Chance == 3) then {
					
							execVM "Scripts\CIVM_3.sqf";
							["Civilian", "our Neighbors Found a Minefield the hard way near this Area, Can Your Engineers take a look at it ?"] remoteExec ["BIS_fnc_showSubtitle", 0];
							};


				if (_Chance == 4) then {
								
							[_Civl] execVM "Scripts\CIVM_4.sqf";
							["Civilian", "I know you were Looking for Insurgents, They have been seen along these roads few nights, Can you Create Checkpoints ?"] remoteExec ["BIS_fnc_showSubtitle", 0];
							};

};