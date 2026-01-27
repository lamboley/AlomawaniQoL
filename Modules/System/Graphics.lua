local _, AlomawaniQoL = ...

-- Lua API
local tonumber = tonumber
local select = select
local type = type
local max = math.max
local min = math.min

-- WoW API
local GetPhysicalScreenSize = GetPhysicalScreenSize
local CreateFrame = CreateFrame
local SetCVar = SetCVar

local Graphics = CreateFrame('Frame')

function Graphics:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["UsePerfectPixel"] then
        local screenHeight = select(2, GetPhysicalScreenSize())
        if AlomawaniQoLData.Configs["UseCustomHeight"] ~= "" then
            screenHeight = tonumber(AlomawaniQoLData.Configs["UseCustomHeight"])
        end

        local scale = max(0.4, min(1.15, (768 / screenHeight)))
        if type(scale) == "number" then
            UIParent:SetScale(scale)
        end
    end

    if AlomawaniQoLData.Configs["MaxOutCameraDistance"] then
        SetCVar('cameraDistanceMaxZoomFactor', 2.6)
    end
end

function Graphics:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.System.Graphics = Graphics
