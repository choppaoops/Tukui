-- Mark Bar created by Smelly
-- Credits to Hydra, Elv22, Safturento, and many more!
 
-- Config
font = TukuiCF.media.font2           	-- Font to be used for button text
fontsize = TukuiCF["datatext"].fontsize                     		-- Size of font for button text
buttonwidth = TukuiDB.Scale(30)    -- Width of menu buttons
buttonheight = TukuiDB.Scale(30)   -- Height of menu buttons

--Background Frame
local MarkBarBG = CreateFrame("Frame", "MarkBarBackground", UIParent)
TukuiDB.CreatePanel(MarkBarBG, buttonwidth * 8 + TukuiDB.Scale(27), buttonheight + TukuiDB.Scale(6), "BOTTOMLEFT", ChatLBackground, "BOTTOMRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(-10))
TukuiDB.CreateShadow(MarkBarBG)
MarkBarBG:SetFrameLevel(0)
MarkBarBG:Hide()
 
--Change border when mouse is inside the button
local function ButtonEnter(self) self:SetBackdropBorderColor(unpack(TukuiCF["media"].valuecolor)) end
 
--Change border back to normal when mouse leaves button
local function ButtonLeave(self) self:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor)) end

-- Mark Button BG and icons
icon = CreateFrame("Button", "tmb_Icon", MarkBarBG)
mark = CreateFrame("Button", "tmb_Menu", MarkBarBG)
for i = 1, 8 do
	mark[i] = CreateFrame("Button", "tbm_Mark"..i, MarkBarBG)
	TukuiDB.CreatePanel(mark[i], buttonwidth, buttonheight, "LEFT", MarkBarBG, "LEFT", TukuiDB.Scale(3), 0)
	if i == 1 then
		mark[i]:SetPoint("LEFT", MarkBarBG, "LEFT",  TukuiDB.Scale(3), 0)
	else
		mark[i]:SetPoint("LEFT", mark[i-1], "RIGHT", TukuiDB.Scale(3), 0)
	end
	mark[i]:EnableMouse(true)
	mark[i]:SetScript("OnEnter", ButtonEnter)
	mark[i]:SetScript("OnLeave", ButtonLeave)
	mark[i]:RegisterForClicks("AnyUp")
	
	icon[i] = CreateFrame("Button", "icon"..i, MarkBarBG)
	icon[i]:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	icon[i]:SetSize(25, 25)
	icon[i]:SetPoint("CENTER", mark[i])
	
	-- Set up each button
	if i == 1 then -- Skull
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 8) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
	elseif i == 2 then -- Cross
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 7) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
	elseif i == 3 then -- Square
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 6) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
	elseif i == 4 then -- Moon
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 5) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
	elseif i == 5 then -- Triangle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 4) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
	elseif i == 6 then -- Diamond
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 3) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
	elseif i == 7 then -- Circle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 2) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
	elseif i == 8 then -- Star
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 1) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
	end
end
 
