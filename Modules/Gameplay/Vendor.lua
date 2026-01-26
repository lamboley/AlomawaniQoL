local _, AlomawaniQoL = ...

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
