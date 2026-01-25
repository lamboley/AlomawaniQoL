local _, AQL = ...

SLASH_AQL1 = "/aql"

SlashCmdList["AQL"] = function(msg)
    if msg == "debug" then
        AQL.Print("debug")
        AQL.Print(AQLDB.Configs["DisableRightClickTargeting"])
    else
        AQL.AQLUI:ToggleOptions()
    end
end
