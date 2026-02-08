---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Lua API
local tonumber = tonumber
local select = select
local max = math.max
local min = math.min

-- WoW API
local GetPhysicalScreenSize = GetPhysicalScreenSize
local SetCVar = SetCVar

---@class Graphics : table
---@field OnEvent fun(event: string, any)
local Graphics = AlomawaniQoL.CreateModule("Graphics", "PLAYER_ENTERING_WORLD")

function Graphics:OnEvent(_, ...)
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

AlomawaniQoL.System.Graphics = Graphics
