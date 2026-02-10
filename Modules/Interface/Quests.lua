---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local IsInInstance = IsInInstance
local select = select

---@type Interface
local Interface = AlomawaniQoL.Interface

---@class Quests : Frame
---@field OnEvent fun(self: Quests, event: WowEvent, ...: any)
---@field Enable fun(self: Quests)
local Quests = CreateFrame("Frame")

---@type string?
local lastInstanceType = nil

---@param event WowEvent
---@param ... any
function Quests:OnEvent(event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
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
end

function Quests:Enable()
	ObjectiveTrackerFrame:SetScale(AlomawaniQoLData.Configs["ObjectiveTrackerScale"])

	MicroButtonAndBagsBar:UnregisterAllEvents()
	MicroButtonAndBagsBar:HookScript("OnShow", function(s) s:Hide() end)
	MicroButtonAndBagsBar:Hide()

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnEvent", self.OnEvent)
end

Interface.Quests = Quests
