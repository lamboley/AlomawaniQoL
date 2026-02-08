local _, AlomawaniQoL = ...

-- Lua API
local select = select

-- WoW API
local IsInInstance = IsInInstance

local Quests = AlomawaniQoL.CreateModule("Quests", "PLAYER_ENTERING_WORLD")

local lastInstanceType = nil

-- One-time setup: hooks are permanent and cannot be removed
function Quests:PreEnable()
	MicroButtonAndBagsBar:UnregisterAllEvents()
	MicroButtonAndBagsBar:HookScript("OnShow", function(s) s:Hide() end)
	MicroButtonAndBagsBar:Hide()
end

function Quests:OnEvent(event, ...)
	ObjectiveTrackerFrame:SetScale(AlomawaniQoLData.Configs["ObjectiveTrackerScale"])

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
