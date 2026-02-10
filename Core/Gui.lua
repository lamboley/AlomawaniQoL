---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local string = string
local tonumber = tonumber
local unpack = unpack

---@type table
local DF = _G["DetailsFramework"]

---@type table
local L = AlomawaniQoL.L

local System = AlomawaniQoL.System
local Interface = AlomawaniQoL.Interface

---@type number, number, number
local WIDTH, HEIGHT, LINE = 1000, 600, -85

---@type number
local LINE_BOTTOM = HEIGHT+LINE-11

---@type table
local textTemplate = DF:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
---@type table
local dropdownTemplate = DF:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
---@type table
local switchTemplate = DF:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
---@type table
local sliderTemplate = DF:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
---@type table
local buttonTemplate = DF:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")

---@type string
local nameRequireReload = "|cFF00FF00*|r"

---@type string
local descRequireReload = " \n\n|cFF00FF00[*]|r |cFFFFFFFF" .. L["Requires /reload to take effect."] .. "|r"

---@class AlomawaniQoLGui : Frame
---@field Init fun(self: AlomawaniQoLGui)
---@field ToggleOptions fun(self: AlomawaniQoLGui)
local AlomawaniQoLGui = DF:CreateSimplePanel(UIParent, WIDTH, HEIGHT, AlomawaniQoL.addonName, "AlomawaniQoLGui", {})

