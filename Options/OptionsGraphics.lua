local _, AlomawaniQoL = ...

local Graphics = AlomawaniQoL:GetModule('Graphics')

local function myGetterFunc(info)
    return Graphics.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    Graphics.db.profile[info[#info]] = value
end

function Graphics:SetupOptions()
    if not self.modulesoptions then
        local enabled = {
            type = 'toggle',
            order = 1,
            name = 'Enabled',
            desc = 'Graphics',
            get = function() return self.db.profile.enabled end,
            set = 'ToggleModule',
            handler = self,
            width = 'full',
        }

        self.modulesoptions = {
            enabled = enabled,
            header1 = {
                order = 2,
                type = 'header',
                name = 'General',
                width = 'full',
            },
            customScaleToggle = {
                order = 3,
                type = 'toggle',
                name = 'Use custom scale',
                set = mySetterFunc,
                get = myGetterFunc,
            },
            customScaleValue = {
                order = 4,
                type = 'input',
                name = 'Custom scale value',
                get = myGetterFunc,
                set = mySetterFunc,
            },
            maxCameraZoomToggle = {
                order = 5,
                type = 'toggle',
                name = 'Max camera zoom',
                set = mySetterFunc,
                get = myGetterFunc,
            },
            maxCameraZoomValue = {
                order = 6,
                name = 'Max camera zoom value',
                desc = 'Configure the max camera zoom value. Default: 2.6',
                type = 'input',
                get = myGetterFunc,
                set = mySetterFunc,
            },
        }

        self.disabledoptions = {
            enabled = enabled,
        }
    end

    if not self.options then
        self.options = {
            order = 1,
            type = 'group',
            name = 'Graphics',
            childGroups = 'tab',
        }
    end

    AlomawaniQoL.options.args.system.args.Graphics = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end