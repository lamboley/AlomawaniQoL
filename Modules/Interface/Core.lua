local _, AlomawaniQoL = ...

-- WoW API
local UnitAffectingCombat = UnitAffectingCombat
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame
local SetCVar = SetCVar

local Interface = CreateFrame('Frame')

function Interface:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["DisableDamageText"] then
        SetCVar('floatingCombatTextCombatHealing', 0)
        SetCVar('floatingCombatTextCombatDamage', 0)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
        SetCVar('floatingCombatTextPetMeleeDamage', 0)
        SetCVar('floatingCombatTextPetSpellDamage', 0)
        SetCVar('floatingCombatTextCombatHealing_v2', 0)
        SetCVar('floatingCombatTextCombatDamage_v2', 0)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells_v2', 0)
        SetCVar('floatingCombatTextPetMeleeDamage_v2', 0)
        SetCVar('floatingCombatTextPetSpellDamage_v2', 0)
    else
        SetCVar('floatingCombatTextCombatHealing', 1)
        SetCVar('floatingCombatTextCombatDamage', 1)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 1)
        SetCVar('floatingCombatTextPetMeleeDamage', 1)
        SetCVar('floatingCombatTextPetSpellDamage', 1)
    end

    if AlomawaniQoLData.Configs["HideTooltipWhileInCombat"] then
		hooksecurefunc(GameTooltip, 'Show', function(self)
			if UnitAffectingCombat('player') then
				self:Hide()
			end
		end)
    end
end

function Interface:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)

    self.Quests:Enable()
    self.Social:Enable()
    self.Portrait:Enable()
end

AlomawaniQoL.Interface = Interface
