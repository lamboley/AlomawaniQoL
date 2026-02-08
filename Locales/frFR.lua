---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- WoW API
local GetLocale = GetLocale

local L = AlomawaniQoL.L

if GetLocale() == "frFR" then
    L["Requires /reload to take effect."] = "Nécessite /reload pour prendre effet."
end
