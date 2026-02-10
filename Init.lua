local AlomawaniQoL = select(2, ...)

-- Local API
local GetAddOnMetadata = C_AddOns.GetAddOnMetadata

AlomawaniQoL.addonName = GetAddOnMetadata("AlomawaniQoL", "Title")

AlomawaniQoL = AlomawaniQoL
