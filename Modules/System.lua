local _, AlomawaniQoL = ...

local System = AlomawaniQoL:NewModule('System', 'AceEvent-3.0')

local defaults = {
    profile = {
        enabled = true,
        customScaleToggle = false,
        customScaleValue = 0, -- 768/1440 -- 0.533333333 -- X .67 -- Y .33
        maxCameraZoomToggle = false,
        maxCameraZoomValue = 2.6,
    },
}

function System:OnInitialize()
    self.db = AlomawaniQoL.db:RegisterNamespace('System', defaults)
    self:SetEnabledState(self.db.profile.enabled)
end

function System:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function System:OnDisable()
    self:UnregisterEvent('PLAYER_ENTERING_WORLD')
    self:ToggleOptions()
end

function System:ApplyConfig(config)
    if config then
        self.config = config
    end
end

function System:PLAYER_ENTERING_WORLD()
    local profile = self.db.profile

    if profile.customScaleToggle and profile.customScaleValue ~= 0 then
        UIParent:SetScale(tonumber(profile.customScaleValue) or profile.customScaleValue)
    end

    if profile.maxCameraZoomToggle then
        local zoomValue = tonumber(profile.maxCameraZoomValue)
        if not zoomValue or zoomValue < 1 or zoomValue > 2.6 then
            AlomawaniQoL:Print('The max camera zoom value must be between 1 and 2.6')
        else
            SetCVar('cameraDistanceMaxZoomFactor', zoomValue)
        end
    end
end