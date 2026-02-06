local _, AlomawaniQoL = ...

-- Lua API
local ipairs = ipairs
local print = print
local type = type

-- WoW API
local CreateFrame = CreateFrame

function AlomawaniQoL.Print(...)
	print("|cff00D9FFAlomawani QoL:|r", ...)
end

function AlomawaniQoL.Debug(...)
	if AlomawaniQoLData.Configs["Debug"] then
		print("|cffFFAA00Alomawani QoL:|r |cffFF6B6B[DEBUG]|r", ...)
	end
end

function AlomawaniQoL.GetConfig(key, default)
    local val = AlomawaniQoLData.Configs[key]
    if val == nil then return default end
    return val
end

function AlomawaniQoL.CreateModule(name, events)
    local module = CreateFrame('Frame', "AlomawaniQoL_" .. name)
    module.enabled = false
    module.events = type(events) == "table" and events or {events}

    function module:Enable()
        if self.enabled then return end

        if self.PreEnable then
            self:PreEnable()
        end

        for _, event in ipairs(self.events) do
            self:RegisterEvent(event)
        end
        self:SetScript('OnEvent', self.OnEvent)
        self.enabled = true

        AlomawaniQoL.Debug("Enabled module:", name)

        if self.PostEnable then
            self:PostEnable()
        end
    end

    function module:Disable()
        if not self.enabled then return end

        if self.PreDisable then
            self:PreDisable()
        end

        for _, event in ipairs(self.events) do
            self:UnregisterEvent(event)
        end
        self.enabled = false

        AlomawaniQoL.Debug("Disabled module:", name)

        if self.PostDisable then
            self:PostDisable()
        end
    end

    return module
end

