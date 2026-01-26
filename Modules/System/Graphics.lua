local _, AlomawaniQoL = ...

-- WoW API
local CreateFrame = CreateFrame
local SetCVar = SetCVar

local Graphics = CreateFrame('Frame')

function Graphics:OnEvent(event, ...)
    UIParent:SetScale(AlomawaniQoLData.Configs["UIParentScale"])

    if AlomawaniQoLData.Configs["MaxOutCameraDistance"] then
        SetCVar('cameraDistanceMaxZoomFactor', 2.6)
    end
end

function Graphics:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.System.Graphics = Graphics