--Create button for when frame is hidden
local HiddenToggleButton = CreateFrame("Button", "tmb_HiddenToggleButton", UIParent)
TukuiDB.CreatePanel(HiddenToggleButton, TukuiDB.Scale(130), TukuiDB.Scale(TukuiCF["datatext"].panel_height), "TOPLEFT", Tukuicubeleft2, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(HiddenToggleButton)
HiddenToggleButton:SetScript("OnEnter", ButtonEnter)
HiddenToggleButton:SetScript("OnLeave", ButtonLeave)
HiddenToggleButton:SetScript("OnMouseUp", function(self)
	MarkBarBackground:Show()
	HiddenToggleButton:Hide()
end)
 
local HiddenToggleButtonText = HiddenToggleButton:CreateFontString("tmb_HiddenToggleButtonText","OVERLAY",HiddenToggleButton)
HiddenToggleButtonText:SetFont(font,fontsize,"OUTLINE")
HiddenToggleButtonText:SetText("raid"..": "..valuecolor..tukuilocal.core_markbar)
HiddenToggleButtonText:SetPoint("CENTER", 1, 0.5)
 
--Create button for when frame is shown
local ShownToggleButton = CreateFrame("Button", "tmb_ShownToggleButton", MarkBarBackground)
TukuiDB.CreatePanel(ShownToggleButton, 18, 18, "BOTTOMLEFT", MarkBarBackground, "TOPLEFT", 0, TukuiDB.Scale(3))
TukuiDB.CreateShadow(ShownToggleButton)
ShownToggleButton:SetScript("OnEnter", ButtonEnter)
ShownToggleButton:SetScript("OnLeave", ButtonLeave)
ShownToggleButton:SetScript("OnMouseUp", function(self)
	MarkBarBackground:Hide()
	RaidUitilityPanel:Hide()
	HiddenToggleButton:Show()
end)
 
local ShownToggleButtonText = ShownToggleButton:CreateFontString("tmb_ShownToggleButtonText","OVERLAY",ShownToggleButton)
ShownToggleButtonText:SetFont(font,fontsize,"OUTLINE")
ShownToggleButtonText:SetText("X")
ShownToggleButtonText:SetPoint("CENTER", ShownToggleButton, "CENTER", 1, 0.5)
 
 -- Create Button for clear target
local ClearTargetButton = CreateFrame("Button", "ClearTargetButton", MarkBarBackground)
TukuiDB.CreatePanel(ClearTargetButton, 77, 18, "LEFT", ShownToggleButton, "RIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(ClearTargetButton)
ClearTargetButton:SetScript("OnEnter", ButtonEnter)
ClearTargetButton:SetScript("OnLeave", ButtonLeave)
ClearTargetButton:SetScript("OnMouseUp", function() SetRaidTarget("target", 0) end)

local ClearTargetButtonText = ClearTargetButton:CreateFontString("ClearTargetButtonText","OVERLAY", ClearTargetButton)
ClearTargetButtonText:SetFont(font,fontsize,"OUTLINE")
ClearTargetButtonText:SetText(tukuilocal.core_markbar_cleartarget)
ClearTargetButtonText:SetPoint("CENTER", 1, 0)
	
------------------------------------------------------------------------
-- Raid utility---------------------------------------------------------
------------------------------------------------------------------------

local panel_height = ((TukuiDB.Scale(5)*4) + (TukuiDB.Scale(20)*4))
 
--Create main frame
local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
TukuiDB.CreatePanel(RaidUtilityPanel, TukuiDB.Scale(166), panel_height, "BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
TukuiDB.CreateShadow(RaidUtilityPanel)
local r,g,b,_ = TukuiCF["media"].backdropcolor
RaidUtilityPanel:Hide()

--Create button for when frame is hidden
local HiddenToggleButton = CreateFrame("Button", HiddenToggleButton, UIParent)
TukuiDB.CreatePanel(HiddenToggleButton, TukuiDB.Scale(RaidUtilityPanel:GetWidth()), 18, "BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", TukuiDB.Scale(0), TukuiDB.Scale(3))
TukuiDB.CreateShadow(HiddenToggleButton)
HiddenToggleButton:SetScript("OnEnter", ButtonEnter)
HiddenToggleButton:SetScript("OnLeave", ButtonLeave)
HiddenToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Show()
	HiddenToggleButton:Hide()
end)

local HiddenToggleButtonText = HiddenToggleButton:CreateFontString(nil,"OVERLAY",HiddenToggleButton)
HiddenToggleButtonText:SetFont(font,fontsize,"OUTLINE")
HiddenToggleButtonText:SetText(tukuilocal.core_raidutil)
HiddenToggleButtonText:SetPoint("CENTER", 1, 0)
 
--Create button for when frame is shown
local ShownToggleButton = CreateFrame("Button", ShownToggleButton, RaidUtilityPanel)
TukuiDB.CreatePanel(ShownToggleButton, TukuiDB.Scale(RaidUtilityPanel:GetWidth()), 18, "BOTTOM", RaidUtilityPanel, "TOP", TukuiDB.Scale(0), TukuiDB.Scale(3))
TukuiDB.CreateShadow(ShownToggleButton)
ShownToggleButton:SetScript("OnEnter", ButtonEnter)
ShownToggleButton:SetScript("OnLeave", ButtonLeave)
ShownToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Hide()
	tmb_HiddenToggleButton:Hide()
	HiddenToggleButton:Show()
	MarkBarBackground:Show()
end)
 
local ShownToggleButtonText = ShownToggleButton:CreateFontString(nil,"OVERLAY",ShownToggleButton)
ShownToggleButtonText:SetFont(font,fontsize,"OUTLINE")
ShownToggleButtonText:SetText(CLOSE)
ShownToggleButtonText:SetPoint("CENTER", TukuiDB.Scale(1), 0)
 
-- Function to create buttons in this module
local function CreateButton(name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
	local b = CreateFrame("Button", name, parent, template)
	b:SetWidth(width)
	b:SetHeight(height)
	b:SetPoint(point, relativeto, point2, xOfs, yOfs)
	b:HookScript("OnEnter", ButtonEnter)
	b:HookScript("OnLeave", ButtonLeave)
	b:EnableMouse(true)
	if text then
		local t = b:CreateFontString(nil,"OVERLAY",b)
		t:SetFont(font,fontsize,"OUTLINE")
		t:SetPoint("CENTER", TukuiDB.Scale(1), 0)
		t:SetText(text)
	elseif texture then
		local t = b:CreateTexture(nil,"OVERLAY",nil)
		t:SetTexture(texture)
		t:SetPoint("TOPLEFT", b, "TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
	end
end
 
--Disband Raid button
CreateButton("DisbandRaidButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, TukuiDB.Scale(18), "TOP", RaidUtilityPanel, "TOP", 0, TukuiDB.Scale(-6), tukuilocal.core_raidutil_disbandgroup, nil)
TukuiDB.SetTemplate(DisbandRaidButton)
DisbandRaidButton:SetScript("OnMouseUp", function(self) StaticPopup_Show("DISBAND_RAID") end)
 
--Role Check button
CreateButton("RoleCheckButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, TukuiDB.Scale(18), "TOP", DisbandRaidButton, "BOTTOM", 0, TukuiDB.Scale(-5), ROLE_POLL, nil)
TukuiDB.SetTemplate(RoleCheckButton)
RoleCheckButton:SetScript("OnMouseUp", function(self) InitiateRolePoll() end)
 
--MainTank Button
CreateButton("MainTankButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - TukuiDB.Scale(2), TukuiDB.Scale(18), "TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-5), tukuilocal.core_raidutil_mt, nil)
TukuiDB.SetTemplate(MainTankButton)
MainTankButton:SetAttribute("type", "maintank")
MainTankButton:SetAttribute("unit", "target")
MainTankButton:SetAttribute("action", "set")
 
--MainAssist Button
CreateButton("MainAssistButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - TukuiDB.Scale(2), TukuiDB.Scale(18), "TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, TukuiDB.Scale(-5), MAIN_ASSIST, nil)
TukuiDB.SetTemplate(MainAssistButton)
MainAssistButton:SetAttribute("type", "mainassist")
MainAssistButton:SetAttribute("unit", "target")
MainAssistButton:SetAttribute("action", "set")
 
--Ready Check button
CreateButton("ReadyCheckButton", RaidUtilityPanel, nil, RoleCheckButton:GetWidth() * 0.75, TukuiDB.Scale(18), "TOPLEFT", MainTankButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-5), READY_CHECK, nil)
TukuiDB.SetTemplate(ReadyCheckButton)
ReadyCheckButton:SetScript("OnMouseUp", function(self) DoReadyCheck() end)
 
--World Marker button
CreateButton("WorldMarkerButton", RaidUtilityPanel, "SecureHandlerClickTemplate", RoleCheckButton:GetWidth() * 0.2, TukuiDB.Scale(18), "TOPRIGHT", MainAssistButton, "BOTTOMRIGHT", TukuiDB.Scale(5), TukuiDB.Scale(-7), nil, "Interface\\RaidFrame\\Raid-WorldPing")
WorldMarkerButton:SetAttribute("_onclick", [=[
 if self:GetChildren():IsShown() then
	self:GetChildren():Hide()
 else
	self:GetChildren():Show()
 end
]=])
 
-- Marker Buttons
local function CreateMarkerButton(name, text, point, relativeto, point2)
	local f = CreateFrame("Button", name, MarkerFrame, "SecureActionButtonTemplate")
	f:SetPoint(point, relativeto, point2, 0, TukuiDB.Scale(-5))
	f:SetWidth(MarkerFrame:GetWidth())
	f:SetHeight((MarkerFrame:GetHeight() / 6) + TukuiDB.Scale(-5))
	f:SetFrameLevel(MarkerFrame:GetFrameLevel() + 1)
	f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
 
	local t = f:CreateFontString(nil,"OVERLAY",f)
	t:SetFont(font,fontsize,"OUTLINE")
	t:SetText(text)
	t:SetPoint("CENTER", TukuiDB.Scale(1), TukuiDB.Scale(1))
 
	f:SetAttribute("type", "macro")
end
 
--Marker Holder Frame
local MarkerFrame = CreateFrame("Frame", "MarkerFrame", WorldMarkerButton)
TukuiDB.SetTemplate(MarkerFrame)
TukuiDB.CreateShadow(MarkerFrame)
MarkerFrame:SetBackdropColor(r,g,b,0.6)
MarkerFrame:SetWidth(RaidUtilityPanel:GetWidth() * 0.4)
MarkerFrame:SetHeight(RaidUtilityPanel:GetHeight()* 1.2)
MarkerFrame:SetPoint("TOPLEFT", RaidUtilityPanel, "TOPRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(0))
MarkerFrame:Hide()
 
--Setup Secure Buttons
CreateMarkerButton("BlueFlare", "|cff519AE8"..tukuilocal.core_raidutil_blue.."|r", "TOPLEFT", MarkerFrame, "TOPLEFT")
BlueFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button1
]])
CreateMarkerButton("GreenFlare", "|cff24B358"..tukuilocal.core_raidutil_green.."|r", "TOPLEFT", BlueFlare, "BOTTOMLEFT")
GreenFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button2
]])
CreateMarkerButton("PurpleFlare", "|cff852096"..tukuilocal.core_raidutil_purple.."|r", "TOPLEFT", GreenFlare, "BOTTOMLEFT")
PurpleFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button3
]])
CreateMarkerButton("RedFlare", "|cffD60629"..tukuilocal.core_raidutil_red.."|r", "TOPLEFT", PurpleFlare, "BOTTOMLEFT")
RedFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button4
]])
CreateMarkerButton("WhiteFlare", tukuilocal.core_raidutil_white, "TOPLEFT", RedFlare, "BOTTOMLEFT")
WhiteFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button5
]])
CreateMarkerButton("ClearFlare", tukuilocal.core_raidutil_clear, "TOPLEFT", WhiteFlare, "BOTTOMLEFT")
ClearFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button6
]])
MarkerFrame:SetHeight(MarkerFrame:GetHeight() + TukuiDB.Scale(4))


