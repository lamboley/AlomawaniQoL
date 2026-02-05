local _, AlomawaniQoL = ...

-- Lua API
local tonumber = tonumber
local _G = _G

local DF = _G["DetailsFramework"]

local WIDTH, HEIGHT = 1050, 620

local textTemplate = DF:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
local dropdownTemplate = DF:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
local switchTemplate = DF:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
local sliderTemplate = DF:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
local buttonTemplate = DF:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")
local orangeTextTemplate = DF:GetTemplate("font", "ORANGE_FONT_TEMPLATE")

local AlomawaniQoLGui = DF:CreateSimplePanel(UIParent, WIDTH, HEIGHT, "Alomawani QoL", "AlomawaniQoLGui", {})
AlomawaniQoLGui:SetPoint("CENTER")

function AlomawaniQoLGui:Init()
    local tabsContainer = DF:CreateTabContainer(AlomawaniQoLGui, "Alomawani QoL", "AlomawaniQoLGuiTabsContainers",
        {
            {
                name = "General",
                text = "General"
            },
            {
                name = "System",
                text = "System"
            },
            {
                name = "Social",
                text = "Social"
            },
            {
                name = "Gameplay",
                text = "Gameplay"
            },
            {
                name = "Interface",
                text = "Interface"
            },
        },
        {
            width = WIDTH,
            height = HEIGHT - 10,
            backdrop_color = { 0, 0, 0, 0 },
            backdrop_border_color = { 0.1, 0.1, 0.1, 0.4 }
        }
    )
    tabsContainer:SetPoint("CENTER", AlomawaniQoLGui, "CENTER", 0, 0)

    -- General
    DF:BuildMenu(tabsContainer:GetTabFrameByName("General"),
        {
            { -- General
                type = "label",
                get = function() return "General" end,
                text_template = orangeTextTemplate
            },
            { -- Enable Debug
                type = "toggle",
                boxfirst = true,
                name = "Enable Debug",
                get = function() return AlomawaniQoLData.Configs["Debug"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["Debug"] = value
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
                get = function() return "General" end,
                text_template = orangeTextTemplate
            },
            { -- Max Out Camera Distance
                type = "toggle",
                boxfirst = true,
                name = "Max Out Camera Distance",
                desc = "Requires /reload to take effect",
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
                get = function() return "Graphics" end,
                text_template = orangeTextTemplate
            },
            { -- Use Perfect Pixel
                type = "toggle",
                boxfirst = true,
                name = "Use Perfect Pixel",
                desc = "Set the UI Scale based on the vertical resolution (UIScale = 768 / verticalResolution). Requires /reload to take effect",
                get = function() return AlomawaniQoLData.Configs["UsePerfectPixel"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["UsePerfectPixel"] = value
                end,
            },
            { -- Use Custom Height
                type = "textentry",
                name = "Use Custom Height",
                desc = "If the UI is too small when using the option above, you can set a custom vertical resolution here. Requires /reload to take effect",
                width = 50,
                get = function() return AlomawaniQoLData.Configs["UseCustomHeight"] or "" end,
                set = function(_, _, value)
                    local height = tonumber(value)
                    if height and height >= 480 and height <= 4320 then
                        AlomawaniQoLData.Configs["UseCustomHeight"] = value
                    else
                        AlomawaniQoL.Print("Custom height must be between 480-4320")
                    end
                end,
                hooks = {
                    OnEditFocusLost = function(self)
                        self:SetText(AlomawaniQoLData.Configs["UseCustomHeight"])
                    end,
                    OnEnterPressed = function(self) return end
                },
            },
            -- { -- UI Scale
            --     type = "range",
            --     name = "UI Scale",
            --     get = function() return AlomawaniQoLData.Configs["UIParentScale"] end,
            --     set = function(_, _, value)
            --         AlomawaniQoLData.Configs["UIParentScale"] = value
            --     end,
            --     min = 0.0000001,
            --     max = 2,
            --     step = 0.0000001,
            --     usedecimals = true,
            -- },
            -- {
            --     type = "breakline"
            -- },
            {
                type = "breakline",
                spacement = true,
            },
            { -- Audio
                type = "label",
                get = function() return "Audio" end,
                text_template = orangeTextTemplate
            },
            { -- Mute Annoying Sound
                type = "toggle",
                boxfirst = true,
                name = "Mute Annoying Sound",
                desc = "Requires /reload to take effect",
                get = function() return AlomawaniQoLData.Configs["MuteAnnoyingSound"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["MuteAnnoyingSound"] = value
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
                get = function() return "Chat" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Chat Clamping
                type = "toggle",
                boxfirst = true,
                name = "Disable Chat Clamping",
                desc = "Requires /reload to take effect",
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
                get = function() return "General" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Right Click Targeting
                type = "toggle",
                boxfirst = true,
                name = "Disable Right Click Targeting",
                desc = "Requires /reload to take effect",
                get = function() return AlomawaniQoLData.Configs["DisableRightClickTargeting"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableRightClickTargeting"] = value
                end,
            },
            { -- Faster Auto Loot
                type = "toggle",
                boxfirst = true,
                name = "Faster Auto Loot",
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
                get = function() return "Roleplay" end,
                text_template = orangeTextTemplate
            },
            { -- Add Voice Line When Dead
                type = "toggle",
                boxfirst = true,
                name = "Add Voice Line When Dead",
                desc = "Voice line are from Ilgynoth, Yshaarj, Xalatath and Yoggsaron",
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
                name = "Print Quote From Thich Nhat Hanh",
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
                get = function() return "Battle Pet" end,
                text_template = orangeTextTemplate
            },
            { -- Keep A Battle Pet Summoned
                type = "toggle",
                boxfirst = true,
                name = "Keep A Battle Pet Summoned",
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
                name = "Pet Name",
                desc = "The name of the battle pet to be summoned",
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
                get = function() return "Merchant" end,
                text_template = orangeTextTemplate
            },
            { -- Repair Gear Automatically
                type = "toggle",
                boxfirst = true,
                name = "Repair Gear Automatically",
                get = function() return AlomawaniQoLData.Configs["RepairGearAutomatically"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["RepairGearAutomatically"] = value
                end,
            },
            { -- Use Guild Bank For Repair
                type = "toggle",
                boxfirst = true,
                name = "Use Guild Bank For Repair",
                get = function() return AlomawaniQoLData.Configs["UseGuildBankForRepair"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["UseGuildBankForRepair"] = value
                end,
            },
            { -- Sell Junk Automatically
                type = "toggle",
                boxfirst = true,
                name = "Sell Junk Automatically",
                get = function() return AlomawaniQoLData.Configs["SellJunkAutomatically"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["SellJunkAutomatically"] = value
                end,
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
                get = function() return "General" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Damage Text
                type = "toggle",
                boxfirst = true,
                name = "Disable Damage Text",
                desc = "Requires /reload to take effect",
                get = function() return AlomawaniQoLData.Configs["DisableDamageText"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableDamageText"] = value
                end,
            },
            { -- Hide Tooltip While In Combat
                type = "toggle",
                boxfirst = true,
                name = "Hide Tooltip While In Combat",
                desc = "Requires /reload to take effect",
                get = function() return AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] = value
                end,
            },
            { -- Hide Player Portrait When Heal
                type = "toggle",
                boxfirst = true,
                name = "Hide Player Portrait When Heal",
                get = function() return AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] = value
                    if value then
                        AlomawaniQoL.Interface.Portrait:Enable()
                    else
                        AlomawaniQoL.Interface.Portrait:Disable()
                    end
                end,
            },
            {
                type = "blank"
            },
            { -- Scale
                type = "label",
                get = function() return "Scale" end,
                text_template = orangeTextTemplate
            },
            { -- ObjectiveTracker Scale
                type = "range",
                name = "ObjectiveTracker Scale",
                desc = "Requires /reload to take effect",
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
