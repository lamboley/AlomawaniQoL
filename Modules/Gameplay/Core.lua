local _, AlomawaniQoL = ...

-- WoW API
local GetNumLootItems = GetNumLootItems
local CreateFrame = CreateFrame
local LootSlot = LootSlot

local Gameplay = CreateFrame('Frame')

function Gameplay:OnEvent(event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        if AlomawaniQoLData.Configs["DisableRightClickTargeting"] then
            local statusMouseover = CreateFrame('frame', nil, nil, 'SecureHandlerStateTemplate')
            RegisterStateDriver(statusMouseover, 'mouseunitexist', '[@mouseover,exists]1;0')
            statusMouseover:SetAttribute('_onstate-mouseunitexist', [[
                if newstate == 1 then
                    self:SetBindingClick(1,'BUTTON2','ButtonMouselookFrame')
                else
                    self:ClearBindings()
                end
            ]])

            local ButtonMouselookFrame = CreateFrame('button', 'ButtonMouselookFrame')
            ButtonMouselookFrame:RegisterForClicks('AnyDown', 'AnyUp')
            ButtonMouselookFrame:SetScript('OnClick', function(_, _, down)
                if down then
                    MouselookStart()
                else
                    MouselookStop()
                end
            end)
        end
    elseif event == "LOOT_READY" then
        if AlomawaniQoLData.Configs["FasterAutoLoot"] then
            LootFrame:SetAlpha(0)
            for i = 1, GetNumLootItems() do
                LootSlot(i)
            end
        end
    end
end

function Gameplay:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('LOOT_READY')
	self:SetScript('OnEvent', self.OnEvent)

    self.Vendor:Enable()
    self.Voice:Enable()
    self.ThichNhatHanh:Enable()
    self.BattlePet:Enable()
end

AlomawaniQoL.Gameplay = Gameplay
