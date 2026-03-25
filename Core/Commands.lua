---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID
local GetBestMapForUnit = C_Map.GetBestMapForUnit
local ReloadUI = ReloadUI
local select = select

SLASH_AlomawaniQoL1 = "/alomawaniqol"
SLASH_AlomawaniQoL2 = "/aql"

---@param msg string
SlashCmdList["AlomawaniQoL"] = function(msg)
    if msg == "pet" then
        local summonedPetGUID = GetSummonedPetGUID()
        if summonedPetGUID then
            local petName = select(8, GetPetInfoByPetID(summonedPetGUID))
            AlomawaniQoL:Print(petName)
        else
            AlomawaniQoL:Print("There is no battle pet summoned.")
        end
    elseif msg == "zone" then
        AlomawaniQoL:Print(AlomawaniQoL.GetZoneID())
    elseif msg == "reset" then
        AlomawaniQoLData.Configs = nil
        ReloadUI()
    elseif msg == "h" or msg == "help" then
        AlomawaniQoL:Print("Command usage:")
        print("|cff00ff00/aql|r - Toggle options menu")
        print("|cff00ff00/aql pet|r - Display currently summoned battle pet name")
        print("|cff00ff00/aql reset|r - Reset all settings to default and reload")
        print("|cff00ff00/aql help|r - Show this help message")
    else
        AlomawaniQoL.AlomawaniQoLGui:ToggleOptions()
    end
end

SLASH_RELOADUI1 = "/rel"
SlashCmdList.RELOADUI = ReloadUI

function AlomawaniQoL.GetZoneID()
    return C_Map.GetBestMapForUnit('player')
end
