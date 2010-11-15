--BUTTON SIZES
TukuiDB.buttonsize = TukuiDB.Scale(TukuiCF["actionbar"].buttonsize)
TukuiDB.buttonspacing = TukuiDB.Scale(TukuiCF["actionbar"].buttonspacing)
TukuiDB.petbuttonsize = TukuiDB.Scale(TukuiCF["actionbar"].petbuttonsize)
TukuiDB.petbuttonspacing = TukuiDB.Scale(TukuiCF["actionbar"].petbuttonspacing)

local stats_height = TukuiDB.Scale(20)
local stats_width = TukuiDB.Scale(14)

--BOTTOM FRAME
local bottompanel = CreateFrame("Frame", "TukuiBottomPanel", UIParent)
TukuiDB.CreatePanel(bottompanel, UIParent:GetWidth() + (TukuiDB.mult * 2), stats_height, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", -TukuiDB.mult, -TukuiDB.mult)
bottompanel:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.mult, -TukuiDB.mult)
TukuiDB.CreateShadow(bottompanel)
bottompanel:SetFrameLevel(0)

local dataleftp = CreateFrame("Frame", "TukuiDataLeftPanel", UIParent)
TukuiDB.CreatePanel(dataleftp, TukuiCF["chat"].chatwidth-22, stats_height, "LEFT", bottompanel, "TOPLEFT", TukuiDB.Scale(18), TukuiDB.Scale(0))
TukuiDB.CreateShadow(dataleftp)
dataleftp:SetFrameLevel(2)

local datarightp = CreateFrame("Frame", "TukuiDataRightPanel", UIParent)
TukuiDB.CreatePanel(datarightp, TukuiCF["chat"].chatwidth-22, stats_height, "RIGHT", bottompanel, "TOPRIGHT", TukuiDB.Scale(-18), TukuiDB.Scale(0))
TukuiDB.CreateShadow(datarightp)
datarightp:SetFrameLevel(2)

-- Top stats panel
local topstats = CreateFrame("Frame", "Tukuitopstats", UIParent)
TukuiDB.CreatePanel(topstats, 320, stats_height, "TOP", UIParent, "TOP", 0, -7)
TukuiDB.CreateShadow(topstats)
topstats:SetFrameLevel(2)

-- Minimap Time
local minimaptime = CreateFrame("Frame", "Tukuiminimaptime", UIParent)
TukuiDB.CreatePanel(minimaptime, TukuiMinimap:GetWidth()-78, 18, "TOP", TukuiMinimap, "BOTTOM", TukuiDB.Scale(0), -TukuiDB.Scale(3))
TukuiDB.CreateShadow(minimaptime)
minimaptime:SetFrameLevel(2)

-- MAIN ACTION BAR
local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
if TukuiCF["actionbar"].bottompetbar ~= true then
	TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(8))
else
	TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, (TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2)) + TukuiDB.Scale(8))
end
barbg:SetWidth(((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13)))
barbg:SetFrameLevel(bottompanel:GetFrameLevel() + 2)
barbg:SetFrameStrata("LOW")
TukuiDB.CreateShadow(barbg)
if TukuiCF["actionbar"].bottomrows == 2 then
	barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
else
	barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
end

barbg.shadow:SetFrameStrata("BACKGROUND")
barbg.shadow:SetFrameLevel(bottompanel:GetFrameLevel())

-- VEHICLE BAR
local vbarbg = CreateFrame("Frame", "TukuiVehicleBarBackground", UIParent)
TukuiDB.CreatePanel(vbarbg, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(4))
vbarbg:SetWidth(((TukuiDB.buttonsize * 11) + (TukuiDB.buttonspacing * 12))*1.2)
vbarbg:SetHeight((TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))*1.2)
vbarbg:SetFrameLevel(bottompanel:GetFrameLevel() + 2)
vbarbg:SetFrameStrata("LOW")
TukuiDB.CreateShadow(vbarbg)
vbarbg.shadow:SetFrameStrata("BACKGROUND")
vbarbg.shadow:SetFrameLevel(bottompanel:GetFrameLevel())

