---@class AlomawaniQoL
local AlomawaniQoL = select(2, ...)

local System = AlomawaniQoL.CreateModule("System", "PLAYER_ENTERING_WORLD")

function System:OnEvent(event, ...)
    -- Placeholder for future system-level event handling
    -- This ensures consistent architecture across all Core modules
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
