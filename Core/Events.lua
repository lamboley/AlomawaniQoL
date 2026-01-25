local _, AQL = ...

local Events = CreateFrame("Frame")
Events:RegisterEvent("ADDON_LOADED")
Events:RegisterEvent("PLAYER_ENTERING_WORLD")
Events:RegisterEvent("PLAYER_LOGIN")
Events:SetScript("OnEvent", function(self, event, ...)
    AQL:OnEvent(event, ...)
end)

function AQL:OnEvent(event, ...)
	if (event == "ADDON_LOADED") then -- ADDON_LOADED
        local name = ...
        if name == "AlomawaniQoL" then
            -- Initialize SavedVariables
            if not AQLDB then
                AQLDB = {}
            end

            -- Initialize UI
            if not AQLDB.UI then
                AQLDB.UI = {
                    scale = 1
                }
            end

            -- Initialize Configs
            if not AQLDB.Configs then
                AQLDB.Configs = {}
            end

            AQLDB.Configs["ObjectiveTrackerScale"] = AQLDB.Configs["ObjectiveTrackerScale"] or 1.0
            AQLDB.Configs["UIParentScale"] = AQLDB.Configs["UIParentScale"] or (768/1440)
        end
	elseif (event == "PLAYER_ENTERING_WORLD") then -- PLAYER_ENTERING_WORLD
	elseif (event == "PLAYER_LOGIN") then -- PLAYER_LOGIN
        -- Modules
		AQL["System"]:Enable()
        AQL["Interface"]:Enable()
    end
end
