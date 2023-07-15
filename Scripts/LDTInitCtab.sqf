
sleep 1 ;
_UnitObj = _this select 0 ;

if (isClass (configfile >> "CfgVehicles" >> "Box_cTab_items") == true ) then { _UnitObj addItem "ItemAndroid"; _UnitObj addItem "ItemcTabHCam"; _UnitObj addItem "ItemcTab";  };  


