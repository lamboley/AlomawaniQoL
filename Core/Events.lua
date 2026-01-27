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

            if not AlomawaniQoLData.AlomawaniQoLGui then
                AlomawaniQoLData.AlomawaniQoLGui = {
                    scale = 1
                }
            end

            if not AlomawaniQoLData.Configs then
                AlomawaniQoLData.Configs = {}
            end

            -- General
            AlomawaniQoLData.Configs["Debug"] = AlomawaniQoLData.Configs["Debug"] or false

            -- System
            AlomawaniQoLData.Configs["MaxOutCameraDistance"] = AlomawaniQoLData.Configs["MaxOutCameraDistance"] or true
            AlomawaniQoLData.Configs["UsePerfectPixel"] = AlomawaniQoLData.Configs["UsePerfectPixel"] or false
            AlomawaniQoLData.Configs["UseCustomHeight"] = AlomawaniQoLData.Configs["UseCustomHeight"] or ""
            AlomawaniQoLData.Configs["MuteAnnoyingSound"] = AlomawaniQoLData.Configs["MuteAnnoyingSound"] or false

            -- Social
            AlomawaniQoLData.Configs["DisableChatClamping"] = AlomawaniQoLData.Configs["DisableChatClamping"] or true

            -- Gameplay
            AlomawaniQoLData.Configs["DisableRightClickTargeting"] = AlomawaniQoLData.Configs["DisableRightClickTargeting"] or true
            AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] = AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] or false
            AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] = AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] or false
            AlomawaniQoLData.Configs["RepairGearAutomatically"] = AlomawaniQoLData.Configs["RepairGearAutomatically"] or true
            AlomawaniQoLData.Configs["UseGuildBankForRepair"] = AlomawaniQoLData.Configs["UseGuildBankForRepair"] or false
            AlomawaniQoLData.Configs["SellJunkAutomatically"] = AlomawaniQoLData.Configs["SellJunkAutomatically"] or true

            -- Interface
            AlomawaniQoLData.Configs["DisableDamageText"] = AlomawaniQoLData.Configs["DisableDamageText"] or true
            AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] = AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] or false

            AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = AlomawaniQoLData.Configs["ObjectiveTrackerScale"] or 1
        end
	elseif (event == "PLAYER_LOGIN") then
        AlomawaniQoL.AlomawaniQoLGui:Init()

		AlomawaniQoL.System:Enable()
        AlomawaniQoL.Gameplay:Enable()
        AlomawaniQoL.Interface:Enable()
    end
end)
