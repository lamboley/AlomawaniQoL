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
local GetTime = GetTime

local BattlePet = AlomawaniQoL.CreateModule("BattlePet", {
    "PLAYER_ENTERING_WORLD",
    "COMPANION_UPDATE",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA"
})

local lastSummonAttempt = 0

local cachedPetName = nil
local cachedPetGUID = nil

function BattlePet:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["KeepABattlePetSummoned"] or AlomawaniQoLData.Configs["BattlePetNameToSummon"] == "" then
        return
    end

    local currentTime = GetTime()
    if currentTime - lastSummonAttempt < 2 then
        AlomawaniQoL.Debug("time")
        return
    end

    local instanceType = select(2, IsInInstance())
    if InCombatLockdown('player') or IsStealthed() or instanceType == 'pvp' or instanceType == 'arena' then
        AlomawaniQoL.Debug("instanceType")
        return
    end

    local configuredPetName = AlomawaniQoLData.Configs["BattlePetNameToSummon"]
    if cachedPetName ~= configuredPetName then
        AlomawaniQoL.Debug("cachedPetName ~= configuredPetName")
        local _, petGUID = FindPetIDByName(configuredPetName)
        cachedPetName = configuredPetName
        cachedPetGUID = petGUID
    end

    if cachedPetGUID and GetSummonedPetGUID() ~= cachedPetGUID then
        SummonPetByGUID(cachedPetGUID)
        lastSummonAttempt = currentTime
        AlomawaniQoL.Debug("Summoned battle pet:", cachedPetName)
    end
end

AlomawaniQoL.Gameplay.BattlePet = BattlePet
