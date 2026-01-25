local _, AQL = ...
local Interface = AQL['Interface']



function Interface:OnEvent(event, ...)
    SetCVar('floatingCombatTextCombatHealing', 0)
    SetCVar('floatingCombatTextCombatDamage', 0)
    SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
    SetCVar('floatingCombatTextPetMeleeDamage', 0)
    SetCVar('floatingCombatTextPetSpellDamage', 0)
    SetCVar('cameraIndirectVisibility', 1)
end

function Interface:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)

    self.Quests:Enable()
    self.Social:Enable()
end
