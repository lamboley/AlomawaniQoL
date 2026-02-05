local _, AlomawaniQoL = ...

-- WoW API
local GetNumLootItems = GetNumLootItems
local LootSlot = LootSlot

local Gameplay = AlomawaniQoL.CreateModule("Gameplay", "LOOT_READY")

local mouselookInitialized = false

function Gameplay:PreEnable()
    if AlomawaniQoLData.Configs["DisableRightClickTargeting"] and not mouselookInitialized then
        local statusMouseover = CreateFrame('frame', nil, nil, 'SecureHandlerStateTemplate')
        RegisterStateDriver(statusMouseover, 'mouseunitexist', '[@mouseover,exists,combat]1;0')
        statusMouseover:SetAttribute('_onstate-mouseunitexist', [[
            if newstate == 1 then
                self:SetBindingClick(1, 'BUTTON2','ButtonMouselookFrame')
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

        mouselookInitialized = true
        AlomawaniQoL.Debug("Mouselook bindings initialized")
    end
end

function Gameplay:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["FasterAutoLoot"] then
        LootFrame:SetAlpha(0)
        for i = 1, GetNumLootItems() do
            LootSlot(i)
        end
    end
end

function Gameplay:PostEnable()
    self.Vendor:Enable()
    self.Voice:Enable()
    self.ThichNhatHanh:Enable()
    self.BattlePet:Enable()
end

function Gameplay:PostDisable()
    self.Vendor:Disable()
    self.Voice:Disable()
    self.ThichNhatHanh:Disable()
    self.BattlePet:Disable()
end

AlomawaniQoL.Gameplay = Gameplay
