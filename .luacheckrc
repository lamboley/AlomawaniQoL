std = "lua51"
max_line_length = false
exclude_files = {
	"Libs/",
	".luacheckrc"
}
ignore = {
	"11./SLASH_.*", -- Setting an undefined (Slash handler) global variable
	"11./BINDING_.*", -- Setting an undefined (Keybinding header) global variable
	"113/LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	"113/NUM_LE_.*", -- Accessing an undefined (Lua ENUM type) global variable
	"211", -- Unused local variable
	"211/L", -- Unused local variable "L"
	"211/CL", -- Unused local variable "CL"
	"212", -- Unused argument
	"213", -- Unused loop variable
	"214", -- unused hint
	-- "231", -- Set but never accessed
	"311", -- Value assigned to a local variable is unused
	"314", -- Value of a field in a table literal is unused
	"42.", -- Shadowing a local variable, an argument, a loop variable.
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	"542", -- An empty if branch
	"581", --  error-prone operator orders
	"582", --  error-prone operator orders
}
globals = {
	-- AlomawaniQoL
	"AlomawaniQoLData",

	-- Third Party
	"LibStub",

	-- WoW Namespaces
	"C_Container",
	"C_PetJournal",
	"C_Timer",

	-- WoW Frames
	"CHAT_FRAMES",
	"ChatFrame1",
	"DEFAULT_CHAT_FRAME",
	"GameTooltip",
	"LootFrame",
	"MicroButtonAndBagsBar",
	"ObjectiveTrackerFrame",
	"PlayerFrame",
	"QuickJoinToastButton",
	"UIParent",

	-- WoW Constants
	"CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA",
	"DEFAULT_CHATFRAME_ALPHA",
	"NUM_BAG_SLOTS",

	-- WoW Functions
	"CanMerchantRepair",
	"CreateFrame",
	"GetGuildInfo",
	"GetLocale",
	"GetNumLootItems",
	"GetPhysicalScreenSize",
	"GetSpecialization",
	"GetSpecializationRole",
	"GetTime",
	"InCombatLockdown",
	"IsInInstance",
	"IsStealthed",
	"LootSlot",
	"MouselookStart",
	"MouselookStop",
	"MuteSoundFile",
	"PlaySoundFile",
	"RegisterAttributeDriver",
	"RegisterStateDriver",
	"ReloadUI",
	"RepairAllItems",
	"SetCVar",
	"SlashCmdList",
	"UnitAffectingCombat",
	"hooksecurefunc",
	"time",
	"wipe",
}