---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local RegisterAttributeDriver = RegisterAttributeDriver
local GetSpecializationRole = GetSpecializationRole
local GetSpecialization = GetSpecialization

---@type Interface
local Interface = AlomawaniQoL.Interface

---@class Portrait : Frame
---@field OnEvent fun(self: Portrait, event: WowEvent, ...: any)
---@field Enable fun(self: Portrait)
---@field Disable fun(self: Portrait)
local Portrait = CreateFrame("Frame")

---@param event WowEvent
---@param ... any
function Portrait:OnEvent(event, ...)
    -- TODO: Check PLAYER_ENTERING_WORLD for InitialLogin and make a function to be called easly
    if not AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] then
        return
    end

    local currentSpec = GetSpecialization()
    if currentSpec then
        local roleToken = GetSpecializationRole(currentSpec)
        if roleToken then
            local desiredState = (roleToken == 'HEALER') and 'hidden' or 'shown'
            if desiredState == 'hidden' then
                RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'hide;hide')
            else
                RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
            end
        end
    end
end

function Portrait:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:SetScript("OnEvent", self.OnEvent)
end

function Portrait:Disable()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	self:SetScript("OnEvent", self.OnEvent)

    RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
end

Interface.Portrait = Portrait
