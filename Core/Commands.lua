local _, AlomawaniQoL = ...

SLASH_AlomawaniQoL1 = "/alomawaniqol"
SLASH_AlomawaniQoL2 = "/aql"

SlashCmdList["AlomawaniQoL"] = function(msg)
    if msg == "debug" then
        AlomawaniQoL.Print("debug")
        AlomawaniQoL.Print(AlomawaniQoLData.Configs["DisableRightClickTargeting"])
    else
        AlomawaniQoL.AlomawaniQoLGui:ToggleOptions()
    end
end
