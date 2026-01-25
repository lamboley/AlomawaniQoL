local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]
local System = T['System']

local Graphics = CreateFrame('Frame')

function Graphics:OnEvent(event, ...)
    UIParent:SetScale(768/1440)
    SetCVar('cameraDistanceMaxZoomFactor', 2.6)
end

function Graphics:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

System.Graphics = Graphics
