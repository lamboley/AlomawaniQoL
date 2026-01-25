local _, AQL = ...
local System = AQL['System']

local Graphics = CreateFrame('Frame')

function Graphics:OnEvent(event, ...)
    UIParent:SetScale(AQLDB.Configs["UIParentScale"])
    SetCVar('cameraDistanceMaxZoomFactor', 2.6)
end

function Graphics:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

System.Graphics = Graphics
