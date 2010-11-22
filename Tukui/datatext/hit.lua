------------------------------------------------------
--- Hit Rating
------------------------------------------------------
 
if TukuiCF["datatext"].hitrating and TukuiCF["datatext"].hitrating > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
 	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].hitrating, Text)
 
	local int = 1
 
	local function Update(self, t)
	int = int - t
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effective = base + posBuff + negBuff;
	local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player");
	local Reffective = Rbase + RposBuff + RnegBuff;
 
	Rattackpwr = Reffective
	spellpwr = GetSpellBonusDamage(7)
	attackpwr = effective
 
	if int < 0 then
			if attackpwr > spellpwr and TukuiDB.class ~= "HUNTER" then
				Text:SetText(tukuilocal.datatext_hitrating..valuecolor..format("%.2f", GetCombatRatingBonus(6)).."%")
			elseif TukuiDB.class == "HUNTER" then
				Text:SetText(tukuilocal.datatext_hitrating..valuecolor..format("%.2f", GetCombatRatingBonus(7)).."%")
			else
				Text:SetText(tukuilocal.datatext_hitrating..valuecolor..format("%.2f", GetCombatRatingBonus(8)).."%")
			end
			int = 1
		end
	end
 
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end