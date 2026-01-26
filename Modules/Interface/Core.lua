local _, AlomawaniQoL = ...

local Interface = CreateFrame('Frame')

function Interface:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["DisableDamageText"] then
        SetCVar('floatingCombatTextCombatHealing', 0)
        SetCVar('floatingCombatTextCombatDamage', 0)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
        SetCVar('floatingCombatTextPetMeleeDamage', 0)
        SetCVar('floatingCombatTextPetSpellDamage', 0)
    else
        SetCVar('floatingCombatTextCombatHealing', 1)
        SetCVar('floatingCombatTextCombatDamage', 1)
        SetCVar('floatingCombatTextCombatLogPeriodicSpells', 1)
        SetCVar('floatingCombatTextPetMeleeDamage', 1)
        SetCVar('floatingCombatTextPetSpellDamage', 1)
    end
end

function Interface:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)

    self.Quests:Enable()
    self.Social:Enable()
end

AlomawaniQoL.Interface = Interface
