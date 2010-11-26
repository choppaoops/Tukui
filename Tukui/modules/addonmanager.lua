---------------------------------------------------
-- Author: Fernir
---------------------------------------------------

local loadf = CreateFrame("frame", "aLoadFrame", UIParent)
loadf:SetWidth(400)
loadf:SetHeight(560)
loadf:SetPoint("CENTER")
loadf:EnableMouse(true)
loadf:SetMovable(true)
loadf:SetUserPlaced(true)
loadf:SetClampedToScreen(true)
loadf:SetScript("OnMouseDown", function(self) self:StartMoving() end)
loadf:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing() end)
loadf:SetFrameStrata("DIALOG")
tinsert(UISpecialFrames, "aLoadFrame")

local stylef = function(f)
TukuiDB.SetTemplate(f)
end

local RLButton = function(text,parent)
	local result = CreateFrame("Button", "btn_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

local CloseButton = function(text,parent)
	local result = CreateFrame("Button", "btn2_"..parent:GetName(), parent, "UIPanelButtonTemplate")
	result:SetText(text)
	return result
end

stylef(loadf)
loadf:Hide()
loadf:SetScript("OnHide", function(self) end)

loadf:SetResizable(true)
local resize = CreateFrame("button", "resizebut", loadf)
TukuiDB.SetTemplate(loadf)
loadf:SetBackdropColor(.1,.1,.1)
TukuiDB.CreateShadow(loadf)
loadf:SetMinResize(264, 400)
loadf:SetMaxResize(800, 800)
resize:SetPoint("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -6, 6)
resize:SetWidth(16)
resize:SetHeight(16)
resize:SetNormalTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Up")
resize:SetHighlightTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Highlight")
resize:SetPushedTexture("Interface\\CHATFRAME\\UI-ChatIM-SizeGrabber-Down")

resize:SetScript("OnMouseDown", function(self)   
   loadf:StartSizing()
end)

resize:SetScript("OnMouseUp", function(self)
   loadf:StopMovingOrSizing()
end)

local title = loadf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOPLEFT", 10, -8)
title:SetText(tukuilocal.addon_manager)

local scrollf = CreateFrame("ScrollFrame", "aload_Scroll", loadf, "UIPanelScrollFrameTemplate")
local mainf = CreateFrame("frame", "aloadmainf", scrollf)

scrollf:SetPoint("TOPLEFT", loadf, "TOPLEFT", 10, -30)
scrollf:SetPoint("BOTTOMRIGHT", loadf, "BOTTOMRIGHT", -28, 40)
scrollf:SetScrollChild(mainf)

local reloadb = RLButton(tukuilocal.addon_save, loadf)
reloadb:SetWidth(120)
reloadb:SetHeight(22)
reloadb:SetPoint("BOTTOMRIGHT", loadf, "BOTTOM", -2, 9)
reloadb:SetScript("OnClick", function() ReloadUI() end)

local closeb = CloseButton(CLOSE, loadf)
closeb:SetWidth(120)
closeb:SetHeight(22)
closeb:SetPoint("TOPLEFT" , reloadb, "TOPRIGHT", 4, 0)
closeb:SetScript("OnClick", function() loadf:Hide() end)

local makeList = function()
	local self = mainf
	stylef(scrollf)
   self:SetPoint("TOPLEFT")
   self:SetWidth(scrollf:GetWidth())
   self:SetHeight(scrollf:GetHeight())
	self.addons = {}
	for i=1, GetNumAddOns() do
		self.addons[i] = select(1, GetAddOnInfo(i))
	end
	table.sort(self.addons)

	local oldb

	for i,v in pairs(self.addons) do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(v)

		if name then
			local bf = _G[v.."_cbf"] or CreateFrame("CheckButton", v.."_cbf", self, "OptionsCheckButtonTemplate")
			bf:EnableMouse(true)
			bf.title = title.."|n"
			if notes then bf.title = bf.title.."|cffffffff"..notes.."|r|n" end
			if (GetAddOnDependencies(v)) then
				bf.title = tukuilocal.addon_dep
				for i=1, select("#", GetAddOnDependencies(v)) do
					bf.title = bf.title..select(i,GetAddOnDependencies(v))
					if (i>1) then bf.title=bf.title..", " end
				end
				bf.title = bf.title.."|r"
			end
				
			if i==1 then
				bf:SetPoint("TOPLEFT",self, "TOPLEFT", 10, -10)
			else
				bf:SetPoint("TOP", oldb, "BOTTOM", 0, 6)
			end
			
			bf:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", })
			bf:SetBackdropColor(0,0,0,0)
	
			bf:SetScript("OnEnter", function(self)
				GameTooltip:ClearLines()
				GameTooltip:SetOwner(self, ANCHOR_TOPRIGHT)
				GameTooltip:AddLine(self.title)
				GameTooltip:Show()
			end)
			
			bf:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
			
			bf:SetScript("OnClick", function()
				local _, _, _, enabled = GetAddOnInfo(name)
				if enabled then
					DisableAddOn(name)
				else
					EnableAddOn(name)
				end
			end)
			bf:SetChecked(enabled)
			
			_G[v.."_cbfText"]:SetText(title) 

			oldb = bf
		end
	end
end

makeList()

local showb = CreateFrame("Button", "TukuiShowB", UIParent)
local buttontext = showb:CreateFontString(nil,"OVERLAY",nil)
buttontext:SetFont(TukuiCF.media.font2,TukuiCF["datatext"].fontsize,"OUTLINE")
buttontext:SetText(valuecolor..tukuilocal.addon_manager)
buttontext:SetPoint("CENTER", TukuiDB.Scale(1), 0)
TukuiDB.CreatePanel(showb,buttontext:GetWidth()+TukuiCF["datatext"].panel_width, TukuiDB.Scale(TukuiCF["datatext"].panel_height), "TOPLEFT", UIParent, "TOPLEFT", 5, -7)
TukuiDB.CreateShadow(showb)
showb:SetFrameLevel(2)
showb:EnableMouse(true)
		
showb:HookScript("OnEnter", function(self) showb:SetBackdropBorderColor(unpack(TukuiCF["media"].valuecolor)) end)
showb:HookScript("OnLeave", function(self) showb:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor)) end)
showb:RegisterForClicks("AnyUp") showb:SetScript("OnClick", function() loadf:Show() end)