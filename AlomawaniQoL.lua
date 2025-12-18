local _G = _G
local type= type

local AceAddon, AceAddonMinor = _G.LibStub('AceAddon-3.0')

local addonName, AlomawaniQoL = ...
AlomawaniQoL = AceAddon:NewAddon(AlomawaniQoL, 'AlomawaniQoL', 'AceConsole-3.0', 'AceEvent-3.0', 'AceHook-3.0')
_G[addonName] = AlomawaniQoL

local LibDualSpec = LibStub('LibDualSpec-1.0', true)

local defaults = {
	profile = {
	}
}

function AlomawaniQoL.Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'Alomawani QoL:|r ', ...))
end

function AlomawaniQoL:OnInitialize()
	self.db = LibStub('AceDB-3.0'):New('AlomawaniQoLDB', defaults, true)

	self.db.RegisterCallback(self, 'OnNewProfile', 'InitializeProfile')
	self.db.RegisterCallback(self, 'OnProfileChanged', 'UpdateModuleConfigs')
	self.db.RegisterCallback(self, 'OnProfileCopied', 'UpdateModuleConfigs')
	self.db.RegisterCallback(self, 'OnProfileReset', 'UpdateModuleConfigs')

	if LibDualSpec then
		LibDualSpec:EnhanceDatabase(AlomawaniQoL.db, 'AlomawaniQoL')
	end

	self:SetupOptions()
end

function AlomawaniQoL:InitializeProfile()
	self:UpdateModuleConfigs()
end

function AlomawaniQoL:OnEnable()
end

function AlomawaniQoL:UpdateModuleConfigs()
	for _, v in self:IterateModules() do
		v:ToggleModule()
		if v:IsEnabled() and type(v.ApplyConfig) == 'function' then
			v:ApplyConfig()
		end
	end
end

AlomawaniQoL.defaultModulePrototype = {}
function AlomawaniQoL.defaultModulePrototype:ToggleModule(info, value)
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

function AlomawaniQoL.defaultModulePrototype:ToggleOptions()
	if self.options then
		self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
	end
end

function AlomawaniQoL.defaultModulePrototype:OnDisable()
    self:ToggleOptions()
end

AlomawaniQoL:SetDefaultModulePrototype(AlomawaniQoL.defaultModulePrototype)
