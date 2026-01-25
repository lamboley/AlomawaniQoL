local _, AQL = ...
local Gameplay = AQL['Interface']

local Vendor = CreateFrame('Frame')

function Vendor:OnEvent(event, ...)
    if AQLDB.Configs["EnableRepairAutomatic"] and CanMerchantRepair() then
        RepairAllItems()
    end
end

function Vendor:Enable()
	self:RegisterEvent('MERCHANT_SHOW')
	self:SetScript('OnEvent', self.OnEvent)
end

Gameplay.Vendor = Vendor
