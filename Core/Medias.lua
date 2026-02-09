---@type table
local LSM = LibStub('LibSharedMedia-3.0')

---@type table<string, string>
local mediaPath = {
	statusbar = [[Interface\AddOns\AlomawaniQoL\Medias\Statusbar\]],
	sound = [[Interface\AddOns\AlomawaniQoL\Medias\Sounds\]],
	font = [[Interface\AddOns\AlomawaniQoL\Medias\Font\]],
}

---@param type string
---@param name string
---@param file string
local function AddMedia(type, name, file)
	LSM:Register(type, name, mediaPath[type] .. file)
end

AddMedia('statusbar','AlomawaniQoLOnePixel', 'AlomawaniQoLOnePixel')
AddMedia('sound','|cFF00FF00AlomawaniQoL silence|r', 'silence.ogg')
AddMedia('font','FiraSansCondensed', 'FiraSansCondensed-Medium.ttf')
