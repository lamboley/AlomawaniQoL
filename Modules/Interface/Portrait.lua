local _, AlomawaniQoL = ...

-- WoW API
local RegisterAttributeDriver = RegisterAttributeDriver
local GetSpecializationRole = GetSpecializationRole
local GetSpecialization = GetSpecialization

local Portrait = AlomawaniQoL.CreateModule("Portrait", {
    "PLAYER_ENTERING_WORLD",
    "PLAYER_SPECIALIZATION_CHANGED"
})

function Portrait:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["HidePlayerPortraitWhenHeal"] then
        local currentSpec = GetSpecialization()
        if currentSpec then
            local roleToken = GetSpecializationRole(currentSpec)
            if roleToken and roleToken == 'HEALER' then
                RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'hide;hide')
            else
                RegisterAttributeDriver(PlayerFrame, 'state-visibility', 'show;show')
            end
        end
    end
end

AlomawaniQoL.Interface.Portrait = Portrait
