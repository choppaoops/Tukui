--------------------------------------------------------------------
 -- BAGS
--------------------------------------------------------------------

if TukuiCF["datatext"].bags and TukuiCF["datatext"].bags > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].bags, Text)

	local function OnEvent(self, event, ...)
		local free, total, used = 0, 0, 0
		for i = 0, NUM_BAG_SLOTS do
			free, total = free + GetContainerNumFreeSlots(i), total + GetContainerNumSlots(i)
		end
		used = total - free
		Text:SetText(tukuilocal.datatext_bagsfree..valuecolor..free)
		Stat:SetAllPoints(Text)
		Stat:SetScript("OnEnter", function()
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(valuecolor..tukuilocal.datatext_bags)
			GameTooltip:AddLine(" ")
			GameTooltip:AddDoubleLine(tukuilocal.datatext_bagstotal,total,0, 0.6, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine(tukuilocal.datatext_bagsused,used,0, 0.6, 1, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
          
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("BAG_UPDATE")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() OpenAllBags() end)
end