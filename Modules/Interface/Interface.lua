---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Lua API
local ipairs = ipairs

-- WoW API
local UnitAffectingCombat = UnitAffectingCombat
local hooksecurefunc = hooksecurefunc
local SetCVar = SetCVar

---@class Interface : table
---@field Portrait Portrait
---@field Quests Quests
---@field Social Social
---@field OnEvent fun(event: string, any)
---@field PreEnable fun()
---@field PostEnable fun()
---@field PostDisable fun()
local Interface = AlomawaniQoL.CreateModule("Interface", "PLAYER_ENTERING_WORLD")

local tooltipHookRegistered = false

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
function Interface:PreEnable()
    if AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] and not tooltipHookRegistered then
        hooksecurefunc(GameTooltip, 'Show', function(self)
            if UnitAffectingCombat('player') then
                self:Hide()
            end
        end)
        tooltipHookRegistered = true
    end
end

function Interface:OnEvent(event, ...)
    local value = AlomawaniQoLData.Configs["DisableDamageText"] and 0 or 1
    for _, cvar in ipairs(floatingCombatTextCVars) do
        SetCVar(cvar, value)
    end
end

function Interface:PostEnable()
    self.Quests:Enable()
    self.Social:Enable()
    self.Portrait:Enable()
end

function Interface:PostDisable()
    self.Quests:Disable()
    self.Social:Disable()
    self.Portrait:Disable()
end

AlomawaniQoL.Interface = Interface
