local _, AlomawaniQoL = ...

-- Lua API
local select = select

-- WoW API
local IsInInstance = IsInInstance

local Quests = AlomawaniQoL.CreateModule("Quests", "PLAYER_ENTERING_WORLD")

function Quests:OnEvent(event, ...)
	ObjectiveTrackerFrame:SetScale(AlomawaniQoLData.Configs["ObjectiveTrackerScale"])

	-- CompactRaidFrameManager:UnregisterAllEvents()
	-- CompactRaidFrameManager:HookScript("OnShow", function(s) s:Hide() end)
	-- CompactRaidFrameManager:Hide()

	MicroButtonAndBagsBar:UnregisterAllEvents()
	MicroButtonAndBagsBar:HookScript("OnShow", function(s) s:Hide() end)
	MicroButtonAndBagsBar:Hide()

	local instanceType = select(2, IsInInstance())
	if not instanceType then return end

	if instanceType == 'pvp' or instanceType == 'arena' then
		ObjectiveTrackerFrame:Hide()
	elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
		ObjectiveTrackerFrame:Show()
		ObjectiveTrackerFrame:SetCollapsed(true)
	else
		ObjectiveTrackerFrame:Show()
		ObjectiveTrackerFrame:SetCollapsed(false)
	end
end

AlomawaniQoL.Interface.Quests = Quests
