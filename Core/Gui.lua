local _, AlomawaniQoL = ...

-- Lua API
local _G = _G

-- WoW API

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
            {
                type = "blank"
            },
            { -- Modules
                type = "label",
                get = function() return "Modules" end,
                text_template = orangeTextTemplate
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
                get = function() return AlomawaniQoLData.Configs["MaxOutCameraDistance"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["MaxOutCameraDistance"] = value
                end,
            },
            {
                type = "blank"
            },
            { -- Graphics
                type = "label",
                get = function() return "Graphics" end,
                text_template = orangeTextTemplate
            },
            { -- UI Scale
                type = "range",
                name = "UI Scale",
                get = function() return AlomawaniQoLData.Configs["UIParentScale"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["UIParentScale"] = value
                end,
                min = 0.0000001,
                max = 2,
                step = 0.0000001,
                usedecimals = true,
            },
            {
                type = "blank"
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
                get = function() return AlomawaniQoLData.Configs["DisableRightClickTargeting"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableRightClickTargeting"] = value
                end,
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
                get = function() return AlomawaniQoLData.Configs["DisableDamageText"] end,
                set = function(_, _, value)
                    AlomawaniQoLData.Configs["DisableDamageText"] = value
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
