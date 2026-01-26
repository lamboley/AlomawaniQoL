local _, AlomawaniQoL = ...

-- WoW API
local CreateFrame = CreateFrame

local Events = CreateFrame("Frame")
Events:RegisterEvent("ADDON_LOADED")
Events:RegisterEvent("PLAYER_LOGIN")
Events:SetScript("OnEvent", function(_, event, ...)
	if (event == "ADDON_LOADED") then
        local name = ...
        if name == "AlomawaniQoL" then
            if not AlomawaniQoLData then
                AlomawaniQoLData = {}
            end

            -- Init Configs
            if not AlomawaniQoLData.Configs then
                AlomawaniQoLData.Configs = {}
            end

            -- General
            AlomawaniQoLData.Configs["Debug"] = AlomawaniQoLData.Configs["Debug"] or false

            -- System
            AlomawaniQoLData.Configs["MaxOutCameraDistance"] = AlomawaniQoLData.Configs["MaxOutCameraDistance"] or true
            AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = AlomawaniQoLData.Configs["ObjectiveTrackerScale"] or 1
            AlomawaniQoLData.Configs["UIParentScale"] = AlomawaniQoLData.Configs["UIParentScale"] or 1 -- 768/1440 = 0.5333333333333333333333333333333333
            AlomawaniQoLData.Configs["MuteAnnoyingSound"] = AlomawaniQoLData.Configs["MuteAnnoyingSound"] or false

            -- Social
            AlomawaniQoLData.Configs["DisableChatClamping"] = AlomawaniQoLData.Configs["DisableChatClamping"] or true

            -- Gameplay
            AlomawaniQoLData.Configs["DisableRightClickTargeting"] = AlomawaniQoLData.Configs["DisableRightClickTargeting"] or true
            AlomawaniQoLData.Configs["EnableRepairAutomatic"] = AlomawaniQoLData.Configs["EnableRepairAutomatic"] or true

            -- Interface
            AlomawaniQoLData.Configs["DisableDamageText"] = AlomawaniQoLData.Configs["DisableDamageText"] or true
            AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = AlomawaniQoLData.Configs["ObjectiveTrackerScale"] or 1
        end
	elseif (event == "PLAYER_LOGIN") then
        AlomawaniQoL.AlomawaniQoLGui:Init()

		AlomawaniQoL.System:Enable()
        AlomawaniQoL.Gameplay:Enable()
        AlomawaniQoL.Interface:Enable()
    end
end)
