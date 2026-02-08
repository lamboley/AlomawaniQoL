---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
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

            if not AlomawaniQoLData.Configs then
                AlomawaniQoLData.Configs = {}
            end

            local function SetDefault(key, default)
                if AlomawaniQoLData.Configs[key] == nil then
                    AlomawaniQoLData.Configs[key] = default
                end
            end

            -- General
            SetDefault("Debug", false)

            -- System
            SetDefault("MaxOutCameraDistance", true)
            SetDefault("UsePerfectPixel", false)
            SetDefault("UseCustomHeight", "")
            SetDefault("MuteAnnoyingSound", false)

            -- Social
            SetDefault("DisableChatClamping", true)

            -- Gameplay
            SetDefault("DisableRightClickTargeting", true)
            SetDefault("FasterAutoLoot", false)
            SetDefault("AddVoiceLineWhenDead", false)
            SetDefault("PrintQuoteFromThichNhatHanh", false)
            SetDefault("KeepABattlePetSummoned", false)
            SetDefault("BattlePetNameToSummon", "")
            SetDefault("RepairGearAutomatically", true)
            SetDefault("UseGuildBankForRepair", false)
            SetDefault("SellJunkAutomatically", true)

            -- Interface
            SetDefault("DisableDamageText", true)
            SetDefault("HideTooltipWhileInCombat", false)
            SetDefault("HidePlayerPortraitWhenHeal", false)
            SetDefault("ObjectiveTrackerScale", 1)
        end
	elseif (event == "PLAYER_LOGIN") then
        AlomawaniQoL.AlomawaniQoLGui:Init()

		AlomawaniQoL.System:Enable()
        AlomawaniQoL.Gameplay:Enable()
        AlomawaniQoL.Interface:Enable()
    end
end)
