local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]
local Interface = T['Interface']

local lastRightClick = 0

local function DisableRightClick()
    local time = GetTime()
    if lastRightClick + 0.2 < time then
        lastRightClick = time
        MouselookStop()
    end
end

function Interface:OnEvent(event, ...)
    SetCVar('floatingCombatTextCombatHealing', 0)
    SetCVar('floatingCombatTextCombatDamage', 0)
    SetCVar('floatingCombatTextCombatLogPeriodicSpells', 0)
    SetCVar('floatingCombatTextPetMeleeDamage', 0)
    SetCVar('floatingCombatTextPetSpellDamage', 0)
    SetCVar('cameraIndirectVisibility', 1)

    WorldFrame:HookScript('OnMouseUp', function(_, button)
        if button == "RightButton" and not IsMouseButtonDown('RightButton') then
            if InCombatLockdown() then
                DisableRightClick()
            end
        end
    end)
end

function Interface:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)

    self.Quests:Enable()
    self.Social:Enable()
end
