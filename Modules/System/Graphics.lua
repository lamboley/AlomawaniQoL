local _, AQL = ...
local System = AQL['System']

local Graphics = CreateFrame('Frame')

function Graphics:OnEvent(event, ...)
    UIParent:SetScale(AQLDB.Configs["UIParentScale"])

    if AQLDB.Configs["MaxOutCameraDistance"] then
        SetCVar('cameraDistanceMaxZoomFactor', 2.6)
    end
end

function Graphics:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

System.Graphics = Graphics
