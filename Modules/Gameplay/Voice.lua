---@type AlomawaniQoL
local AlomawaniQoL = select(2, ...)

-- Local API
local PlaySoundFile = PlaySoundFile
local tinsert = table.insert
local pairs = pairs
local time = time

---@class Voice : Frame
---@field OnEvent fun(self: Voice, event: WowEvent, ...: any)
local Voice = AlomawaniQoL.CreateModule("Voice", "PLAYER_DEAD")

---@type number
local lastSoundTime = 0

---@type number[]
local deathSounds = {
    -- Ilgynoth
    1360543, -- "You have failed those who needed you"
    1360544, -- "Your light sputters out"
    1360545, -- "Welcome death. Do not fight it"
    -- Y'Shaarj
    901523,  -- "With each thread unravel, a step closer to my realm"
    901525,  -- "Another blemish on your soul"
    901527,  -- "You will rest in Ny'alotha"
    -- Xal'atath
    1391162, -- Delicious
    1391163, -- Every little death helps
    1391164, -- Enjoy that?
    1391165, -- Boring
    1391167, -- *Long laugh*
    1391194, -- *Short laugh*
    -- Yogg-Saron
    564844,  -- "Your will is no longer your own"
}

---@param _ WowEvent
---@param ... any
function Voice:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] then
        return
    end

    local currentTime = time()
    if (currentTime - lastSoundTime) <= 10 then
        return
    end

	local soundFile = deathSounds[math.random(1, #deathSounds)]

	local willPlay = PlaySoundFile(soundFile , 'Master', true, false)
	if willPlay then
		AlomawaniQoL.Debug("Played death sound:", soundFile)
		lastSoundTime = currentTime
	else
		AlomawaniQoL.Debug("Failed to play death sound:", soundFile)
	end
end

AlomawaniQoL.Gameplay.Voice = Voice