--------------------------------------------------------------------
-- Animation functions-------------------------------------------
--------------------------------------------------------------------

-- Set Anim func
local set_anim = function (self,k,x,y)
	self.anim = self:CreateAnimationGroup("Move_In")
	self.anim.in_a = self.anim:CreateAnimation("Translation")
	self.anim.in_a:SetDuration(0)
	self.anim.in_a:SetOrder(1)
	self.anim.in_b = self.anim:CreateAnimation("Translation")
	self.anim.in_b:SetDuration(.3)
	self.anim.in_b:SetOrder(2)
	self.anim.in_b:SetSmoothing("OUT")
	self.anim_o = self:CreateAnimationGroup("Move_Out")
	self.anim_o.b = self.anim_o:CreateAnimation("Translation")
	self.anim_o.b:SetDuration(.3)
	self.anim_o.b:SetOrder(1)
	self.anim_o.b:SetSmoothing("IN")
	self.anim.in_a:SetOffset(x,y)
	self.anim.in_b:SetOffset(-x,-y)
	self.anim_o.b:SetOffset(x,y)
	if k then self.anim_o:SetScript("OnFinished",function() self:Hide() end) end
end
	set_anim(tmb_HiddenToggleButton,true, 0, -60)

	set_anim(MarkBarBackground,true, 320, 0)
	MarkBarBackground:Hide()

	set_anim(HiddenToggleButton,true, 220, 0)
	HiddenToggleButton:Hide()

	set_anim(HiddenToggleButton,true, 220, 0)
	RaidUtilityPanel:Hide()

-- Set Scripts
tmb_HiddenToggleButton:SetScript("OnMouseUp",function()
	MarkBarBackground.anim_o:Stop()
	HiddenToggleButton.anim_o:Stop()
	MarkBarBackground:Show()
	HiddenToggleButton:Show()
	RaidUtilityPanel:Hide()
	HiddenToggleButton.anim:Play()
	MarkBarBackground.anim:Play()
	tmb_HiddenToggleButton.anim_o:Play()
end)
 
tmb_ShownToggleButton:SetScript("OnMouseUp",function()
	MarkBarBackground.anim:Stop()
	MarkBarBackground.anim_o:Play()
	RaidUtilityPanel:Hide()
	HiddenToggleButton.anim_o:Play()
	tmb_HiddenToggleButton:Show()
	tmb_HiddenToggleButton.anim:Play()
end)
