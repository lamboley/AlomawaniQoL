local _, AlomawaniQoL = ...

local AceDBOptions = LibStub('AceDBOptions-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')
local AceConfig = LibStub('AceConfig-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local function generateOptions()
    local db = AlomawaniQoL.db
    local profilesTable = AceDBOptions:GetOptionsTable(db)

    if LibDualSpec then
        LibDualSpec:EnhanceOptions(profilesTable, db)
    end

    AlomawaniQoL.options = {
        type = 'group',
        name = 'Alomawani QoL',
        childGroups = 'tree',
        plugins = {
            profiles = { profiles = profilesTable },
        },
        args = {
            quests = {
                order = 2,
                type = 'group',
                name = 'Quests',
                args = {
                    options = {
                        type = 'group',
                        order = 0,
                        name = function(info)
                            return info.uiType == 'dialog' and '' or 'System'
                        end,
                        guiInline = true,
                        args = {},
                    },
                },
            },
            social = {
                order = 3,
                type = 'group',
                name = 'Social',
                args = {
                    options = {
                        type = 'group',
                        order = 0,
                        name = function(info)
                            return info.uiType == 'dialog' and '' or 'System'
                        end,
                        guiInline = true,
                        args = {},
                    },
                },
            },
        },
    }

    for _, module in AlomawaniQoL:IterateModules() do
        if module.SetupOptions then
            module:SetupOptions()
        end
    end
end

local function getOptions()
    if not AlomawaniQoL.options then
        generateOptions()
    end
    return AlomawaniQoL.options
end

function AlomawaniQoL:ToggleOptions()
    if InCombatLockdown() then
        self:Print("Can't open options in combat.")
        return
    end
    AceConfigDialog:Open('AlomawaniQoL')
end

function AlomawaniQoL:SetupOptions()
    AceConfig:RegisterOptionsTable('AlomawaniQoL', getOptions)
    AceConfigDialog:SetDefaultSize('AlomawaniQoL', 750, 650)
    self:RegisterChatCommand('alomawaniqol', 'ToggleOptions')
    self:RegisterChatCommand('alq', 'ToggleOptions')
end
