local _, AlomawaniQoL = ...

--Lua API
local select = select

-- WoW API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local FindPetIDByName = C_PetJournal.FindPetIDByName
local SummonPetByGUID = C_PetJournal.SummonPetByGUID
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local CreateFrame = CreateFrame
local IsStealthed = IsStealthed

local BattlePet = CreateFrame('Frame')

function BattlePet:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["KeepABattlePetSummoned"] and AlomawaniQoLData.Configs["BattlePetNameToSummon"] ~= "" then
        local instanceType = select(2, IsInInstance())
        if InCombatLockdown('player') or IsStealthed() or instanceType == 'pvp' or instanceType == 'arena' then
            return
        end

        local _, petGUID = FindPetIDByName(AlomawaniQoLData.Configs["BattlePetNameToSummon"])
        if petGUID and GetSummonedPetGUID() ~= petGUID then
            SummonPetByGUID(petGUID)
        end
    end
end

function BattlePet:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('COMPANION_UPDATE')
    self:RegisterEvent('ZONE_CHANGED')
    self:RegisterEvent('ZONE_CHANGED_INDOORS')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.Gameplay.BattlePet = BattlePet
