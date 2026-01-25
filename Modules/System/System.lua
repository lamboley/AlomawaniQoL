local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]
local System = T['System']

function System:Enable()
    self.Graphics:Enable()
end
