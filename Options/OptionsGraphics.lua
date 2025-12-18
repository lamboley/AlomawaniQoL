local _, AlomawaniQoL = ...
local Graphics = AlomawaniQoL:GetModule('Graphics')

local myGetterFunc, mySetterFunc
do
	function myGetterFunc(info)
		return Graphics.db.profile[info[#info]]
	end

	function mySetterFunc(info, value)
		Graphics.db.profile[info[#info]] = value
	end
end

function Graphics:SetupOptions()
	if not self.options then
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
				dialogControl = 'EditBox',
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
				dialogControl = 'EditBox',
			},
			-- cameraZoomValue = {
			-- 	order = 6,
			-- 	name = 'Zoom value',
			-- 	desc = 'Configure the max camera zoom value',
			-- 	type = 'range',
			-- 	min = 0.1, max = 3, softMin = 0.1, softMax = 2.6, bigStep = 0.1,
			-- 	get = myGetterFunc,
			-- 	set = mySetterFunc,
			-- },
		}

		self.disabledoptions = {
			enabled = enabled,
		}
	end

	self.options = {
		order = 1,
		type = 'group',
		name = 'Graphics',
        childGroups = 'tab',
	}

	AlomawaniQoL.options.args.system.args.Graphics = self.options
	self.options.args = self:IsEnabled() and self.modulesoptions or self.disabledoptions
end