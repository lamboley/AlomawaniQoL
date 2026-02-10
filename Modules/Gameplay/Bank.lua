---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local WithdrawMoney = C_Bank.WithdrawMoney
local DepositMoney = C_Bank.DepositMoney
local tonumber = tonumber
local GetMoney = GetMoney

---@type Gameplay
local Gameplay = AlomawaniQoL.Gameplay

---@class Bank : Frame
---@field OnEvent fun(self: Bank, event: WowEvent, ...: any)
---@field Enable fun(self: Bank)
local Bank = CreateFrame("Frame")

---@param _ WowEvent
---@param ... any
function Bank:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["DepositGoldInWarbandBank"] or AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"] == "" then
        return
    end

    local amountToKeep = tonumber(AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"])*10000
    if amountToKeep then
        local money = GetMoney()
        if (money > amountToKeep) then
            DepositMoney(2, money-amountToKeep)
        elseif (money < amountToKeep) then
            WithdrawMoney(2, amountToKeep-money)
        end
    end

end

function Bank:Enable()
	self:RegisterEvent("BANKFRAME_OPENED")
	self:SetScript("OnEvent", self.OnEvent)
end

Gameplay.Bank = Bank
