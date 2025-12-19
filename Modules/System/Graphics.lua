local _, AlomawaniQoL = ...

local Graphics = AlomawaniQoL:NewModule('Graphics', 'AceEvent-3.0')

local SetCVar = SetCVar

local defaults = {
    profile = {
        enabled = true,
        customScaleToggle = false,
        customScaleValue = 0,
        maxCameraZoomToggle = false,
        maxCameraZoomValue = 2.6,
    },
}

function Graphics:OnInitialize()
    self.db = AlomawaniQoL.db:RegisterNamespace('Graphics', defaults)
    self:SetEnabledState(self.db.profile.enabled)
end

function Graphics:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Graphics:OnDisable()
    self:UnregisterEvent('PLAYER_ENTERING_WORLD')
    self:ToggleOptions()
end

function Graphics:ApplyConfig(config)
    if config then
        self.config = config
    end
end

function Graphics:PLAYER_ENTERING_WORLD()
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