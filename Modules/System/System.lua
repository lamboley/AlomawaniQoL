---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

---@class System : Frame
---@field Graphics Graphics
---@field Audio Audio
---@field OnEvent fun(self: System, event: WowEvent, ...: any)
---@field PostEnable fun(self: System)
---@field PostDisable fun(self: System)
local System = AlomawaniQoL.CreateModule("System", "PLAYER_ENTERING_WORLD")

---@param _ WowEvent
---@param ... any
function System:OnEvent(_, ...)
end

function System:PostEnable()
    self.Graphics:Enable()
    self.Audio:Enable()
end

function System:PostDisable()
    self.Graphics:Disable()
    self.Audio:Disable()
end

AlomawaniQoL.System = System
