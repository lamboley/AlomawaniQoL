local _, AlomawaniQoL = ...

SLASH_AlomawaniQoL1 = "/alomawaniqol"
SLASH_AlomawaniQoL2 = "/aql"

SlashCmdList["AlomawaniQoL"] = function(msg)
    if msg == "debug" then
        AlomawaniQoL.Print("debug")
    else
        AlomawaniQoL.AlomawaniQoLGui:ToggleOptions()
    end
end
