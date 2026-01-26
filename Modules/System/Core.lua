local _, AlomawaniQoL = ...

-- WoW API
local CreateFrame = CreateFrame

local System = CreateFrame('Frame')

function System:Enable()
    self.Graphics:Enable()
end

AlomawaniQoL.System = System
