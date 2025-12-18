local _, AlomawaniQoL = ...
local Graphics = AlomawaniQoL:NewModule('Graphics', 'AceEvent-3.0')

local defaults = {
	profile = {
        enabled = true,
		customScaleToggle = false,
		customScaleValue = 0, -- 768/1440
		maxCameraZoomToggle = false,
		maxCameraZoomValue = 2.6
	}
}

function Graphics:OnInitialize()
    self.db = AlomawaniQoL.db:RegisterNamespace('Graphics', defaults)

	self:SetEnabledState(self.db.profile.enabled)

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end

function Graphics:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)
end

function Graphics:ApplyConfig(config)
	if config then
		self.config = config
	end
end

function Graphics:PLAYER_ENTERING_WORLD()


	if self.db.profile.customScaleToggle then
		if self.db.profile.customScaleValue ~= 0 then
			-- TODO: Check the value type
			UIParent:SetScale(self.db.profile.customScaleValue)
		end
	end

	if self.db.profile.maxCameraZoomToggle then
		maxCameraZoomValue = tonumber(self.db.profile.maxCameraZoomValue)
		if maxCameraZoomValue < 1 or maxCameraZoomValue > 2.6 then
			AlomawaniQoL.Print('The max camera zoom value must be between 0 and 2.6')
		else
			SetCVar('cameraDistanceMaxZoomFactor', maxCameraZoomValue)
		end
	end
end