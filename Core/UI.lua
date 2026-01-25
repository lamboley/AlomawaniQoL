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

-- https://github.com/Tercioo/Details-Framework/blob/b924dc8df2a49c2caf00cce279e68ba669a2dc47/panel.lua#L2171
-- detailsFramework:CreateSimplePanel(parent, width, height, title, frameName, panelOptions, savedVariableTable)
local AQLUI = DF:CreateSimplePanel(UIParent, WIDTH, HEIGHT, "Alomawani QoL", "AQLUI", {})
AQLUI:SetPoint("CENTER")
AQLUI:SetFrameStrata("HIGH")

function AQLUI:Init()
    local tabsContainer = DF:CreateTabContainer(AQLUI, "Alomawani QoL", "AQLUITabsContainers",
        {
            {
                name = "General",
                text = "General"
            },
        },
        {
            width = WIDTH,
            height = HEIGHT - 5,
            backdrop_color = { 0, 0, 0, 0 }, -- r, g, b, a
            backdrop_border_color = { 0.1, 0.1, 0.1, 0.4 } -- r, g, b, a
        }
    )
    tabsContainer:SetPoint("CENTER", AQLUI, "CENTER", 0, 0)

    local tabGeneral = tabsContainer:GetTabFrameByName("General")
    local tabGeneralMenuOptions = {
        {
            type = "label",
            get = function() return "General Options" end,
            text_template = DF:GetTemplate("font", "ORANGE_FONT_TEMPLATE")
        },
        {
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
    }

    -- https://github.com/Tercioo/Details-Framework/blob/master/buildmenu.lua
    -- detailsFramework:BuildMenu(parent, menuOptions, xOffset, yOffset, height, useColon, textTemplate, dropdownTemplate, switchTemplate, switchIsCheckbox, sliderTemplate, buttonTemplate, valueChangeHook)
    DF:BuildMenu(tabGeneral, tabGeneralMenuOptions, 10, -100, HEIGHT - 10, false, textTemplate,  dropdownTemplate, switchTemplate, true, sliderTemplate, buttonTemplate)
end

function AQLUI:ToggleOptions()
    if AQLUI:IsShown() then
        AQLUI:Hide()
    else
        AQLUI:Show()
    end
end

AQL.AQLUI = AQLUI
