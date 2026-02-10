---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local CreateFrame = CreateFrame

---@class Events : Frame
---@field OnEvent fun(self: Events, event: WowEvent, ...: any)
local Events = CreateFrame("Frame")
Events:RegisterEvent("ADDON_LOADED")
Events:RegisterEvent("PLAYER_LOGIN")
Events:RegisterEvent("PLAYER_ENTERING_WORLD")
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

            ---@param key string
            ---@param default any
            local function SetDefault(key, default)
                if AlomawaniQoLData.Configs[key] == nil then
                    AlomawaniQoLData.Configs[key] = default
                end
            end

            -- General
            SetDefault("Debug", false)
            SetDefault("MenuColor", {1, 0.8235, 0, 1})
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
            SetDefault("DepositGoldInWarbandBank", true)
            SetDefault("QuantityOfGoldToKeepInInventory", "500")
            -- Interface
            SetDefault("DisableDamageText", true)
            SetDefault("HideTooltipWhileInCombat", false)
            SetDefault("HidePlayerPortraitWhenHeal", false)
            SetDefault("ObjectiveTrackerScale", 1)

            Events:UnregisterEvent("ADDON_LOADED")
        end
	elseif (event == "PLAYER_LOGIN") then
        AlomawaniQoL.AlomawaniQoLGui:Init()

		AlomawaniQoL.System:Enable()
        AlomawaniQoL.Gameplay:Enable()
        AlomawaniQoL.Interface:Enable()
    elseif (event == "PLAYER_ENTERING_WORLD") then
    end
end)
