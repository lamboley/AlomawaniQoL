---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

--Lua API
local select = select

-- WoW API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local FindPetIDByName = C_PetJournal.FindPetIDByName
local SummonPetByGUID = C_PetJournal.SummonPetByGUID
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local IsStealthed = IsStealthed
local GetTime = GetTime

---@class BattlePet : table
---@field OnEvent fun(event: string, any)
local BattlePet = AlomawaniQoL.CreateModule("BattlePet", {
    "PLAYER_ENTERING_WORLD",
    "COMPANION_UPDATE",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA"
})

---@type number
local lastSummonAttempt = 0

function BattlePet:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["KeepABattlePetSummoned"] or AlomawaniQoLData.Configs["BattlePetNameToSummon"] == "" then
        return
    end

    local currentTime = GetTime()
    if currentTime - lastSummonAttempt < 10 then
        return
    end

    local instanceType = select(2, IsInInstance())
    if InCombatLockdown() or IsStealthed() or instanceType == 'pvp' or instanceType == 'arena' then
        return
    end

    local _, petGUID = FindPetIDByName(AlomawaniQoLData.Configs["BattlePetNameToSummon"])
    if petGUID and GetSummonedPetGUID() ~= petGUID then
        SummonPetByGUID(petGUID)
        lastSummonAttempt = currentTime
    end
end

AlomawaniQoL.Gameplay.BattlePet = BattlePet
