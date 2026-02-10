---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetNumLootItems = GetNumLootItems
local LootSlot = LootSlot

---@class Gameplay : Frame
---@field Bank Bank
---@field BattlePet BattlePet
---@field ThichNhatHanh ThichNhatHanh
---@field Vendor Vendor
---@field Voice Voice
---@field OnEvent fun(self: Gameplay, event: WowEvent, ...: any)
---@field Enable fun(self: Gameplay)
local Gameplay = CreateFrame("Frame")

---@type boolean
local mouselookInitialized = false

---@param event WowEvent
---@param ... any
function Gameplay:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["FasterAutoLoot"] then
        LootFrame:SetAlpha(0)
        for i = 1, GetNumLootItems() do
            LootSlot(i)
        end
    end
end

function Gameplay:Enable()
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
    end

    self.Vendor:Enable()
    self.Voice:Enable()
    self.ThichNhatHanh:Enable()
    self.BattlePet:Enable()
    self.Bank:Enable()

	self:RegisterEvent("LOOT_READY")
	self:SetScript("OnEvent", self.OnEvent)
end

AlomawaniQoL.Gameplay = Gameplay
