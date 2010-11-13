ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("LEFT", Minimap, "LEFT", TukuiDB.Scale(0), TukuiDB.Scale(0))
ConsolidatedBuffs:SetSize(16, 16)
ConsolidatedBuffsIcon:SetTexture(nil)
ConsolidatedBuffs.SetPoint = TukuiDB.dummy

if TukuiCF["auras"].minimapauras ~= true then return end

local mainhand, _, _, offhand = GetWeaponEnchantInfo()
local rowbuffs = 12
local warningtime = 6

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, TukuiDB.Scale(-8))
TemporaryEnchantFrame.SetPoint = TukuiDB.dummy

TempEnchant1:ClearAllPoints()
TempEnchant2:ClearAllPoints()
TempEnchant1:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", TukuiDB.Scale(-8), TukuiDB.Scale(2))
TempEnchant2:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-4), 0)

for i = 1, 3 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	TukuiDB.CreatePanel(f, 30, 30, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
	_G["TempEnchant"..i]:SetHeight(TukuiDB.Scale(30))
	_G["TempEnchant"..i]:SetWidth(TukuiDB.Scale(30))	
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("BOTTOM", 0, TukuiDB.Scale(-5))
	_G["TempEnchant"..i.."Duration"]:SetFont(TukuiCF["media"].font2, 10, "THINOUTLINE")
end

local function StyleBuffs(buttonName, index, debuff)
	local buff		= _G[buttonName..index]
	local icon		= _G[buttonName..index.."Icon"]
	local border	= _G[buttonName..index.."Border"]
	local duration	= _G[buttonName..index.."Duration"]
	local count 	= _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetPoint("TOPLEFT", buff, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", buff, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		
		buff:SetHeight(TukuiDB.Scale(30))
		buff:SetWidth(TukuiDB.Scale(30))
				
		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", 0, TukuiDB.Scale(-5))
		duration:SetFont(TukuiCF["media"].font2, 10, "THINOUTLINE")
		
		count:ClearAllPoints()
		count:SetPoint("TOPLEFT", TukuiDB.Scale(1), TukuiDB.Scale(-2))
		count:SetFont(TukuiCF["media"].font2, 10, "OUTLINE")
		
		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		TukuiDB.CreatePanel(panel, 30, 30, "CENTER", buff, "CENTER", 0, 0)
		TukuiDB.CreateShadow(panel)
		panel:SetFrameLevel(buff:GetFrameLevel()-1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

function UpdateFlash(self, elapsed)
	local index = self:GetID();
	if ( self.timeLeft < warningtime ) then
		self:SetAlpha(BuffFrame.BuffAlphaValue);
	else
		self:SetAlpha(1.0);
	end
end

local function UpdateBuffAnchors()
	buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff;
	local numBuffs = 0;
	local index;
	for index=1, BUFF_ACTUAL_DISPLAY do
		local buff = _G[buttonName..index]
		StyleBuffs(buttonName, index, false)
		
		if ( buff.consolidated ) then
			if ( buff.parent == BuffFrame ) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			index = numBuffs
			buff:ClearAllPoints()
			if ( (index > 1) and (mod(index, rowbuffs) == 1) ) then
				if ( index == rowbuffs+1 ) then
					buff:SetPoint("RIGHT", Minimap, "LEFT", TukuiDB.Scale(-8), TukuiDB.Scale(13))
				else
					buff:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", TukuiDB.Scale(-8), TukuiDB.Scale(2))
				end
				aboveBuff = buff;
			elseif ( index == 1 ) then
				local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
				if (mainhand and offhand and hand3) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant3, "LEFT", TukuiDB.Scale(-4), 0)
				elseif ((mainhand and offhand) or (mainhand and hand3) or (offhand and hand3)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant2, "LEFT", TukuiDB.Scale(-4), 0)
				elseif ((mainhand and not offhand and not hand3) or (offhand and not mainhand and not hand3) or (hand3 and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
					buff:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-4), 0)
				else
					buff:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", TukuiDB.Scale(-8), TukuiDB.Scale(2))
				end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", TukuiDB.Scale(-4), 0)
			end
			previousBuff = buff
			if index > (rowbuffs*2) then
				buff:Hide()
			else
				buff:Show()
			end
		end		
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local debuff = _G[buttonName..index];
	StyleBuffs(buttonName, index, true)
	local dtype = select(5, UnitDebuff("player",index))      
	local color
	if (dtype ~= nil) then
		color = DebuffTypeColor[dtype]
	else
		color = DebuffTypeColor["none"]
	end
	_G[buttonName..index.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	debuff:ClearAllPoints()
	if index == 1 then
		if TukuiCF["auras"].playershowonlydebuffs == true or TukuiCF["unitframes"].poweroffset == 0 or TukuiCF["classtimer"].enable == true then
			debuff:SetPoint("BOTTOMRIGHT", TukuiMinimap, "BOTTOMLEFT", TukuiDB.Scale(-8), TukuiDB.Scale(0))
		else
			if IsAddOnLoaded("Tukui_Dps_Layout") then
				debuff:SetPoint("BOTTOMRIGHT", oUF_TukzDPS_player, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(11))
			elseif IsAddOnLoaded("Tukui_Heal_Layout") then 
				debuff:SetPoint("BOTTOMRIGHT", oUF_TukzHeal_player, "TOPRIGHT", TukuiDB.Scale(-8), TukuiDB.Scale(11))
			end
		end
	else
		debuff:SetPoint("RIGHT", _G[buttonName..(index-1)], "LEFT", TukuiDB.Scale(-3), TukuiDB.Scale(0))
		if index > rowbuffs then
			debuff:Hide()
		else
			debuff:Show()
		end
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function() mainhand, _, _, offhand = GetWeaponEnchantInfo() end)
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_EVENTERING_WORLD")

hooksecurefunc("AuraButton_OnUpdate", UpdateFlash)
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)

SecondsToTimeAbbrev = function(time)
local hr, m, s, text
	if time <= 0 then text = ""
	elseif(time < 3600 and time > 60) then
		hr = floor(time / 3600)
		m = floor(mod(time, 3600) / 60 + 1)
		text = format("%d"..""..valuecolor.." м.", m)
	elseif(time < 60 and time > 10) then
		m = floor(time / 60)
		s = mod(time, 60)
		text = (m == 0 and format("%d"..valuecolor.." с.", s))
	elseif time < 10 then
		s = mod(time, 60)
		text = (format("%d"..valuecolor.." с.", s))
	else
		hr = floor(time / 3600 + 1)
		text = format("%d"..valuecolor.." ч.", hr)
	end
	text = format("|cffffffff".."%s", text)
	return text
end
