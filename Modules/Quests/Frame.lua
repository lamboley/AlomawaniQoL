local _, AlomawaniUI = ...

local Quests = AlomawaniUI:NewModule('Quests', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		customScaleValue = 1.0 ,
	}
}

function Quests:OnInitialize()
	self.db = AlomawaniUI.db:RegisterNamespace('Quests', defaults)
	self:SetEnabledState(self.db.profile.enabled)
end

function Quests:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Quests:OnDisable()
    self:UnregisterEvent('PLAYER_ENTERING_WORLD')
    self:ToggleOptions()
end

function Quests:ApplyConfig(config)
	if config then
		self.config = config
	end
end

function Quests:PLAYER_ENTERING_WORLD()
	ObjectiveTrackerFrame:SetScale(self.db.profile.customScaleValue)

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