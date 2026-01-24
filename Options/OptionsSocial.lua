local _, AlomawaniQoL = ...

local Social = AlomawaniQoL:GetModule('Social')

local function myGetterFunc(info)
    return Social.db.profile[info[#info]]
end

local function mySetterFunc(info, value)
    Social.db.profile[info[#info]] = value
end

function Social:SetupOptions()
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
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 3,
		type = 'group',
		name = 'Social',
        childGroups = 'tab',
	}

    AlomawaniQoL.options.args.social.args.frame = self.options
    self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end