--SPLIT BAR PANELS
if TukuiCF["actionbar"].splitbar == true then
	local splitleft = CreateFrame("Frame", "TukuiSplitActionBarLeftBackground", TukuiActionBarBackground)
	TukuiDB.CreatePanel(splitleft, (TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4), TukuiActionBarBackground:GetHeight(), "RIGHT", TukuiActionBarBackground, "LEFT", TukuiDB.Scale(-4), 0)
	splitleft:SetFrameLevel(TukuiActionBarBackground:GetFrameLevel())
	splitleft:SetFrameStrata(TukuiActionBarBackground:GetFrameStrata())
	TukuiDB.CreateShadow(splitleft)
	
	local splitright = CreateFrame("Frame", "TukuiSplitActionBarRightBackground", TukuiActionBarBackground)
	TukuiDB.CreatePanel(splitright, (TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4), TukuiActionBarBackground:GetHeight(), "LEFT", TukuiActionBarBackground, "RIGHT", TukuiDB.Scale(4), 0)
	splitright:SetFrameLevel(TukuiActionBarBackground:GetFrameLevel())
	splitright:SetFrameStrata(TukuiActionBarBackground:GetFrameStrata())
	TukuiDB.CreateShadow(splitright)

	splitleft.shadow:SetFrameStrata("BACKGROUND")
	splitleft.shadow:SetFrameLevel(bottompanel:GetFrameLevel())

	splitright.shadow:SetFrameStrata("BACKGROUND")
	splitright.shadow:SetFrameLevel(bottompanel:GetFrameLevel())
end

