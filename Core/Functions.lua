local _, AlomawaniQoL = ...

-- Lua API
local print = print

function AlomawaniQoL.Print(...)
	print("Alomawani QoL:", ...)
end

function AlomawaniQoL.Debug(...)
	if AlomawaniQoLData.Configs["Debug"] then
		print("Alomawani QoL:", ...)
	end
end
