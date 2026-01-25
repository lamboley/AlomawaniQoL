local _, AQL = ...
local Interface = AQL['Interface']

local Social = CreateFrame('Frame')

function Social:OnEvent(event, ...)
	DEFAULT_CHATFRAME_ALPHA = 0
	CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0.2

	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 0, 0)

	for i = 1, #CHAT_FRAMES do
		local chatFrame = _G["ChatFrame" .. i]
		chatFrame:SetClampedToScreen(not AQLDB.Configs["DisableChatClamping"])
		chatFrame:SetClampRectInsets(0, 0, 0, 0)
		chatFrame:SetScale(1.1)

		local chatFrameXTab = _G['ChatFrame' .. i .. 'Tab']
		chatFrameXTab:SetScale(1.1)

		local frame = _G['ChatFrame' .. i .. 'EditBox']
		frame:ClearAllPoints()
		frame:SetPoint('BOTTOMLEFT', frame.chatFrame, 'TOPLEFT', 0, 3)
		frame:SetPoint('BOTTOMRIGHT', frame.chatFrame, 'TOPRIGHT', frame.chatFrame.ScrollBar:GetWidth(), 3)
		frame:SetScale(1.1)
	end

	QuickJoinToastButton:SetScale(1.1)
end

function Social:Enable()
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)
end

Interface.Social = Social
