local _, AlomawaniQoL = ...
local Interface = AlomawaniQoL['Interface']

local Quests = CreateFrame('Frame')

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

function Quests:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

Interface.Quests = Quests