-- RIGHT BAR
if TukuiCF["actionbar"].enable == true then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", TukuiActionBarBackground)
	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(-8))
	TukuiDB.CreateShadow(barbgr)
	if TukuiCF["actionbar"].rightbars == 1 then
		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].rightbars == 2 then
		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif TukuiCF["actionbar"].rightbars == 3 then
		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		barbgr:Hide()
	end

	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
	if TukuiCF["actionbar"].bottompetbar ~= true then
		if TukuiCF["actionbar"].rightbars > 0 then
			TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
		else
			TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
		end
	else
		TukuiDB.CreatePanel(petbg, (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(4))
		petbg:SetFrameLevel(bottompanel:GetFrameLevel() + 3)
	end
	
	local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
	if TukuiCF["actionbar"].bottompetbar ~= true then
		TukuiDB.CreateFadedPanel(ltpetbg1, 30, 265, "LEFT", petbg, "RIGHT", 0, 0)
	else
		TukuiDB.CreateFadedPanel(ltpetbg1, 265, 30, "BOTTOM", petbg, "TOP", 0, 0)
	end
	TukuiDB.CreateShadow(ltpetbg1)
	ltpetbg1:SetFrameLevel(0)

	barbgr.shadow:SetFrameStrata("BACKGROUND")
	barbgr.shadow:SetFrameLevel(bottompanel:GetFrameLevel())

	TukuiDB.CreateShadow(petbg)
	petbg.shadow:SetFrameStrata("BACKGROUND")
	petbg.shadow:SetFrameLevel(bottompanel:GetFrameLevel())
end

-- CHAT BACKGROUND LEFT
local chatlbgdummy = CreateFrame("Frame", "ChatLBackground", UIParent)
TukuiDB.CreateFadedPanel(chatlbgdummy, TukuiCF["chat"].chatwidth+4, TukuiCF["chat"].chatheight+4, "BOTTOMLEFT", dataleftp, "TOPLEFT", TukuiDB.Scale(-13),  TukuiDB.Scale(3))
TukuiDB.CreateShadow(chatlbgdummy)

local chatltabs = CreateFrame("Frame", "chatltabsPanel", UIParent)
TukuiDB.CreatePanel(chatltabs, TukuiCF["chat"].chatwidth-19, stats_height, "BOTTOMLEFT", chatlbgdummy, "TOPLEFT", TukuiDB.Scale(0),  TukuiDB.Scale(3))
TukuiDB.CreateShadow(chatltabs)

--Create Template frame for addon embedding
local rdummyframe = CreateFrame("Frame", "RDummyFrame", UIParent)
rdummyframe:SetWidth(TukuiCF["chat"].chatwidth+4)
rdummyframe:SetHeight(TukuiCF["chat"].chatheight+4)
rdummyframe:SetPoint("BOTTOMRIGHT", datarightp, "TOPRIGHT", TukuiDB.Scale(13),  TukuiDB.Scale(3))
if  TukuiCF["general"].embedright ==  "Skada" and IsAddOnLoaded("Skada") and SkadaBarWindowSkada then
TukuiDB.CreateShadow(rdummyframe)
end

TukuiDB.ChatRightShown = false
local chatrbg = CreateFrame("Frame", "ChatRBG", GeneralDockManager)
chatrbg:SetAllPoints(rdummyframe)
TukuiDB.SetTemplate(chatrbg)
TukuiDB.CreateShadow(chatrbg)
chatrbg:SetFrameStrata("BACKGROUND")
chatrbg:SetFrameLevel(0)
chatrbg:SetBackdropColor(unpack(TukuiCF["media"].backdropfadecolor))
chatrbg:SetAlpha(0)

local chatrtabs = CreateFrame("Frame", "chatrtabsPanel", chatrbg)
TukuiDB.CreatePanel(chatrtabs, TukuiCF["chat"].chatwidth-19, stats_height, "BOTTOMLEFT", chatrbg, "TOPLEFT", TukuiDB.Scale(0),  TukuiDB.Scale(3))
TukuiDB.CreateShadow(chatrtabs)

-- Top bar from Eclipse edit
local topbar = CreateFrame("Frame", "TukuiTopBar", UIParent)
TukuiDB.CreatePanel(topbar, UIParent:GetWidth()*1.64, 22, "TOP", UIParent, "TOP", 0, 5)
topbar:SetFrameLevel(0)
TukuiDB.CreateShadow(topbar)
 
-- Location panel from Eclipse edit
local locationbar = CreateFrame("Frame", "TukuiLocationPanel", UIParent)
TukuiDB.CreatePanel(locationbar, stats_width+54, stats_height, "TOP", topstats, "BOTTOM", 0, -10)
TukuiDB.CreateShadow(locationbar)
locationbar:SetFrameLevel(2)

-- Coords line (left)
local topp = CreateFrame("Frame", "Tukuitopp", UIParent)
TukuiDB.CreatePanel(topp, 1, stats_height-9, "BOTTOM", locationbar, "TOPLEFT", 8, 0)
TukuiDB.CreateShadow(topp)
topp:SetFrameLevel(0)

-- Coords line (right)
local topp2 = CreateFrame("Frame", "Tukuitopp2", UIParent)
TukuiDB.CreatePanel(topp2, 1, stats_height-9, "BOTTOM", locationbar, "TOPRIGHT", -8, 0)
TukuiDB.CreateShadow(topp2)
topp2:SetFrameLevel(0)

-- Coord panel from Eclipse edit
if TukuiCF["datatext"].location_coords == true then
	local coords1 = CreateFrame("Frame", "TukuiXCoordsPanel", UIParent)
	TukuiDB.CreatePanel(coords1, stats_width+19, stats_height, "RIGHT", locationbar, "LEFT", -TukuiDB.Scale(3), 0)
	TukuiDB.CreateShadow(coords1)
	coords1:SetFrameLevel(2)
	 
	local coords2 = CreateFrame("Frame", "TukuiYCoordsPanel", UIParent)
	TukuiDB.CreatePanel(coords2, stats_width+19, stats_height, "LEFT", locationbar, "RIGHT", TukuiDB.Scale(3), 0)
	TukuiDB.CreateShadow(coords2)
	coords2:SetFrameLevel(2)
end

--List for Menu button
local menuFrame = CreateFrame("Frame", "MenuButtonText", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
    {text = ACHIEVEMENTS_GUILD_TAB,
    func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
}

-- Menu Button
local bmenu = CreateFrame("Button", "TukuiMButton", UIParent)
local buttontext = bmenu:CreateFontString(nil,"OVERLAY",nil)
buttontext:SetFont(TukuiCF.media.font2,TukuiCF["datatext"].fontsize,"OUTLINE")
buttontext:SetText(valuecolor..tukuilocal.datatext_micromenu)
buttontext:SetPoint("CENTER", TukuiDB.Scale(1), 0)
TukuiDB.CreatePanel(bmenu, buttontext:GetWidth()+stats_width, stats_height, "TOPLEFT", TukuiShowB, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(bmenu)
bmenu:SetFrameLevel(2)
bmenu:EnableMouse(true)
		
bmenu:HookScript("OnEnter", function(self)
	bmenu:SetBackdropBorderColor(unpack(TukuiCF["media"].valuecolor)) end)
bmenu:HookScript("OnLeave", function(self)
	bmenu:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor)) end)
bmenu:RegisterForClicks("AnyUp")
	bmenu:SetScript("OnClick", function()
	EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
end)

-- Reload UI Button
local rlui = CreateFrame("Button", "Tukuirlui", UIParent)
local buttontext = rlui:CreateFontString(nil,"OVERLAY",nil)
buttontext:SetFont(TukuiCF.media.font2,TukuiCF["datatext"].fontsize,"OUTLINE")
buttontext:SetText(valuecolor.."RL")
buttontext:SetPoint("CENTER", TukuiDB.Scale(2), 0)
TukuiDB.CreatePanel(rlui, buttontext:GetWidth()+stats_width, stats_height, "TOPLEFT", bmenu, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(rlui)
rlui:SetFrameLevel(2)
rlui:EnableMouse(true)
		
rlui:HookScript("OnEnter", function(self)
	rlui:SetBackdropBorderColor(unpack(TukuiCF["media"].valuecolor)) end)
rlui:HookScript("OnLeave", function(self)
	rlui:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor)) end)
