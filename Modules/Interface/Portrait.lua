local _, AlomawaniQoL = ...

-- WoW API
local RegisterAttributeDriver = RegisterAttributeDriver
local GetSpecializationRole = GetSpecializationRole
local GetSpecialization = GetSpecialization
local CreateFrame = CreateFrame

local Portrait = CreateFrame('Frame')

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

function Portrait:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.Interface.Portrait = Portrait
