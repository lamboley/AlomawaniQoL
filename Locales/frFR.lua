local _, AlomawaniQoL = ...

-- WoW API
local GetLocale = GetLocale

local L = AlomawaniQoL.L

if GetLocale() == "frFR" then
    L["Hello"] = "Bonjour"
end
