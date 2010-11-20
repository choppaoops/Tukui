if not TukuiCF["raidframes"].enable == true then return end

local raid_width
local raid_height

if TukuiCF["raidframes"].griddps ~= true then
	raid_width = TukuiDB.Scale(95)*TukuiCF["raidframes"].scale
	raid_height = TukuiDB.Scale(11)*TukuiCF["raidframes"].scale
else
	raid_width = TukuiDB.Scale(ChatLBackground:GetWidth() / 5) - TukuiDB.Scale(6)
	raid_height = TukuiDB.Scale(21)*TukuiCF["raidframes"].scale
end

local function Shared(self, unit)
	self.colors = TukuiDB.oUF_colors
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	self.menu = TukuiDB.SpawnMenu

	-- an update script to all elements
	self:HookScript("OnShow", TukuiDB.updateAllElements)

	local health = CreateFrame('StatusBar', nil, self)
	health:SetHeight(raid_height)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetStatusBarTexture(TukuiCF["media"].normTex)
	self.Health = health

	health.bg = health:CreateTexture(nil, 'BORDER')
	health.bg:SetAllPoints(health)
	health.bg:SetTexture(TukuiCF["media"].normTex)

	self.Health.bg = health.bg

	health.value = health:CreateFontString(nil, "OVERLAY")
	if TukuiCF["raidframes"].griddps ~= true then
		health.value:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-3), TukuiDB.Scale(1))
	else
		health.value:SetPoint("TOP", health, "TOP", TukuiDB.Scale(1), TukuiDB.Scale(3))
	end
	health.value:SetFont(TukuiCF["media"].font2, TukuiCF["raidframes"].fontsize, "THINOUTLINE")
	health.value:SetTextColor(1,0,0)
	health.value:SetShadowOffset(1, -1)
	self.Health.value = health.value		

	health.PostUpdate = TukuiDB.PostUpdateHealth
	health.frequentUpdates = true

	if TukuiCF.unitframes.classcolor ~= true then
		health.colorClass = false
		health:SetStatusBarColor(unpack(TukuiCF["unitframes"].healthcolor))
		health.bg:SetTexture(unpack(TukuiCF["unitframes"].healthbackdropcolor))
	else
		health.colorClass = true
		health.colorReaction = true		
		health.bg.multiplier = 0.3	
	end
	health.colorDisconnected = false	

	-- border for all frames
	local FrameBorder = CreateFrame("Frame", nil, self)
	FrameBorder:SetPoint("TOPLEFT", self, "TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
	FrameBorder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
	TukuiDB.SetTemplate(FrameBorder)
	TukuiDB.CreateShadow(FrameBorder)
	FrameBorder:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
	FrameBorder:SetFrameLevel(2)
	self.FrameBorder = FrameBorder

	local name = health:CreateFontString(nil, "OVERLAY")
	if TukuiCF["raidframes"].griddps ~= true then
		name:SetPoint("LEFT", health, "LEFT", TukuiDB.Scale(2), TukuiDB.Scale(1))
	else
		name:SetPoint("CENTER", health, "CENTER", TukuiDB.Scale(1), TukuiDB.Scale(1))
	end
	name:SetFont(TukuiCF["media"].font2, TukuiCF["raidframes"].fontsize, "THINOUTLINE")
	name:SetShadowOffset(1, -1)
	name.frequentUpdates = 0.2
	self:Tag(name, "[Tukui:getnamecolor][Tukui:nameshort]")
	self.Name = name

    if TukuiCF["unitframes"].aggro == true then
		table.insert(self.__elements, TukuiDB.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
	end

	if TukuiCF["unitframes"].showsymbols == true then
		local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:SetHeight(TukuiDB.Scale(15)*TukuiCF["raidframes"].scale)
		RaidIcon:SetWidth(TukuiDB.Scale(15)*TukuiCF["raidframes"].scale)
		RaidIcon:SetPoint('LEFT', self.Name, 'RIGHT')
		RaidIcon:SetTexture('Interface\\AddOns\\Tukui\\media\\textures\\raidicons.blp')
		self.RaidIcon = RaidIcon
	end

	local ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetHeight(TukuiCF["raidframes"].fontsize)
	ReadyCheck:SetWidth(TukuiCF["raidframes"].fontsize)
	if TukuiCF["raidframes"].griddps ~= true then
		ReadyCheck:SetPoint('LEFT', self.Name, 'RIGHT', 4, 0)
	else
		ReadyCheck:SetPoint('TOP', self.Name, 'BOTTOM', 0, -2)
	end
	self.ReadyCheck = ReadyCheck

	if TukuiCF["unitframes"].debuffhighlight == true then
		local dbh = health:CreateTexture(nil, "OVERLAY", health)
		dbh:SetAllPoints(health)
		dbh:SetTexture(TukuiCF["media"].normTex)
		dbh:SetBlendMode("ADD")
		dbh:SetVertexColor(0,0,0,0)
		self.DebuffHighlight = dbh
		self.DebuffHighlightFilter = true
		self.DebuffHighlightAlpha = 0.4		
	end

	if TukuiCF["raidframes"].showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = TukuiCF["raidframes"].raidalphaoor}
		self.Range = range
	end

	if TukuiCF["unitframes"].showsmooth == true then
		health.Smooth = true
	end	

	if TukuiCF["auras"].raidunitbuffwatch == true then
		TukuiDB.createAuraWatch(self,unit)
    end

	return self
end

oUF:RegisterStyle('TukuiDPSR26R40', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("TukuiDPSR26R40")	
	local raid
	if TukuiCF["raidframes"].griddps ~= true then
		raid = self:SpawnHeader("oUF_TukuiDPSR26R40", nil, "custom [@raid26,exists] show;hide",
			'oUF-initialConfigFunction', [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute('initial-width'))
				self:SetHeight(header:GetAttribute('initial-height'))
			]],
			'initial-width', raid_width,
			'initial-height', raid_height,	
			"showSolo", false,
			"showRaid", true, 
			"showParty", true,
			"showPlayer", TukuiCF["raidframes"].showplayerinparty,
			"xoffset", TukuiDB.Scale(6),
			"groupFilter", "1,2,3,4,5,6,7,8",
			"groupingOrder", "1,2,3,4,5,6,7,8",
			"groupBy", "GROUP",	
			"yOffset", TukuiDB.Scale(-6)
		)	
		raid:SetPoint("BOTTOMLEFT", chatltabsPanel, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
	else
		raid = self:SpawnHeader("oUF_TukuiDPSR26R40", nil, "custom [@raid26,exists] show;hide",
			'oUF-initialConfigFunction', [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute('initial-width'))
				self:SetHeight(header:GetAttribute('initial-height'))
			]],
			'initial-width', raid_width,
			'initial-height', raid_height,	
			"showRaid", true, 
			"showParty", true,
			"showPlayer", TukuiCF["raidframes"].showplayerinparty,
			"xoffset", TukuiDB.Scale(7),
			"point", "LEFT",
			"groupFilter", "1,2,3,4,5,6,7,8",
			"groupingOrder", "1,2,3,4,5,6,7,8",
			"groupBy", "GROUP",
			"maxColumns", 8,
			"unitsPerColumn", 5,
			"columnSpacing", TukuiDB.Scale(7),
			"columnAnchorPoint", "TOP"		
		)		
		raid:SetPoint("BOTTOMLEFT", chatltabsPanel, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
	end

	local raidToggle = CreateFrame("Frame")
	raidToggle:RegisterEvent("PLAYER_ENTERING_WORLD")
	raidToggle:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	raidToggle:SetScript("OnEvent", function(self, event)
		local inInstance, instanceType = IsInInstance()
		local _, _, _, _, maxPlayers, _, _ = GetInstanceInfo()
		if event == "PLAYER_REGEN_ENABLED" then self:UnregisterEvent("PLAYER_REGEN_ENABLED") end
		if not InCombatLockdown() then
			if inInstance and instanceType == "raid" and maxPlayers ~= 40 then
				oUF_TukuiDPSR26R40:SetAttribute("showRaid", false)
				oUF_TukuiDPSR26R40:SetAttribute("showParty", false)			
			else
				oUF_TukuiDPSR26R40:SetAttribute("showParty", true)
				oUF_TukuiDPSR26R40:SetAttribute("showRaid", true)
			end
		else
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
	end)
end)