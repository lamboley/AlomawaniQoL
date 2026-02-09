---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

AlomawaniQoL.addonName = GetAddOnMetadata("AlomawaniQoL", "Title")

AlomawaniQoL.colorRGB = {0.376, 0.922, 0.922, 1}
AlomawaniQoL.colorHex = "60EBEB"

AlomawaniQoL.pretty = "|cff" .. AlomawaniQoL.colorHex .. AlomawaniQoL.addonName .. ":|r"

AlomawaniQoL = AlomawaniQoL
