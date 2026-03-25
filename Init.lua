---@type string
local addonName = ...

---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetAddOnMetadata = C_AddOns.GetAddOnMetadata
local _G = _G

AlomawaniQoL.addonName = GetAddOnMetadata("AlomawaniQoL", "Title")

_G[addonName] = AlomawaniQoL