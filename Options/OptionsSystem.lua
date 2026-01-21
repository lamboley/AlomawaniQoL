local _, AlomawaniQoL = ...

local System = AlomawaniQoL:GetModule('System')

local function myGetterFunc(info)
    return System.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    System.db.profile[info[#info]] = value
end

function System:SetupOptions()
    if not self.options then
        local enabled = {
            type = 'toggle',
            order = 1,
            name = 'Enabled',
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
                name = 'System scale',
                width = 'full',
            },
            customScaleToggle = {
                order = 3,
                type = 'toggle',
                name = 'Enable custom system scale',
                set = mySetterFunc,
                get = myGetterFunc,
                width = 'full',
            },
            customScaleValue = {
                order = 4,
                type = 'input',
                name = 'Custom system scale value',
                desc = 'Need a /reload',
                get = myGetterFunc,
                set = mySetterFunc,
            },
            spacer1 = {
                order = 5,
                type = 'description',
                name = '',
                width = 'full',
            },
            header2 = {
                order = 6,
                type = 'header',
                name = 'Max camera zoom',
                width = 'full',
            },
            maxCameraZoomToggle = {
                order = 7,
                type = 'toggle',
                name = 'Configure max camera zoom',
                set = mySetterFunc,
                get = myGetterFunc,
                width = 'full',
            },
            maxCameraZoomValue = {
                order = 8,
                name = 'Max camera zoom value',
                desc = 'Need a /reload. Default: 2.6',
                type = 'input',
                get = myGetterFunc,
                set = mySetterFunc,
            },
        }

        self.disabledoptions = {
            enabled = enabled,
        }
    end


    self.options = {
        order = 99,
        type = 'group',
        name = 'System & Graphics',
        arg = 'System',
    }

    AlomawaniQoL.options.args.system = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end