-- from Eclipse edit
local Stat = CreateFrame("Frame")

local Text  = TukuiLocationPanel:CreateFontString(nil, "LOW")
Text:SetFont(TukuiCF["media"].font2, TukuiCF["datatext"].fontsize)
Text:SetPoint("CENTER", 0, 0)
 
local function OnEvent(self, event)
	local location = GetMinimapZoneText()
	local pvpType, isFFA, zonePVPStatus = GetZonePVPInfo()

	if (pvpType == "sanctuary") then
		location = "|cff69C9EF"..location.."|r" -- light blue
	elseif (pvpType == "friendly") then
		location = "|cff00ff00"..location.."|r" -- green
	elseif (pvpType == "contested") then
		location = "|cffffff00"..location.."|r" -- yellow
	elseif (pvpType == "hostile" or pvpType == "combat" or pvpType == "arena" or not pvpType) then
		location = "|cffff0000"..location.."|r" -- red
	else
		location = location -- white
	end

	Text:SetText(location)
	TukuiLocationPanel:SetWidth(Text:GetWidth() + 24)
end

Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
Stat:RegisterEvent("ZONE_CHANGED_NEW_AREA")
Stat:RegisterEvent("ZONE_CHANGED")
Stat:RegisterEvent("ZONE_CHANGED_INDOORS")
Stat:SetScript("OnEvent", OnEvent)

-- Credits to AlleyKatz!
if TukuiCF["datatext"].location_coords == true then
	local Text2 = TukuiXCoordsPanel:CreateFontString(nil, "LOW")
	Text2:SetFont(TukuiCF["media"].font2, TukuiCF["datatext"].fontsize)
	Text2:SetPoint("CENTER", 0, 0)
 
	local Text3  = TukuiYCoordsPanel:CreateFontString(nil, "LOW")
	Text3:SetFont(TukuiCF["media"].font2, TukuiCF["datatext"].fontsize)
	Text3:SetPoint("CENTER", 0, 0)
	
	local ela,go = 0,false
	 
	local cUpdate = function(self,t)
		ela = ela - t
		if ela > 0 then return end
		local x,y = GetPlayerMapPosition("player")
		local xt,yt
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x == 0 and y == 0 then
			Text2:SetText("")
			Text3:SetText("")
			TukuiXCoordsPanel:SetAlpha(0)
			TukuiYCoordsPanel:SetAlpha(0)
		else
			if x < 10 then
				xt = "0"..x
			else
				xt = x
			end
			if y < 10 then
				yt = "0"..y
			else
				yt = y
			end
			Text2:SetText(xt)
			Text3:SetText(yt)
			TukuiXCoordsPanel:SetAlpha(1)
			TukuiYCoordsPanel:SetAlpha(1)
		end
		ela = .2
	end
	 
	TukuiXCoordsPanel:SetScript("OnUpdate", cUpdate)
end
