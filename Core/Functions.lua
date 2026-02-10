---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local CreateFrame = CreateFrame
local print = print

---@param ... any
function AlomawaniQoL:Print(...)
	print("|cff7EFF68" .. AlomawaniQoL.addonName .. ":|r", ...)
end

---@param ... any
function AlomawaniQoL.Debug(...)
	if AlomawaniQoLData.Configs["Debug"] then
		print("|cff7EFF68" .. AlomawaniQoL.addonName .. ":|r" .. " |cffffff00[DEBUG]|r", ...)
	end
end
