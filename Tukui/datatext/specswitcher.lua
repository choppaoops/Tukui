--------------------------------------------------------------------
-- spec switcher
-- by sortokk
--------------------------------------------------------------------
 
if TukuiCF["datatext"].specswitcher and TukuiCF["datatext"].specswitcher > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
 
	local Text  = TukuiDataLeftPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font2, TukuiCF["datatext"].fontsize, "THINOUTLINE")
	TukuiDB.PP(TukuiCF["datatext"].specswitcher, Text)
 
	local int = 1
	local function Update(self, t)
		if not GetPrimaryTalentTree() then
			Text:SetText(valuecolor..tukuilocal.datatext_notalents) 
		return end
		int = int - t
		if int < 0 then
			local tree1num = select(5,GetTalentTabInfo(1))
			local tree2num = select(5,GetTalentTabInfo(2))
			local tree3num = select(5,GetTalentTabInfo(3))
			local majorTree = GetPrimaryTalentTree()
			Text:SetText(select(2,GetTalentTabInfo(majorTree))..": "..valuecolor..tree1num.."/"..tree2num.."/"..tree3num)
		end
	end
 
	local function OnEvent(self, event, ...)
		if event == "PLAYER_LOGIN" then
			self:UnregisterEvent("PLAYER_LOGIN")
		end
 
		local c = GetActiveTalentGroup(false,false)
		local group1tree1 = select(5,GetTalentTabInfo(1,false,false,1))
		local group1tree2 = select(5,GetTalentTabInfo(2,false,false,1))
		local group1tree3 = select(5,GetTalentTabInfo(3,false,false,1))
		local majorTree1 = GetPrimaryTalentTree(false,false,1)
		local hs = (GetNumTalentGroups() == 2 and GetPrimaryTalentTree(false,false,2))
		local group2tree1 = hs and select(5,GetTalentTabInfo(1,false,false,2))
		local group2tree2 = hs and select(5,GetTalentTabInfo(2,false,false,2))
		local group2tree3 = hs and select(5,GetTalentTabInfo(3,false,false,2))
		local majorTree2 = 0
		if hs then
			majorTree2 = GetPrimaryTalentTree(false,false,2)
		end
 
		-- Setup Talents Tooltip
		self:SetAllPoints(Text)
 
		self:SetScript("OnEnter", function(self)
			if not InCombatLockdown() then
				self.hovered = true
				GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
				GameTooltip:ClearLines()
 
				if(not GetPrimaryTalentTree()) then
					GameTooltip:AddLine(valuecolor..tukuilocal.datatext_notalents)
				elseif(hs) then
					GameTooltip:AddLine(valuecolor..(c == 1 and "* " or "  ") .. "|r" .. select(2,GetTalentTabInfo(majorTree1))..": "..valuecolor..group1tree1.."/"..group1tree2.."/"..group1tree3,1,1,1)
					GameTooltip:AddLine(valuecolor..(c == 2 and "* " or "  ") .. "|r" .. select(2,GetTalentTabInfo(majorTree2))..": "..valuecolor..group2tree1.."/"..group2tree2.."/"..group2tree3,1,1,1)
				else
					GameTooltip:AddLine(select(2,GetTalentTabInfo(majorTree1))..": "..valuecolor..group1tree1.."/"..group1tree2.."/"..group1tree3,1,1,1)
				end
 
				GameTooltip:Show()
			end
 
		end)
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
 
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnUpdate", Update)
	Stat:SetScript("OnMouseDown", function()
		c = GetActiveTalentGroup(false,false)
		SetActiveTalentGroup(c == 1 and 2 or 1)
	end)
end