local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]
local Interface = T['Interface']

function Interface:Enable()
    self.Quests:Enable()
    self.Social:Enable()
end
