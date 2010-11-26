TukuiCF["media"] = {
	-- fonts
	["font"] = [=[Interface\Addons\Tukui\media\fonts\normal_font.ttf]=], -- general font of tukui
	["font2"] = [=[Interface\Addons\Tukui\media\fonts\visitor_rus.ttf]=],
	["dmgfont"] = [[Interface\AddOns\Tukui\media\fonts\combat.ttf]], -- general font of dmg / sct
	
	-- fonts (TAIWAN ONLY)
	["tw_font"] = [=[fonts\bLEI00D.ttf]=], -- general font of tukui
	["tw_font2"] = [[fonts\bLEI00D.ttf]], -- general font of unitframes
	["tw_dmgfont"] = [[fonts\bLEI00D.ttf]], -- general font of dmg / sct
	
	-- fonts (KOREAN ONLY)
	["kr_font"] = [=[Fonts\2002.TTF]=], -- general font of tukui
	["kr_font2"] = [[Fonts\2002.TTF]], -- general font of unitframes
	["kr_dmgfont"] = [[Fonts\2002.TTF]], -- general font of dmg / sct
	
	-- textures
	["normTex"] = [[Interface\AddOns\Tukui\media\textures\normTex]], -- texture used for tukui healthbar/powerbar/etc
	["gold"] = [[Interface\AddOns\Tukui\media\textures\gold]],
	["timeleft"] = [[Interface\AddOns\Tukui\media\textures\timeleft]],
	["timeright"] = [[Interface\AddOns\Tukui\media\textures\timeright]],
	["battlenet"] = [[Interface\AddOns\Tukui\media\textures\battlenet]],
	["glowTex"] = [[Interface\AddOns\Tukui\media\textures\glowTex]], -- the glow text around some frame.
	["blank"] = [[Interface\AddOns\Tukui\media\textures\blank]], -- the main texture for all borders/panels
	["bordercolor"] = { .125,.125,.125,1 }, -- border color of tukui panels
	["altbordercolor"] = { .125,.125,.125,1 }, -- alternative border color, mainly for unitframes text panels.
	["backdropcolor"] = { .150,.150,.150,1 }, -- background color of tukui panels
	["backdropfadecolor"] = { .06,.06,.06,0.8 }, --this is always the same as the backdrop color with an alpha of 0.8, see colors.lua
	["valuecolor"] = {0,0.6,1}, -- color for values of datatexts, classcolor must be off
	["raidicons"] = [[Interface\AddOns\Tukui\media\textures\raidicons.blp]], -- new raid icon textures by hankthetank
	
	-- sound
	["whisper"] = [[Interface\AddOns\Tukui\media\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\Tukui\media\sounds\warning.mp3]],
}