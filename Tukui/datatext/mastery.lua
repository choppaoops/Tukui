--from Eclipse edit
if TukuiCF["datatext"].mastery and TukuiCF["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["media"].font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].mastery, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		mastery = GetMastery()
		mrating = GetCombatRating(26)

		if int < 0 then
			Text:SetText(tukuilocal.datatext_mastery..valuecolor..format("%.2f", mastery).."%")
			Stat:SetAllPoints(Text)
			Stat:SetScript("OnEnter", function()
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(tukuilocal.datatext_mrating,mrating,0, 0.6, 1, 1, 1, 1)
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end