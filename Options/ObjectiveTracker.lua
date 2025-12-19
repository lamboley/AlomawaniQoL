local _, AlomawaniUI = ...

local ObjectiveTracker = AlomawaniUI:GetModule('ObjectiveTracker')

local function myGetterFunc(info)
    return ObjectiveTracker.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    ObjectiveTracker.db.profile[info[#info]] = value
end

function ObjectiveTracker:SetupOptions()
	if not self.modulesoptions then
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
                name = 'Layout',
                width = 'full',
            },
			customScaleValue = {
				order = 3,
				name = 'Custom scale value',
				desc = 'Configure the scale of the ObjectiveTrackerFrame. (Need /reload)',
				type = "range",
				min = 0.01, softMin = .1, softMax = 2, bigStep = 0.05,
				get = myGetterFunc,
				set = mySetterFunc,
			},
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 2,
		type = 'group',
		name = 'ObjectiveTracker',
        childGroups = 'tab',
	}

    AlomawaniQoL.options.args.frames.args.ObjectiveTracker = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end