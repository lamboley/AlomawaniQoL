local _, AlomawaniQoL = ...

local Events = CreateFrame("Frame")
Events:RegisterEvent("ADDON_LOADED")
Events:RegisterEvent("PLAYER_ENTERING_WORLD")
Events:RegisterEvent("PLAYER_LOGIN")
Events:SetScript("OnEvent", function(self, event, ...)
    AlomawaniQoL:OnEvent(event, ...)
end)

function AlomawaniQoL:OnEvent(event, ...)
	if (event == "ADDON_LOADED") then
        local name = ...
        if name == "AlomawaniQoL" then
            if not AlomawaniQoLData then
                AlomawaniQoLData = {}
            end

            if not AlomawaniQoLData.AlomawaniQoLUI then
                AlomawaniQoLData.AlomawaniQoLUI = {
                    scale = 1
                }
            end

            if not AlomawaniQoLData.Configs then
                AlomawaniQoLData.Configs = {}
            end

            -----------------------------------------------------------------------------------------------------------
            -- General - General
            AlomawaniQoLData.Configs["Debug"] = AlomawaniQoLData.Configs["Debug"] or false

            -- General - Modules

            -----------------------------------------------------------------------------------------------------------
            -- System - General
            AlomawaniQoLData.Configs["MaxOutCameraDistance"] = AlomawaniQoLData.Configs["MaxOutCameraDistance"] or true

            -- System - Graphics
            AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = AlomawaniQoLData.Configs["ObjectiveTrackerScale"] or 1
            AlomawaniQoLData.Configs["UIParentScale"] = AlomawaniQoLData.Configs["UIParentScale"] or 1 -- 768/1440 = 0.5333333333333333333333333333333333

            -- System - Audio
            AlomawaniQoLData.Configs["MuteAnnoyingSound"] = AlomawaniQoLData.Configs["MuteAnnoyingSound"] or false

            -----------------------------------------------------------------------------------------------------------
            -- Social - Chat
            AlomawaniQoLData.Configs["DisableChatClamping"] = AlomawaniQoLData.Configs["DisableChatClamping"] or true

            -----------------------------------------------------------------------------------------------------------
            -- Gameplay - General
            AlomawaniQoLData.Configs["DisableRightClickTargeting"] = AlomawaniQoLData.Configs["DisableRightClickTargeting"] or true

            -- Merchant Options
            AlomawaniQoLData.Configs["EnableRepairAutomatic"] = AlomawaniQoLData.Configs["EnableRepairAutomatic"] or true

            -----------------------------------------------------------------------------------------------------------
            -- Interface - General
            AlomawaniQoLData.Configs["DisableDamageText"] = AlomawaniQoLData.Configs["DisableDamageText"] or true

            -- Interface - Scale
            AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = AlomawaniQoLData.Configs["ObjectiveTrackerScale"] or 1
        end
	elseif (event == "PLAYER_LOGIN") then
        self.AlomawaniQoLUI:Init()

		AlomawaniQoL["System"]:Enable()
        AlomawaniQoL["Interface"]:Enable()
    end
end
