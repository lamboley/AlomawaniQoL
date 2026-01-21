local _, AlomawaniQoL = ...

local Vendors = AlomawaniQoL:NewModule('Vendors', 'AceEvent-3.0')

local defaults = {
    profile = {
        enabled = true,
        autoRepairAllItemsToggle = false,
        autoRepairUseGuildBank = false,
        autoSellAllJunksToggle = false,
    },
}

function Vendors:OnInitialize()
    self.db = AlomawaniQoL.db:RegisterNamespace('Vendors', defaults)
    self:SetEnabledState(self.db.profile.enabled)
end

function Vendors:OnEnable()
    self:ToggleOptions()
	self:ApplyConfig(self.db.profile)

    self:RegisterEvent('MERCHANT_SHOW')
end

function Vendors:OnDisable()
    self:UnregisterEvent('MERCHANT_SHOW')
    self:ToggleOptions()
end

function Vendors:ApplyConfig(config)
    if config then
        self.config = config
    end
end

function Vendors:MERCHANT_SHOW()
    local profile = self.db.profile

    if CanMerchantRepair() then
        if profile.autoRepairUseGuildBank and select(1, GetGuildInfo('player')) then
            RepairAllItems(true)
        end
        RepairAllItems()
    end

    for bagID = 0, NUM_BAG_SLOTS do
        local numSlots  = C_Container.GetContainerNumSlots(bagID)
        if numSlots then
            for slot = 1, numSlots do
                local itemID = C_Container.GetContainerItemID(bagID, slot)
                if itemID then
                    local containerInfo = C_Container.GetContainerItemInfo(bagID, slot)
                    if not containerInfo.isLocked and containerInfo.iconFileID then
                        if (containerInfo.quality and containerInfo.quality == 0) then
                            C_Container.UseContainerItem(bagID, slot)
                        end
                    end
                end
            end
        end
    end
end