rlui:RegisterForClicks("AnyUp")
	rlui:SetScript("OnClick", function()
	ReloadUI()
end)

-- Battle.net
local battlenet = CreateFrame("Frame", "Tukuibattlenet", UIParent)
TukuiDB.CreatePanel(battlenet, 43, 43, "TOPLEFT", TukuiShowB, "BOTTOMLEFT", 0, -6)
TukuiDB.CreateShadow(battlenet)
battlenet:SetFrameLevel(2)
battlenet:SetBackdrop({
bgFile = TukuiCF["media"].battlenet, 
edgeFile = TukuiCF["media"].blank, 
tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult}
})
battlenet:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))

local battlenettopstat = CreateFrame("Frame", "Tukuibattlenettopstat", UIParent)
TukuiDB.CreatePanel(battlenettopstat, TukuiShowB:GetWidth()+TukuiMButton:GetWidth()+Tukuirlui:GetWidth()-40, stats_height, "TOPLEFT", battlenet, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(battlenettopstat)
battlenettopstat:SetFrameLevel(2)

local battlenetbottomstat = CreateFrame("Frame", "Tukuibattlenetbottomstat", UIParent)
TukuiDB.CreatePanel(battlenetbottomstat, TukuiShowB:GetWidth()+TukuiMButton:GetWidth()+Tukuirlui:GetWidth()-40, stats_height, "BOTTOMLEFT", battlenet, "BOTTOMRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(battlenetbottomstat)
battlenetbottomstat:SetFrameLevel(2)

-- Gold Panel
local goldp = CreateFrame("Frame", "Tukuigoldp", UIParent)
TukuiDB.CreatePanel(goldp, 43, 43, "TOPLEFT", battlenet, "BOTTOMLEFT", 0, -7)
TukuiDB.CreateShadow(goldp)
goldp:SetFrameLevel(2)
goldp:SetBackdrop({
bgFile = TukuiCF["media"].gold, 
edgeFile = TukuiCF["media"].blank, 
tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
insets = { left = -TukuiDB.mult, right = -TukuiDB.mult, top = -TukuiDB.mult, bottom = -TukuiDB.mult}
})
goldp:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))

local goldtopstat = CreateFrame("Frame", "Tukuigoldtopstat", UIParent)
TukuiDB.CreatePanel(goldtopstat, TukuiShowB:GetWidth()+TukuiMButton:GetWidth()+Tukuirlui:GetWidth()-40, stats_height, "TOPLEFT", goldp, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(goldtopstat)
goldtopstat:SetFrameLevel(2)

local goldbottomstat = CreateFrame("Frame", "Tukuigoldbottomstat", UIParent)
TukuiDB.CreatePanel(goldbottomstat, TukuiShowB:GetWidth()+TukuiMButton:GetWidth()+Tukuirlui:GetWidth()-40, stats_height, "BOTTOMLEFT", goldp, "BOTTOMRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(goldbottomstat)
goldbottomstat:SetFrameLevel(2)

-- Time left
local timeleft = CreateFrame("Frame", "Tukuitimeleft", UIParent)
TukuiDB.CreatePanel(timeleft, 36, 18, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", TukuiDB.Scale(0), -TukuiDB.Scale(3))
TukuiDB.CreateShadow(timeleft)
timeleft:SetFrameLevel(2)
timeleft:SetBackdrop({
bgFile = TukuiCF["media"].timeleft, 
edgeFile = TukuiCF["media"].blank, 
tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
insets = { left = TukuiDB.mult, right = TukuiDB.mult, top = TukuiDB.mult, bottom = TukuiDB.mult}
})
timeleft:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))

-- Time right
local timeright = CreateFrame("Frame", "Tukuitimeright", UIParent)
TukuiDB.CreatePanel(timeright, 36, 18, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", TukuiDB.Scale(0), -TukuiDB.Scale(3))
TukuiDB.CreateShadow(timeright)
timeright:SetFrameLevel(2)
timeright:SetBackdrop({
bgFile = TukuiCF["media"].timeright, 
edgeFile = TukuiCF["media"].blank, 
tile = false, tileSize = 0, edgeSize = TukuiDB.mult, 
insets = { left = TukuiDB.mult, right = TukuiDB.mult, top = TukuiDB.mult, bottom = TukuiDB.mult}
})
timeright:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))

