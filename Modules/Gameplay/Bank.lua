---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local WithdrawMoney = C_Bank.WithdrawMoney
local DepositMoney = C_Bank.DepositMoney
local UnitFullName = UnitFullName
local smatch = string.match
local tonumber = tonumber
local GetMoney = GetMoney
local ssub = string.sub
local slen = string.len

---@class Bank : Frame
---@field OnEvent fun(self: Bank, event: WowEvent, ...: any)
local Bank = AlomawaniQoL.CreateModule("Bank", "BANKFRAME_OPENED")

---@param _ WowEvent
---@param ... any
function Bank:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["DepositGoldInWarbandBank"] or AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"] == "" then
        return
    end

    local amountToKeep = tonumber(AlomawaniQoLData.Configs["QuantityOfGoldToKeepInInventory"])*10000
    if amountToKeep then
        AlomawaniQoL.Print("if amountToKeep")
        local money = GetMoney()
        if (money > amountToKeep) then
            DepositMoney(2, money-amountToKeep)
        elseif (money < amountToKeep) then
            WithdrawMoney(2, amountToKeep-money)
        end
    end

end

AlomawaniQoL.Gameplay.Bank = Bank
