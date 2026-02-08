---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

local L = setmetatable({}, { __index = function(t, k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end })

AlomawaniQoL.L = L
