local _, AlomawaniQoL = ...

--Lua API
local select = select

-- WoW API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local FindPetIDByName = C_PetJournal.FindPetIDByName
local SummonPetByGUID = C_PetJournal.SummonPetByGUID
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local IsStealthed = IsStealthed

local BattlePet = AlomawaniQoL.CreateModule("BattlePet", {
    "PLAYER_ENTERING_WORLD",
    "COMPANION_UPDATE",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA"
})

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

AlomawaniQoL.Gameplay.BattlePet = BattlePet
