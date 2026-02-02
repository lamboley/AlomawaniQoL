local _, AlomawaniQoL = ...

--Lua API

-- WoW API
local CreateFrame = CreateFrame

local ThichNhatHanh = CreateFrame('Frame')

function ThichNhatHanh:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["PrintQuoteFromThichNhatHanh"] then
        C_Timer.NewTicker(2000, function()
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I know I am breathing in.|r")
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I know I am breathing out.|r")

            C_Timer.After(60, function()
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00As my in-breath grows deep,|r")
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00My out-breath grows slow.|r")

                C_Timer.After(60, function()
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing in, I am aware of my body.|r")
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Breathing out, I calm my body.|r")

                    C_Timer.After(60, function()
                        DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00Dwelling in the present moment,|r")
                        DEFAULT_CHAT_FRAME:AddMessage("|cffFF9FFFThich Nhat Hanh says:|r |cffFFFF00I know this is a wonderful moment.|r")
                    end)
                end)
            end)
        end)
    end
end

function ThichNhatHanh:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.Gameplay.ThichNhatHanh = ThichNhatHanh
