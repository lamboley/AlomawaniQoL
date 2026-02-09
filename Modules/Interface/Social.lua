---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local _G = _G

---@class Social : Frame
---@field OnEvent fun(self: Social, event: WowEvent, ...: any)
local Social = AlomawaniQoL.CreateModule("Social", "PLAYER_ENTERING_WORLD")

---@param event WowEvent
---@param ... any
function Social:OnEvent(event, ...)
	DEFAULT_CHATFRAME_ALPHA = 0
	CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0.2

	ChatFrame1:ClearAllPoints()
	ChatFrame1:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 0, 0)

	for i = 1, #CHAT_FRAMES do
		local frameName = "ChatFrame" .. i

		local chatFrame = _G[frameName]
		if chatFrame then
			chatFrame:SetClampedToScreen(not AlomawaniQoLData.Configs["DisableChatClamping"])
			chatFrame:SetClampRectInsets(0, 0, 0, 0)
			chatFrame:SetScale(1.1)

			local chatFrameXTab = _G[frameName .. 'Tab']
			if chatFrameXTab then
				chatFrameXTab:SetScale(1.1)
			end

			local editBox = _G[frameName .. 'EditBox']
			if editBox then
				editBox:ClearAllPoints()
				editBox:SetPoint('BOTTOMLEFT', editBox.chatFrame, 'TOPLEFT', 0, 3)
				editBox:SetPoint('BOTTOMRIGHT', editBox.chatFrame, 'TOPRIGHT', editBox.chatFrame.ScrollBar:GetWidth(), 3)
				editBox:SetScale(1.1)
			end
		end
	end

	QuickJoinToastButton:SetScale(1.1)
end

AlomawaniQoL.Interface.Social = Social
