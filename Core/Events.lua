local _, AQL = ...

local Events = CreateFrame("Frame")
Events:RegisterEvent("ADDON_LOADED")
Events:RegisterEvent("PLAYER_ENTERING_WORLD")
Events:RegisterEvent("PLAYER_LOGIN")
Events:SetScript("OnEvent", function(self, event, ...)
    AQL:OnEvent(event, ...)
end)

function AQL:OnEvent(event, ...)
	if (event == "ADDON_LOADED") then -- ADDON_LOADED
        local name = ...
        if name == "AlomawaniQoL" then
            if not AQLDB then
                AQLDB = {}
            end

            if not AQLDB.AQLUI then
                AQLDB.AQLUI = {
                    scale = 1
                }
            end

            if not AQLDB.Configs then
                AQLDB.Configs = {}
            end

            -----------------------------------------------------------------------------------------------------------
            -- General - General
            AQLDB.Configs["Debug"] = AQLDB.Configs["Debug"] or false

            -- General - Modules

            -----------------------------------------------------------------------------------------------------------
            -- System - General
            AQLDB.Configs["MaxOutCameraDistance"] = AQLDB.Configs["MaxOutCameraDistance"] or true

            -- System - Graphics
            AQLDB.Configs["ObjectiveTrackerScale"] = AQLDB.Configs["ObjectiveTrackerScale"] or 1
            AQLDB.Configs["UIParentScale"] = AQLDB.Configs["UIParentScale"] or 1 -- 768/1440 = 0.5333333333333333333333333333333333

            -- System - Audio
            AQLDB.Configs["MuteAnnoyingSound"] = AQLDB.Configs["MuteAnnoyingSound"] or false

            -----------------------------------------------------------------------------------------------------------
            -- Social - Chat
            AQLDB.Configs["DisableChatClamping"] = AQLDB.Configs["DisableChatClamping"] or true

            -----------------------------------------------------------------------------------------------------------
            -- Gameplay - General
            AQLDB.Configs["DisableRightClickTargeting"] = AQLDB.Configs["DisableRightClickTargeting"] or true

            -- Merchant Options
            AQLDB.Configs["EnableRepairAutomatic"] = AQLDB.Configs["EnableRepairAutomatic"] or true

            -----------------------------------------------------------------------------------------------------------
            -- Interface - General
            AQLDB.Configs["DisableDamageText"] = AQLDB.Configs["DisableDamageText"] or true

            -- Interface - Scale
            AQLDB.Configs["ObjectiveTrackerScale"] = AQLDB.Configs["ObjectiveTrackerScale"] or 1
        end
	elseif (event == "PLAYER_ENTERING_WORLD") then -- PLAYER_ENTERING_WORLD
	elseif (event == "PLAYER_LOGIN") then -- PLAYER_LOGIN
        -- User Interface
        self.AQLUI:Init()

        -- Modules
		AQL["System"]:Enable()
        AQL["Interface"]:Enable()
    end
end
