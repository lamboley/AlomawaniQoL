local _, AlomawaniQoL = ...

local Gameplay = CreateFrame('Frame')

function Gameplay:OnEvent(_, ...)
    if AlomawaniQoLData.Configs["DisableRightClickTargeting"] then
        local statusMouseover = CreateFrame('frame', nil, nil, 'SecureHandlerStateTemplate')
        RegisterStateDriver(statusMouseover, 'mouseunitexist', '[@mouseover,exists]1;0')
        statusMouseover:SetAttribute('_onstate-mouseunitexist', [[
            if newstate == 1 then
                self:SetBindingClick(1,'BUTTON2','ButtonMouselookFrame')
            else
                self:ClearBindings()
            end
        ]])

        local ButtonMouselookFrame = CreateFrame('button', 'ButtonMouselookFrame')
        ButtonMouselookFrame:RegisterForClicks('AnyDown', 'AnyUp')
        ButtonMouselookFrame:SetScript('OnClick', function(_, _, down)
            if down then
                MouselookStart()
            else
                MouselookStop()
            end
        end)
    end
end

function Gameplay:Enable()
    self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', self.OnEvent)

    self.Vendor:Enable()
end

AlomawaniQoL['Gameplay'] = Gameplay
