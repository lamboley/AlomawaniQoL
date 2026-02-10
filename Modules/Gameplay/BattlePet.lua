---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local FindPetIDByName = C_PetJournal.FindPetIDByName
local SummonPetByGUID = C_PetJournal.SummonPetByGUID
local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local IsStealthed = IsStealthed
local GetTime = GetTime
local select = select

---@type Gameplay
local Gameplay = AlomawaniQoL.Gameplay

---@class BattlePet : Frame
---@field OnEvent fun(self: BattlePet, event: WowEvent, ...: any)
---@field Enable fun(self: Vendor)
local BattlePet = CreateFrame("Frame")

---@type number
local lastSummonAttempt = 0

---@param _ WowEvent
---@param ... any
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

function BattlePet:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("COMPANION_UPDATE")
	self:RegisterEvent("ZONE_CHANGED")
	self:RegisterEvent("ZONE_CHANGED_INDOORS")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:SetScript("OnEvent", self.OnEvent)
end

Gameplay.BattlePet = BattlePet
