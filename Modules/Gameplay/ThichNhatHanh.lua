local _, AlomawaniQoL = ...

-- WoW API
local NewTicker = C_Timer.NewTicker
local After = C_Timer.After

local ThichNhatHanh = AlomawaniQoL.CreateModule("ThichNhatHanh", "PLAYER_ENTERING_WORLD")

local quoteTicker = nil

function ThichNhatHanh:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] then
        if quoteTicker then
            quoteTicker:Cancel()
            AlomawaniQoL.Debug("Cancelled previous Thich Nhat Hanh ticker")
        end

        quoteTicker = NewTicker(2000, function()
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
        AlomawaniQoL.Debug("Started Thich Nhat Hanh quote ticker")
    end
end

function ThichNhatHanh:PreDisable()
    if quoteTicker then
        quoteTicker:Cancel()
        quoteTicker = nil
        AlomawaniQoL.Debug("Stopped Thich Nhat Hanh quote ticker")
    end
end

AlomawaniQoL.Gameplay.ThichNhatHanh = ThichNhatHanh
