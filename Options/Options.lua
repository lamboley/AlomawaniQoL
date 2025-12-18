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
		plugins = {},
		args = {
			system = {
				order = 1,
				type = 'group',
				name = 'System',
				args = {
					options = {
						type = 'group',
						order = 0,
						name = function(info)
							return info.uiType == 'dialog' and '' or 'System'
						end,
						guiInline = true,
						args = {
						}
					},
				},
			},
		},
	}

	AlomawaniQoL.options.plugins.profiles = {
		profiles = AceDBOptions:GetOptionsTable(AlomawaniQoL.db)
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
		generateOptions = nil
	end
	return AlomawaniQoL.options
end

function AlomawaniQoL:ToggleOptions(input)
	if InCombatLockdown() then
		AlomawaniQoL.Print("Can't open options in combat.")
		return
	end

	AceConfigDialog:Open('AlomawaniQoL')
end

function AlomawaniQoL:SetupOptions()
	AceConfig:RegisterOptionsTable('AlomawaniQoL', getOptions)

	AceConfigDialog:SetDefaultSize('AlomawaniQoL', 660, 650)

    self:RegisterChatCommand('alomawaniqol', 'ToggleOptions')
    self:RegisterChatCommand('alq', 'ToggleOptions')
end