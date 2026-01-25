local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]

local DF = _G["DetailsFramework"]

local AlomawaniQoLUIOptions = {}
local AlomawaniQoLUI = DF:CreateSimplePanel(UIParent, 1000, 1000, "AlomawaniQoL", "AlomawaniQoLUI", AlomawaniQoLUIOptions)
