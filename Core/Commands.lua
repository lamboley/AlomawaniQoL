local _, AlomawaniQoL = ...

local GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID

SLASH_AlomawaniQoL1 = "/alomawaniqol"
SLASH_AlomawaniQoL2 = "/aql"

SlashCmdList["AlomawaniQoL"] = function(msg)
    if msg == "debug" then
        AlomawaniQoL.Print("debug")
    elseif msg == "pet" then
    local summonedPetGUID = GetSummonedPetGUID()
    if summonedPetGUID then
        local petName = select(8, GetPetInfoByPetID(summonedPetGUID))
        AlomawaniQoL.Print(petName)
    else
        AlomawaniQoL.Print("There is not battle pet summoned.")
    end
    else
        AlomawaniQoL.AlomawaniQoLGui:ToggleOptions()
    end
end
