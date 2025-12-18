local addonName, AlomawaniQoL = ...

local AceAddon = LibStub('AceAddon-3.0')
local LibDualSpec = LibStub('LibDualSpec-1.0', true)

AlomawaniQoL = AceAddon:NewAddon(AlomawaniQoL, 'AlomawaniQoL', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
_G[addonName] = AlomawaniQoL

local defaults = {
    profile = {},
}

function AlomawaniQoL:Print(...)
    DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00Alomawani QoL:|r ', ...))
end

function AlomawaniQoL:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('AlomawaniQoLDB', defaults, true)

    self.db.RegisterCallback(self, 'OnNewProfile', 'InitializeProfile')
    self.db.RegisterCallback(self, 'OnProfileChanged', 'UpdateModuleConfigs')
    self.db.RegisterCallback(self, 'OnProfileCopied', 'UpdateModuleConfigs')
    self.db.RegisterCallback(self, 'OnProfileReset', 'UpdateModuleConfigs')

    if LibDualSpec then
        LibDualSpec:EnhanceDatabase(self.db, 'AlomawaniQoL')
    end

    self:SetupOptions()
end

function AlomawaniQoL:InitializeProfile()
    self:UpdateModuleConfigs()
end

function AlomawaniQoL:OnEnable()
end

function AlomawaniQoL:UpdateModuleConfigs()
    for _, module in self:IterateModules() do
        module:ToggleModule()
        if module:IsEnabled() and module.ApplyConfig then
            module:ApplyConfig()
        end
    end
end

local defaultModulePrototype = {}
AlomawaniQoL.defaultModulePrototype = defaultModulePrototype

function defaultModulePrototype:ToggleModule(info, value)
    if value ~= nil then
        self.db.profile.enabled = value
    else
        value = self.db.profile.enabled
    end

    if value and not self:IsEnabled() then
        self:Enable()
    elseif not value and self:IsEnabled() then
        self:Disable()
    end
end

function defaultModulePrototype:ToggleOptions()
    if self.options then
        self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
    end
end

function defaultModulePrototype:OnDisable()
    self:ToggleOptions()
end

AlomawaniQoL:SetDefaultModulePrototype(defaultModulePrototype)