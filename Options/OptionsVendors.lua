local _, AlomawaniQoL = ...

local Vendors = AlomawaniQoL:GetModule('Vendors')

local function myGetterFunc(info)
    return Vendors.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    Vendors.db.profile[info[#info]] = value
end


function Vendors:SetupOptions()
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
                name = 'Repair',
                width = 'full',
            },
            autoRepairAllItemsToggle = {
                order = 3,
                type = 'toggle',
                name = 'Automatically repair all items',
                set = mySetterFunc,
                get = myGetterFunc,
                width = 'full',
            },
            autoRepairUseGuildBank = {
                order = 4,
                type = 'toggle',
                name = 'Use guild bank funds for repairs',
                set = mySetterFunc,
                get = myGetterFunc,
                width = 'full',
            },
            autoSellAllJunksToggle = {
                order = 5,
                type = 'toggle',
                name = 'Automatically sell all junks items',
                set = mySetterFunc,
                get = myGetterFunc,
                width = 'full',
            },
        }

        self.disabledoptions = {
            enabled = enabled,
        }
    end


    self.options = {
        order = 1,
        type = 'group',
        name = 'Vendors',
        arg = 'Vendors',
    }

    AlomawaniQoL.options.args.vendors = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end
