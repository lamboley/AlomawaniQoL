local _, AQL = ...

local WIDTH, HEIGHT = 1050, 620

-- https://www.curseforge.com/wow/addons/libdframework
local DF = _G["DetailsFramework"]

-- DetailsFramework Template
local textTemplate = DF:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
local dropdownTemplate = DF:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
local switchTemplate = DF:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
local sliderTemplate = DF:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
local buttonTemplate = DF:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")
local orangeTextTemplate = DF:GetTemplate("font", "ORANGE_FONT_TEMPLATE")

-- https://github.com/Tercioo/Details-Framework/blob/b924dc8df2a49c2caf00cce279e68ba669a2dc47/panel.lua#L2171
-- detailsFramework:CreateSimplePanel(parent, width, height, title, frameName, panelOptions, savedVariableTable)
local AQLUI = DF:CreateSimplePanel(UIParent, WIDTH, HEIGHT, "Alomawani QoL", "AQLUI", {})
AQLUI:SetPoint("CENTER")

function AQLUI:Init()
    local tabsContainer = DF:CreateTabContainer(AQLUI, "Alomawani QoL", "AQLUITabsContainers",
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
        },
        {
            width = WIDTH,
            height = HEIGHT - 10,
            backdrop_color = { 0, 0, 0, 0 },
            backdrop_border_color = { 0.1, 0.1, 0.1, 0.4 }
        }
    )
    tabsContainer:SetPoint("CENTER", AQLUI, "CENTER", 0, 0)

    -------------------------------------------------------------------------------------------------------------------
    -- GENERAL
    --
    -- https://github.com/Tercioo/Details-Framework/blob/master/buildmenu.lua
    -- detailsFramework:BuildMenu(parent, menuOptions, xOffset, yOffset, height, useColon, textTemplate, dropdownTemplate, switchTemplate, switchIsCheckbox, sliderTemplate, buttonTemplate, valueChangeHook)
    DF:BuildMenu(tabsContainer:GetTabFrameByName("General"),
        {
            { -- Label: General Options
                type = "label",
                get = function() return "General Options" end,
                text_template = orangeTextTemplate
            },
            { -- Enable Debug
                type = "toggle",
                boxfirst = true,
                name = "Enable Debug",
                get = function() return AQLDB.Configs["Debug"] end,
                set = function(_, _, value)
                    AQLDB.Configs["Debug"] = value
                end,
            },
            {
                type = "breakline"
            },
            { -- Label: Modules Options
                type = "label",
                get = function() return "Modules Options" end,
                text_template = orangeTextTemplate
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate,  dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -------------------------------------------------------------------------------------------------------------------
    -- SYSTEM
    --
    -- TODO: Make Interface it's own tab
    DF:BuildMenu(tabsContainer:GetTabFrameByName("System"),
        {
            { -- Label: System Options
                type = "label",
                get = function() return "Graphics Options" end,
                text_template = orangeTextTemplate
            },
            { -- Max Out Camera Distance
                type = "toggle",
                boxfirst = true,
                name = "Max Out Camera Distance",
                get = function() return AQLDB.Configs["MaxOutCameraDistance"] end,
                set = function(_, _, value)
                    AQLDB.Configs["MaxOutCameraDistance"] = value
                end,
            },
            { -- UI Scale
                type = "range",
                name = "UI Scale",
                get = function() return AQLDB.Configs["UIParentScale"] end,
                set = function(_, _, value)
                    AQLDB.Configs["UIParentScale"] = value
                end,
                min = 0.0000001,
                max = 2,
                step = 0.0000001,
                usedecimals = true,
            },
            {
                type = "breakline"
            },
            { -- Label: Interface Options
                type = "label",
                get = function() return "Interface Options" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Damage Text
                type = "toggle",
                boxfirst = true,
                name = "Disable Damage Text",
                get = function() return AQLDB.Configs["DisableDamageText"] end,
                set = function(_, _, value)
                    AQLDB.Configs["DisableDamageText"] = value
                end,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate,  dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -------------------------------------------------------------------------------------------------------------------
    -- SOCIAL
    DF:BuildMenu(tabsContainer:GetTabFrameByName("Social"),
        {
            { -- Label: Chat Options
                type = "label",
                get = function() return "Chat Options" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Chat Clamping
                type = "toggle",
                boxfirst = true,
                name = "Disable Chat Clamping",
                get = function() return AQLDB.Configs["DisableChatClamping"] end,
                set = function(_, _, value)
                    AQLDB.Configs["DisableChatClamping"] = value
                end,
            },
        },
        10, -100, HEIGHT - 10, false,
        textTemplate, dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )

    -------------------------------------------------------------------------------------------------------------------
    -- GAMEPLAY
    DF:BuildMenu(tabsContainer:GetTabFrameByName("Gameplay"),
        {
            { -- Label: Gameplay Options
                type = "label",
                get = function() return "Gameplay Options" end,
                text_template = orangeTextTemplate
            },
            { -- Disable Right Click Targeting
                type = "toggle",
                boxfirst = true,
                name = "Disable Right Click Targeting",
                get = function() return AQLDB.Configs["DisableRightClickTargeting"] end,
                set = function(_, _, value)
                    AQLDB.Configs["DisableRightClickTargeting"] = value
                end,
            },
            {
                type = "breakline"
            },
            { -- Label: Vendor Options
                type = "label",
                get = function() return "Vendor Options" end,
                text_template = orangeTextTemplate
            },
            { -- Enable Repair Automatic
                type = "toggle",
                boxfirst = true,
                name = "Enable Repair Automatic",
                get = function() return AQLDB.Configs["EnableRepairAutomatic"] end,
                set = function(_, _, value)
                    AQLDB.Configs["EnableRepairAutomatic"] = value
                end,
            },

        },
        10, -100, HEIGHT - 10, false,
        textTemplate, dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate
    )
end

function AQLUI:ToggleOptions()
    if AQLUI:IsShown() then
        AQLUI:Hide()
    else
        AQLUI:Show()
    end
end

AQL.AQLUI = AQLUI
