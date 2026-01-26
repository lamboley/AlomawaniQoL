local _, AlomawaniQoL = ...
local System = AlomawaniQoL['System']

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

System.Graphics = Graphics
