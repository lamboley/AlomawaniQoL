---@class AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- WoW API
local GetLocale = GetLocale

local L = AlomawaniQoL.L

if GetLocale() == "frFR" then
    L["A /reload may be required to take effect."] = "Un /reload peut être nécessaire pour prendre effet."
end
