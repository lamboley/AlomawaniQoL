local _, AlomawaniQoL = ...

-- WoW API
local NewTicker = C_Timer.NewTicker
local After = C_Timer.After

local ThichNhatHanh = AlomawaniQoL.CreateModule("ThichNhatHanh", "PLAYER_ENTERING_WORLD")

function ThichNhatHanh:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] then
        NewTicker(2000, function()
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I know I am breathing in.|r")
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I know I am breathing out.|r")

            After(60, function()
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00As my in-breath grows deep,|r")
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00My out-breath grows slow.|r")

                After(60, function()
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I am aware of my body.|r")
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I calm my body.|r")

                    After(60, function()
                        DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Dwelling in the present moment,|r")
                        DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00I know this is a wonderful moment.|r")
                    end)
                end)
            end)
        end)
    end
end

AlomawaniQoL.Gameplay.ThichNhatHanh = ThichNhatHanh
