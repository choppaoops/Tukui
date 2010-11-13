-- This file is used for enGB or enUS client only.
-- translate or do anything you want if you want to 
-- use this feature on others clients.

----------------------------------------------------------------------------------
-- Trade Chat Stuff
----------------------------------------------------------------------------------
local SpamList = {
	";Powerlevel",
	"recruiting",
	"Discount",
	"discount",
	"золото",
	"голд",
	"золотишко",
	"блестяшки",
	"монетки",
	"Блестяшkи",
}
local function TRADE_FILTER(self, event, arg1)
	if (SpamList and SpamList[1]) then
		for i, SpamList in pairs(SpamList) do
			if (strfind(arg1, SpamList)) then
				return true
			end
		end
	end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", TRADE_FILTER)

----------------------------------------------------------------------------------
-- Hide annoying chat text when talent switch.
----------------------------------------------------------------------------------

local function SPELL_FILTER(self, event, arg1)
    if strfind(arg1,tukuilocal.chat_unlearn) or strfind(arg1,tukuilocal.chat_learn) or strfind(arg1,tukuilocal.chat_ability) or strfind(arg1,tukuilocal.chat_petunlearn) or strfind(arg1,tukuilocal.chat_petlearn) then
        return true
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", SPELL_FILTER)

----------------------------------------------------------------------------------
-- Hide annoying /sleep commands from goldspammer 
-- with their hacks for multiple chars.
----------------------------------------------------------------------------------

local function FUCKYOU_GOLDSPAMMERS(self, event, arg1)
    if strfind(arg1, tukuilocal.chat_sleepspam) then
		return true
    end
end

local function GOLDSPAM_FILTER()
	if GetMinimapZoneText() == tukuilocal.chat_valleyofstrength or GetMinimapZoneText() == tukuilocal.chat_tradedistrict then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_TEXT_EMOTE", FUCKYOU_GOLDSPAMMERS)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_TEXT_EMOTE", FUCKYOU_GOLDSPAMMERS)
	end
end

local GOLDSPAM = CreateFrame("Frame")
GOLDSPAM:RegisterEvent("PLAYER_ENTERING_WORLD")
GOLDSPAM:RegisterEvent("ZONE_CHANGED_INDOORS")
GOLDSPAM:RegisterEvent("ZONE_CHANGED_NEW_AREA")
GOLDSPAM:SetScript("OnEvent", GOLDSPAM_FILTER)

----------------------------------------------------------------------------------
-- Report AFKer's to RaidWarning
----------------------------------------------------------------------------------

local function SPELL_FILTER(self, event, arg1)
    if strfind(arg1,tukuilocal.chat_notready) or strfind(arg1,tukuilocal.chat_away) then
        SendChatMessage(arg1, "RAID_WARNING", nil ,nil)
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", SPELL_FILTER)