---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local SummonByID = C_MountJournal.SummonByID
local GetNumLootItems = GetNumLootItems
local CanExitVehicle = CanExitVehicle
local IsFlyableArea = IsFlyableArea
local IsInInstance = IsInInstance
local VehicleExit = VehicleExit
local IsMounted = IsMounted
local Dismount = Dismount
local LootSlot = LootSlot
local tostring = tostring
local select = select

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

local donotfly = {
    1, -- Example
}

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


-- 1048: Dark Iron Core Hound
-- 1550: Depthstalker
-- 2532: Herald of Sa'bak
function AlomawaniQoL:Mount()
    if CanExitVehicle() then
        VehicleExit()
    elseif IsMounted() then
        Dismount()
    else
        local instanceType = select(2, IsInInstance())
        if instanceType and instanceType == 'arena' then -- In Arena
            SummonByID(1048)
        elseif instanceType and instanceType == 'pvp' then -- In Battleground
            SummonByID(1048)
        elseif not IsFlyableArea() or donotfly[tostring(self.GetZoneID())] then -- Can't fly here || In blacklist
            SummonByID(1048)
        else
            SummonByID(1550)
        end
    end
end

AlomawaniQoL.Gameplay = Gameplay
