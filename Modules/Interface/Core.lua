---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local UnitAffectingCombat = UnitAffectingCombat
local hooksecurefunc = hooksecurefunc
local SetCVar = SetCVar
local ipairs = ipairs

---@class Interface : Frame
---@field Enable fun(self: Interface)
---@field Portrait Portrait
---@field Quests Quests
---@field Social Social
local Interface = CreateFrame("Frame")

---@type string[]
local floatingCombatTextCVars = {
    'floatingCombatTextCombatHealing',
    'floatingCombatTextCombatDamage',
    'floatingCombatTextCombatLogPeriodicSpells',
    'floatingCombatTextPetMeleeDamage',
    'floatingCombatTextPetSpellDamage',
    'floatingCombatTextCombatHealing_v2',
    'floatingCombatTextCombatDamage_v2',
    'floatingCombatTextCombatLogPeriodicSpells_v2',
    'floatingCombatTextPetMeleeDamage_v2',
    'floatingCombatTextPetSpellDamage_v2',
}

function Interface:Enable()
    if AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] then
        hooksecurefunc(GameTooltip, 'Show', function(self)
            if UnitAffectingCombat('player') then
                self:Hide()
            end
        end)
    end

    local value = AlomawaniQoLData.Configs["DisableDamageText"] and 0 or 1
    for _, cvar in ipairs(floatingCombatTextCVars) do
        SetCVar(cvar, value)
    end

    self.Portrait:Enable()
    self.Quests:Enable()
    self.Social:Enable()
end

AlomawaniQoL.Interface = Interface
