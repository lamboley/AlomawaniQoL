local _, AlomawaniQoL = ...

-- WoW API
local CanMerchantRepair = CanMerchantRepair
local RepairAllItems = RepairAllItems
local CreateFrame = CreateFrame

local Vendor = CreateFrame('Frame')

function Vendor:OnEvent(event, ...)
    if AlomawaniQoLData.Configs["EnableRepairAutomatic"] and CanMerchantRepair() then
        RepairAllItems()
    end
end

function Vendor:Enable()
	self:RegisterEvent('MERCHANT_SHOW')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.Gameplay.Vendor = Vendor
