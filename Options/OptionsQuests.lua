local _, AlomawaniUI = ...

local Quests = AlomawaniUI:GetModule('Quests')

local function myGetterFunc(info)
    return Quests.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    Quests.db.profile[info[#info]] = value
end

function Quests:SetupOptions()
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
                name = 'Frame',
                width = 'full',
            },
			customScaleValue = {
				order = 3,
				name = 'Custom scale value',
				desc = 'Configure the scale of the QuestsFrame. (Need a /reload)',
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
		name = 'Quests',
        childGroups = 'tab',
	}

    AlomawaniQoL.options.args.quests.args.frame = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end