-- Cube left (dataleft)
local cubeleft = CreateFrame("Frame", "Tukuicubeleft", UIParent)
TukuiDB.CreatePanel(cubeleft, 10, stats_height, "TOPRIGHT", dataleftp, "TOPLEFT", -TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cubeleft)
cubeleft:SetFrameLevel(2)

-- Cube2 left (dataleft)
local cubeleft2 = CreateFrame("Frame", "Tukuicubeleft2", UIParent)
TukuiDB.CreatePanel(cubeleft2, 10, stats_height, "TOPLEFT", dataleftp, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cubeleft2)
cubeleft2:SetFrameLevel(2)

-- Cube right (dataright)
local cuberight = CreateFrame("Frame", "Tukuicuberight", UIParent)
TukuiDB.CreatePanel(cuberight, 10, stats_height, "TOPRIGHT", datarightp, "TOPLEFT", -TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cuberight)
cuberight:SetFrameLevel(2)

-- Cube right (dataright)
local cuberight2 = CreateFrame("Frame", "Tukuicuberight2", UIParent)
TukuiDB.CreatePanel(cuberight2, 10, stats_height, "TOPLEFT", datarightp, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cuberight2)
cuberight2:SetFrameLevel(2)

-- Cube left (Topstats)
local cubestatsl = CreateFrame("Frame", "Tukuicubestatsl", UIParent)
TukuiDB.CreatePanel(cubestatsl, 10, stats_height, "TOPRIGHT", topstats, "TOPLEFT", -TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cubestatsl)
cubestatsl:SetFrameLevel(2)

-- Cube right (Topstats)
local cubestatsr = CreateFrame("Frame", "Tukuicubestatsr", UIParent)
TukuiDB.CreatePanel(cubestatsr, 10, stats_height, "TOPLEFT", topstats, "TOPRIGHT", TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(cubestatsr)
cubestatsr:SetFrameLevel(2)

-- Line Currency - Battle.net
local linegf = CreateFrame("Frame", "Tukuilinegf", UIParent)
TukuiDB.CreateFadedPanel(linegf, Tukuibattlenet:GetWidth()+Tukuibattlenettopstat:GetWidth()+3-20, 13, "TOPLEFT", battlenet, "BOTTOMLEFT", 10, TukuiDB.Scale(3))
TukuiDB.CreateShadow(linegf)
linegf:SetFrameLevel(0)

-- Minimap line (left)
local mlineleft = CreateFrame("Frame", "Tukuitopp", UIParent)
TukuiDB.CreatePanel(mlineleft, 1, stats_height-9, "TOP", timeleft, "BOTTOM", 0, 1)
TukuiDB.CreateShadow(mlineleft)
mlineleft:SetFrameLevel(0)

-- Minimap line (right)
local mlineright = CreateFrame("Frame", "Tukuitopp2", UIParent)
TukuiDB.CreatePanel(mlineright, 1, stats_height-9, "TOP", timeright, "BOTTOM", 0, 1)
TukuiDB.CreateShadow(mlineright)
mlineright:SetFrameLevel(0)

-- Class config, VuhDo buff frame
if TukuiDB.myname == "Веллиара" then
local vuhdoframe = CreateFrame("Frame", "TukuiVuhDoFrame", UIParent)
TukuiDB.CreatePanel(vuhdoframe, 120, TukuiCF["chat"].chatheight+TukuiDB.Scale(50), "RIGHT", rdummyframe, "LEFT", -TukuiDB.Scale(3), 0)
TukuiDB.CreateShadow(vuhdoframe)
vuhdoframe:SetFrameLevel(2)
end
