--------------------------------------------------------------------------
-- move vehicle indicator
--------------------------------------------------------------------------

hooksecurefunc(VehicleSeatIndicator,"SetPoint",function(_,_,parent) -- vehicle seat indicator
    if (parent == "MinimapCluster") or (parent == _G["MinimapCluster"]) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:SetPoint("TOP", Minimap, "BOTTOM", 0, TukuiDB.Scale(-110))
		VehicleSeatIndicator:SetScale(0.7)
    end
end)
