if TukuiCF.tooltip.enable ~= true then return end

GameTooltip:HookScript("OnTooltipCleared", function(self) self.TukuiItemTooltip=nil end)
GameTooltip:HookScript("OnTooltipSetItem", function(self)
	if TukuiItemTooltip and not self.TukuiItemTooltip and (TukuiItemTooltip.id or TukuiItemTooltip.count) then
		local item, link = self:GetItem()
		local num = GetItemCount(link)
		local left = ""
		local right = ""
		
		if TukuiItemTooltip.id and link ~= nil then
			left = "|cFFCA3C3CID|r "..link:match(":(%w+)")
		end
		
		if TukuiItemTooltip.count and num > 1 then
			if TukuiCF.tooltip.itemid == true then
				right = "|cFFCA3C3C"..tukuilocal.tooltip_count.."|r "..num
			else
				left = "|cFFCA3C3C"..tukuilocal.tooltip_count.."|r "..num
			end
		end
				
		self:AddLine(" ")
		self:AddDoubleLine(left, right)
		self.TukuiItemTooltip = 1
	end
end)

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, name)
	if name ~= "Tukui" then return end
	f:UnregisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", nil)
	TukuiItemTooltip = TukuiItemTooltip or {count=TukuiCF["tooltip"].count,id=TukuiCF["tooltip"].itemid}
end)