function AlomawaniQoLGui:Init()
    ---@type table
    local customTextTemplate = {color = AlomawaniQoLData.Configs["MenuColor"], size = 11, font = DF:GetBestFontForLanguage()}

    local tabsContainer = DF:CreateTabContainer(AlomawaniQoLGui, AlomawaniQoL.addonName, "AlomawaniQoLGuiTabsContainers",
        {
            {
                name = "General",
                text = L["General"]
            },
            {
                name = "System",
                text = L["System"]
            },
            {
                name = "Social",
                text = L["Social"]
            },
            {
                name = "Gameplay",
                text = L["Gameplay"]
            },
            {
                name = "Interface",
                text = L["Interface"]
            },
        },
        {
            width = WIDTH,
            height = HEIGHT - 10,
            container_width_offset = 30,
            hide_click_label = true
        }
    )
    tabsContainer:SetPoint("CENTER", AlomawaniQoLGui, "CENTER", 0, 0)
    tabsContainer:CallOnEachTab(function(frame)
        local line = frame:CreateTexture(nil, "artwork")
        line:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, LINE)
        line:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, LINE_BOTTOM)
        line:SetColorTexture(0.15, 0.15, 0.15)
    end)

    for _, button in ipairs(tabsContainer.AllButtons) do
        button:SetTextColor(AlomawaniQoLData.Configs["MenuColor"])
    end

    -- General
    DF:BuildMenu(tabsContainer:GetTabFrameByName("General"),
        {
            { -- General
                type = "label",
                get = function() return L["General"] end,
                text_template = customTextTemplate
            },
            { -- Enable Debug
                type = "toggle",
                boxfirst = true,
                name = L["Enable Debug"],
                get = function() return AlomawaniQoLData.Configs["Debug"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["Debug"] = value
                end,
            },
            { -- Menu Color
                type = "color",
                boxfirst = true,
                name = L["Menu Color"] .. nameRequireReload,
                desc = L["Change the addon theme color."] .. descRequireReload,
                get = function() return unpack(AlomawaniQoLData.Configs["MenuColor"]) end,
                set = function(self, r, g, b, a)
                    AlomawaniQoLData.Configs["MenuColor"] = {r, g, b, a}
                end,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate,  dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -- System
    DF:BuildMenu(tabsContainer:GetTabFrameByName("System"),
        {
            { -- General
                type = "label",
                get = function() return L["General"] end,
                text_template = customTextTemplate
            },
            { -- Max Out Camera Distance
                type = "toggle",
                boxfirst = true,
                name = L["Max Out Camera Distance"] .. nameRequireReload,
                desc = L["Set the CVar 'cameraDistanceMaxZoomFactor' to 2.6."] .. descRequireReload,
                get = function() return AlomawaniQoLData.Configs["MaxOutCameraDistance"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["MaxOutCameraDistance"] = value
                end,
            },
            {
                type = "breakline"
            },
            { -- Graphics
                type = "label",
                get = function() return L["Graphics"] end,
                text_template = customTextTemplate
            },
            { -- Use Perfect Pixel
                type = "toggle",
                boxfirst = true,
                name = L["Use Perfect Pixel"] .. nameRequireReload,
                desc = L["Set the UI Scale based on the vertical resolution (UIScale = 768 / verticalResolution)."] .. descRequireReload,
                get = function() return AlomawaniQoLData.Configs["UsePerfectPixel"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["UsePerfectPixel"] = value
                end,
            },
            { -- Use Custom Height
                type = "textentry",
                name = L["Use Custom Height"] .. nameRequireReload,
                desc = L["If the UI is too small when using the option above, you can set a custom vertical resolution here."] .. descRequireReload,
                width = 50,
                get = function() return AlomawaniQoLData.Configs["UseCustomHeight"] or "" end,
                set = function(_, _, value)
                    local height = tonumber(value)
                    if height and height >= 480 and height <= 4320 then
                        AlomawaniQoLData.Configs["UseCustomHeight"] = value
                    else
                        AlomawaniQoL:Print(L["Custom height must be between 480-4320"])
                    end
                end,
                hooks = {
                    OnEditFocusLost = function(self)
                        self:SetText(AlomawaniQoLData.Configs["UseCustomHeight"])
                    end,
                    OnEnterPressed = function(_) return end
                },
            },
            {
                type = "breakline",
                spacement = true,
            },
            { -- Audio
                type = "label",
                get = function() return L["Audio"] end,
                text_template = customTextTemplate
            },
            { -- Mute Annoying Sound
                type = "toggle",
                boxfirst = true,
                name = L["Mute Annoying Sound"],
                get = function() return AlomawaniQoLData.Configs["MuteAnnoyingSound"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["MuteAnnoyingSound"] = value
                    if value then
                        System.Audio:Enable()
                    else
                        System.Audio:Disable()
                    end
                end,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate,  dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -- Social
    DF:BuildMenu(tabsContainer:GetTabFrameByName("Social"),
        {
            { -- Chat
                type = "label",
                get = function() return L["Chat"] end,
                text_template = customTextTemplate
            },
            { -- Disable Chat Clamping
                type = "toggle",
                boxfirst = true,
                name = L["Disable Chat Clamping"] .. nameRequireReload,
                desc = descRequireReload,
                get = function() return AlomawaniQoLData.Configs["DisableChatClamping"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableChatClamping"] = value
                end,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate, dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -- Gameplay
    DF:BuildMenu(tabsContainer:GetTabFrameByName("Gameplay"),
        {
            { -- General
                type = "label",
                get = function() return L["General"] end,
                text_template = customTextTemplate
            },
            { -- Disable Right Click Targeting
                type = "toggle",
                boxfirst = true,
                name = L["Disable Right Click Targeting"] .. nameRequireReload,
                desc = descRequireReload,
                get = function() return AlomawaniQoLData.Configs["DisableRightClickTargeting"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableRightClickTargeting"] = value
                end,
            },
            { -- Faster Auto Loot
                type = "toggle",
                boxfirst = true,
                name = L["Faster Auto Loot"],
                get = function() return AlomawaniQoLData.Configs["FasterAutoLoot"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["FasterAutoLoot"] = value
                end,
            },
            {
                type = "blank"
            },
            { -- Scale
                type = "label",
                get = function() return L["Roleplay"] end,
                text_template = customTextTemplate
            },
            { -- Add Voice Line When Dead
                type = "toggle",
                boxfirst = true,
                name = L["Add Voice Line When Dead"],
                desc = L["Voice line are from Ilgynoth, Yshaarj, Xalatath and Yoggsaron"],
                get = function() return AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] = value
                    if value then
                        AlomawaniQoL.Gameplay.Voice:Enable()
                    else
                        AlomawaniQoL.Gameplay.Voice:Disable()
                    end
                end,
            },
            { -- Print Quote From Thich Nhat Hanh
                type = "toggle",
                boxfirst = true,
                name = L["Print Quote From Thich Nhat Hanh"],
                get = function() return AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] = value
                    if value then
                        AlomawaniQoL.Gameplay.ThichNhatHanh:Enable()
                    else
                        AlomawaniQoL.Gameplay.ThichNhatHanh:Disable()
                    end
                end,
            },
            {
                type = "blank"
            },
            { -- Scale
                type = "label",
                get = function() return L["Battle Pet"] end,
                text_template = customTextTemplate
            },
            { -- Keep A Battle Pet Summoned
                type = "toggle",
                boxfirst = true,
                name = L["Keep A Battle Pet Summoned"],
                get = function() return AlomawaniQoLData.Configs["KeepABattlePetSummoned"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["KeepABattlePetSummoned"] = value
                    if value then
                        AlomawaniQoL.Gameplay.BattlePet:Enable()
                    else
                        AlomawaniQoL.Gameplay.BattlePet:Disable()
                    end
                end,
            },
            { -- Battle Pet Name To Summon
                type = "textentry",
                name = L["Pet Name"],
                desc = L["The name of the battle pet to be summoned"],
                width = 130,
                get = function() return AlomawaniQoLData.Configs["BattlePetNameToSummon"] or "" end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["BattlePetNameToSummon"] = value
                end,
                hooks = {
                    OnEditFocusLost = function(self)
                        self:SetText(AlomawaniQoLData.Configs["BattlePetNameToSummon"])
                    end,
                    OnEnterPressed = function(self) return end
                },
            },
            {
                type = "breakline"
            },
            { -- Merchant
                type = "label",
                get = function() return L["Merchant"] end,
                text_template = customTextTemplate
            },
            { -- Repair Gear Automatically
                type = "toggle",
                boxfirst = true,
                name = L["Repair Gear Automatically"],
                get = function() return AlomawaniQoLData.Configs["RepairGearAutomatically"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["RepairGearAutomatically"] = value
                end,
            },
            { -- Use Guild Bank For Repair
                type = "toggle",
                boxfirst = true,
                name = L["Use Guild Bank For Repair"],
                get = function() return AlomawaniQoLData.Configs["UseGuildBankForRepair"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["UseGuildBankForRepair"] = value
                end,
            },
            { -- Sell Junk Automatically
                type = "toggle",
                boxfirst = true,
                name = L["Sell Junk Automatically"],
                get = function() return AlomawaniQoLData.Configs["SellJunkAutomatically"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["SellJunkAutomatically"] = value
                end,
            },
            {
                type = "blank"
            },
            { -- Bank
                type = "label",
                get = function() return L["Bank"] end,
                text_template = customTextTemplate
            },
            { -- Deposit Gold In Warband Bank
                type = "toggle",
                boxfirst = true,
                name = L["Deposit Gold In Warband Bank"],
                get = function() return AlomawaniQoLData.Configs["DepositGoldInWarbandBank"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DepositGoldInWarbandBank"] = value
                end,
            },
            { -- Gold To Keep In Inventory
                type = "textentry",
                name = L["Gold To Keep In Inventory"],
                width = 50,
                get = function() return AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"] or "" end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"] = value
                end,
                hooks = {
                    OnEditFocusLost = function(self)
                        self:SetText(AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"])
                    end,
                    OnEnterPressed = function(self) return end
                },
            },

        },
        10, -100, HEIGHT - 10, false,
        textTemplate, dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -- Interface
    DF:BuildMenu(tabsContainer:GetTabFrameByName("Interface"),
        {
            { -- General
                type = "label",
                get = function() return L["General"] end,
                text_template = customTextTemplate
            },
            { -- Disable Damage Text
                type = "toggle",
                boxfirst = true,
                name = L["Disable Damage Text"] .. nameRequireReload,
                desc = descRequireReload,
                get = function() return AlomawaniQoLData.Configs["DisableDamageText"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableDamageText"] = value
                end,
            },
            { -- Hide Tooltip While In Combat
                type = "toggle",
                boxfirst = true,
                name = L["Hide Tooltip While In Combat"] .. nameRequireReload,
                desc = descRequireReload,
                get = function() return AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] = value
                end,
            },
            { -- Hide Player Portrait When Heal
                type = "toggle",
                boxfirst = true,
                name = L["Hide Player Portrait When Heal"],
                get = function() return AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] = value
                    if value then
                        Interface.Portrait:Enable()
                    else
                        Interface.Portrait:Disable()
                    end
                end,
            },
            {
                type = "blank"
            },
            { -- Scale
                type = "label",
                get = function() return L["Scale"] end,
                text_template = customTextTemplate
            },
            { -- ObjectiveTracker Scale
                type = "range",
                name = L["ObjectiveTracker Scale"] .. nameRequireReload,
                desc = descRequireReload,
                get = function() return AlomawaniQoLData.Configs["ObjectiveTrackerScale"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["ObjectiveTrackerScale"] = value
                end,
                min = 0.0000001,
                max = 2,
                step = 0.0000001,
                usedecimals = true,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate, dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )
end

function AlomawaniQoLGui:ToggleOptions()
    if AlomawaniQoLGui:IsShown() then
        AlomawaniQoLGui:Hide()
    else
        AlomawaniQoLGui:Show()
    end
end

AlomawaniQoL.AlomawaniQoLGui = AlomawaniQoLGui
