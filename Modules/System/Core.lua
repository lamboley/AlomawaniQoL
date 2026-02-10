---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

---@class System : Frame
---@field Enable fun(self: System)
---@field Audio Audio
---@field Graphics Graphics
local System = CreateFrame("Frame")

function System:Enable()
    self.Audio:Enable()
    self.Graphics:Enable()
end

AlomawaniQoL.System = System
