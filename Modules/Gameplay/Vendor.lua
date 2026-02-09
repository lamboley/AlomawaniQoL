---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetContainerItemInfo = C_Container.GetContainerItemInfo
local GetContainerNumSlots = C_Container.GetContainerNumSlots
local GetContainerItemID = C_Container.GetContainerItemID
local UseContainerItem = C_Container.UseContainerItem
local CanMerchantRepair = CanMerchantRepair
local RepairAllItems = RepairAllItems
local GetGuildInfo = GetGuildInfo
local select = select

---@class Vendor : Frame
---@field OnEvent fun(self: Vendor, event: WowEvent, ...: any)
local Vendor = AlomawaniQoL.CreateModule("Vendor", "MERCHANT_SHOW")

---@param _ WowEvent
---@param ... any
function Vendor:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["RepairGearAutomatically"] and CanMerchantRepair() then
        if AlomawaniQoLData.Configs["UseGuildBankForRepair"] and select(1, GetGuildInfo('player')) then
            RepairAllItems(true)
        end
        RepairAllItems()
    end

    if AlomawaniQoLData.Configs["SellJunkAutomatically"] then
        for bagID = 0, NUM_BAG_SLOTS do
            local numSlots = GetContainerNumSlots(bagID)
            if numSlots then
                for slot = 1, numSlots do
                    local itemID = GetContainerItemID(bagID, slot)
                    if itemID then
                        local containerInfo = GetContainerItemInfo(bagID, slot)
                        if containerInfo and not containerInfo.isLocked and containerInfo.iconFileID and containerInfo.quality == 0 then
                            UseContainerItem(bagID, slot)
                        end
                    end
                end
            end
        end
    end
end

AlomawaniQoL.Gameplay.Vendor = Vendor
