--------------------------------------------------------------------
-- Crit (Spell or Melee.. or ranged)
--------------------------------------------------------------------

if TukuiCF["datatext"].crit and TukuiCF["datatext"].crit > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].crit, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		meleecrit = GetCritChance()
		spellcrit = GetSpellCritChance(1)
		rangedcrit = GetRangedCritChance()
		meleecritrating = GetCombatRating(9)
		spellcritrating = GetCombatRating(11)
		rangedcritrating = GetCombatRating(10)
		if spellcrit > meleecrit then
			CritChance = spellcrit
			CritChanceRating = spellcritrating
		elseif TukuiDB.class == "HUNTER" then    
			CritChance = rangedcrit
			CritChanceRating = rangedcritrating
		else
			CritChance = meleecrit
			CritChanceRating = meleecritrating
		end
		if int < 0 then
			Text:SetText("crit"..": "..valuecolor..format("%.2f", CritChance) .. "%")
			Stat:SetAllPoints(Text)
			Stat:SetScript("OnEnter", function()
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, -TukuiDB.Scale(6));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("TOP", self, "BOTTOM", 0, -TukuiDB.mult)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(tukuilocal.datatext_critrating,CritChanceRating,0, 0.6, 1, 1, 1, 1)
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