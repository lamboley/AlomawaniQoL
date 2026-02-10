---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetPhysicalScreenSize = GetPhysicalScreenSize
local tonumber = tonumber
local SetCVar = SetCVar
local select = select
local max = math.max
local min = math.min

---@type System
local System = AlomawaniQoL.System

---@class Graphics : Frame
---@field Enable fun(self: Graphics)
---@field Disable fun(self: Graphics)
local Graphics = CreateFrame("Frame")

function Graphics:Enable()
    if AlomawaniQoLData.Configs["UsePerfectPixel"] then
        local screenHeight = select(2, GetPhysicalScreenSize())
        if AlomawaniQoLData.Configs["UseCustomHeight"] ~= "" then
            screenHeight = tonumber(AlomawaniQoLData.Configs["UseCustomHeight"])
        end

        local scale = max(0.4, min(1.15, (768 / screenHeight)))
        UIParent:SetScale(scale)
    end

    if AlomawaniQoLData.Configs["MaxOutCameraDistance"] then
        SetCVar('cameraDistanceMaxZoomFactor', 2.6)
    end
end

function Graphics:Disable()
    UIParent:SetScale(1)
end

System.Graphics = Graphics
