----- [[    Honor / Conquest / Justice Points by Ecl?ps?    ]] -----

cEnd = "|r"

if TukuiCF["datatext"].points and TukuiCF["datatext"].points > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].points, Text)

	local function OnEvent(self, event)	
		h_name, h_amount, h_icon = GetCurrencyInfo(392) -- Honor Points
		c_name, c_amount, c_icon = GetCurrencyInfo(390) -- Conquest Points
		j_name, j_amount, j_icon = GetCurrencyInfo(395) -- Justice Points

		local honor = ""
		local conquest = ""
		local justice = ""
		if h_amount > 0 then
			honor = ("hp: "..valuecolor..h_amount .. " "..cEnd)
		end
		if c_amount > 0 then
			conquest = ("cp: "..valuecolor..c_amount .. " "..cEnd)
		end
		if j_amount > 0 then
			justice = ("jp: "..valuecolor..j_amount)
		end

		if h_amount == 0 and c_amount == 0 and j_amount == 0 then
			Text:SetText(valuecolor .. tukuilocal.datatext_nopoints) 
		else
			Text:SetText(honor .. conquest .. justice) 
		end

		self:SetAllPoints(Text)
	end

	Stat:RegisterEvent("HONOR_CURRENCY_UPDATE")
	Stat:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(valuecolor..CURRENCY)
			GameTooltip:AddLine" "

			if h_amount > 0 then
				GameTooltip:AddDoubleLine(h_name .. ":", valuecolor..h_amount,1,1,1)
			end
			if c_amount > 0 then
				GameTooltip:AddDoubleLine(c_name .. ":", valuecolor..c_amount,1,1,1)
			end
			if j_amount > 0 then
				GameTooltip:AddDoubleLine(j_name .. ":", valuecolor..j_amount,1,1,1)
			end
			GameTooltip:Show()
		end
		if h_amount == 0 and c_amount == 0 and j_amount == 0 then
		GameTooltip:Hide()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end