local _, addon = ...
local T, C, L = addon[1], addon[2], addon[3]
local Loading = CreateFrame('Frame')

function Loading:OnEvent(event)
	if (event == 'PLAYER_LOGIN') then
		T['System']:Enable()
        T['Interface']:Enable()
	end
end

Loading:RegisterEvent('PLAYER_LOGIN')
Loading:SetScript('OnEvent', Loading.OnEvent)

T['Loading'] = Loading
