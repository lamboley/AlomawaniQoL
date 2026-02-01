local _, AlomawaniQoL = ...

-- Lua API
local select = select

-- WoW API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID
local ReloadUI = ReloadUI

SLASH_AlomawaniQoL1 = "/alomawaniqol"
SLASH_AlomawaniQoL2 = "/aql"

SlashCmdList["AlomawaniQoL"] = function(msg)
    if msg == "debug" then
        AlomawaniQoL.Print(AlomawaniQoLData.Configs["DisableDamageText"])
    elseif msg == "pet" then
        local summonedPetGUID = GetSummonedPetGUID()
        if summonedPetGUID then
            local petName = select(8, GetPetInfoByPetID(summonedPetGUID))
            AlomawaniQoL.Print(petName)
        else
            AlomawaniQoL.Print("There is not battle pet summoned.")
        end
    elseif msg == "h" or msg == "help" then
        AlomawaniQoL.Print("Command usage:")
        print("|cff00ff00/aql|r - Toggle options menu")
        print("|cff00ff00/aql pet|r - Display currently summoned battle pet name")
        print("|cff00ff00/aql help|r - Show this help message")
    else
        AlomawaniQoL.AlomawaniQoLGui:ToggleOptions()
    end
end

SLASH_RELOADUI1 = "/rel"
SlashCmdList.RELOADUI = ReloadUI
