---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local IsInInstance = IsInInstance
local select = select

---@class Quests : table
---@field OnEvent fun(event: string, any)
---@field PreEnable fun()
local Quests = AlomawaniQoL.CreateModule("Quests", "PLAYER_ENTERING_WORLD")

---@type string?
local lastInstanceType = nil

function Quests:PreEnable()
	ObjectiveTrackerFrame:SetScale(AlomawaniQoLData.Configs["ObjectiveTrackerScale"])

	MicroButtonAndBagsBar:UnregisterAllEvents()
	MicroButtonAndBagsBar:HookScript("OnShow", function(s) s:Hide() end)
	MicroButtonAndBagsBar:Hide()
end

function Quests:OnEvent(event, ...)
	local instanceType = select(2, IsInInstance())

	if lastInstanceType ~= instanceType then
		if not instanceType then
			ObjectiveTrackerFrame:Show()
			ObjectiveTrackerFrame:SetCollapsed(false)
		elseif instanceType == 'pvp' or instanceType == 'arena' then
			ObjectiveTrackerFrame:Hide()
		elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
			ObjectiveTrackerFrame:Show()
			ObjectiveTrackerFrame:SetCollapsed(true)
		else
			ObjectiveTrackerFrame:Show()
			ObjectiveTrackerFrame:SetCollapsed(false)
		end

		lastInstanceType = instanceType
	end
end

AlomawaniQoL.Interface.Quests = Quests
