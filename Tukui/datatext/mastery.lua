--from Eclipse edit
if TukuiCF["datatext"].mastery and TukuiCF["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF["media"].font2, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].mastery, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		mastery = GetMastery()

		if int < 0 then
			Text:SetText(tukuilocal.datatext_mastery..valuecolor..format("%.2f", mastery).."%")
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end