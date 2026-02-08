---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- WoW API
local RegisterAttributeDriver = RegisterAttributeDriver
local GetSpecializationRole = GetSpecializationRole
local GetSpecialization = GetSpecialization

---@class Portrait : table
---@field OnEvent fun(event: string, any)
local Portrait = AlomawaniQoL.CreateModule("Portrait", {
    "PLAYER_ENTERING_WORLD",
    "PLAYER_SPECIALIZATION_CHANGED"
})

local lastPortraitState = nil

function Portrait:OnEvent(event, ...)
    if not AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] then
        if lastPortraitState == 'hidden' then
            RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
            lastPortraitState = 'shown'
        end
        return
    end

    local currentSpec = GetSpecialization()
    if currentSpec then
        local roleToken = GetSpecializationRole(currentSpec)
        if roleToken then
            local desiredState = (roleToken == 'HEALER') and 'hidden' or 'shown'

            if lastPortraitState ~= desiredState then
                if desiredState == 'hidden' then
                    RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'hide;hide')
                else
                    RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
                end
                lastPortraitState = desiredState
            end
        end
    end
end

AlomawaniQoL.Interface.Portrait = Portrait
