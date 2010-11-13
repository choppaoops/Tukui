--------------------------------------------------------------------
-- MINIMAP BORDER
--------------------------------------------------------------------

local p = CreateFrame("Frame", "TukuiMinimap", Minimap)
TukuiMinimap:RegisterEvent("ADDON_LOADED")

TukuiDB.CreatePanel(p, TukuiDB.Scale(149 + 4), TukuiDB.Scale(149 + 4), "CENTER", Minimap, "CENTER", -0, 0)
TukuiDB.CreateShadow(p)
p:SetFrameLevel(2)
p:ClearAllPoints()
p:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
p:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))

--------------------------------------------------------------------
-- MINIMAP ROUND TO SQUARE AND MINIMAP SETTING
--------------------------------------------------------------------

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-5), TukuiDB.Scale(-7))
Minimap:SetSize(TukuiDB.Scale(149), TukuiDB.Scale(149))

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Game Time
GameTimeFrame:Hide()

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, TukuiDB.Scale(3), TukuiDB.Scale(4))
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMRIGHT", Minimap, TukuiDB.Scale(3), 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TukuiDB.Kill(TimeManagerClockButton)
		--TukuiDB.Kill(InterfaceOptionsDisplayPanelShowClock)
	elseif addon == "Blizzard_FeedbackUI" then
		TukuiDB.Kill(FeedbackUIButton)
	end
end)



if FeedbackUIButton then
	TukuiDB.Kill(FeedbackUIButton)
end

----------------------------------------------------------------------------------------
-- Right click menu
----------------------------------------------------------------------------------------

Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	else
		Minimap_OnClick(self)
	end
end)


-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return 'SQUARE' end

-- reskin LFG dropdown
TukuiDB.SetTemplate(LFDSearchStatus)